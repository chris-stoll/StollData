/*
	Created By: Chris Stoll
	Created On: 12/21/2018
	Descrption:
		- output HTML table of sql table
	Notes:
	Change History:
		- 12/21/2018: initial creation


	Example:
		DECLARE @body_output NVARCHAR(MAX);
		EXEC dbo.table_to_html 
			 @table_input = 'dbo.product_grocery'
			,@body_output = @body_output OUTPUT;
		select @body_output;


*/
CREATE OR ALTER PROCEDURE dbo.table_to_html
(
	 @table_input NVARCHAR(500)
	,@body_output NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON;
	IF OBJECT_ID('tempdb..#Columns_table_input') IS NOT NULL
		DROP TABLE #Columns_table_input;


	CREATE TABLE #Columns_table_input (ColumnName VARCHAR(128), ColumnOrder INT NOT NULL PRIMARY KEY);
	
	DECLARE @columnQuery VARCHAR(MAX) = 'INSERT INTO #Columns_table_input (ColumnName, ColumnOrder) select name, Column_id from {db}sys.columns where object_id =object_id(''{table}'')';
	IF PATINDEX('%#%', @table_input) > 0
	BEGIN
		SELECT @columnQuery	= REPLACE(@columnQuery, '{table}', 'tempdb..' + @table_input);
		SELECT @columnQuery	= REPLACE(@columnQuery, '{db}', 'tempdb.');
	END;
	ELSE
	BEGIN 
		SELECT @columnQuery	= REPLACE(@columnQuery, '{table}', @table_input);	
		SELECT @columnQuery	= REPLACE(@columnQuery, '{db}', '');	
	END;
	--PRINT @columnQuery
	
	EXEC(@columnQuery);

	DECLARE @OrderedByexternal_order_id BIT = 0
	IF EXISTS(SELECT c.ColumnName FROM #Columns_table_input c WHERE c.ColumnName = 'external_order_id')
		SET @OrderedByexternal_order_id = 1;

	DECLARE @HeaderList VARCHAR(MAX);

	SELECT @HeaderList= STUFF((
								SELECT '<th>' + ColumnName + '</th>'
								FROM #Columns_table_input
								WHERE ColumnName <> 'external_order_id'
								ORDER BY ColumnOrder
								FOR XML PATH('')
								),1,1,'');

	SELECT @HeaderList = REPLACE(REPLACE( REPLACE( @HeaderList, '&lt;', '<' ), '&gt;', '>' ), 'lt;', '<');
	
	--PRINT 'Header: ' + @HeaderList;
	
	DECLARE @OuterList VARCHAR(MAX);

	SELECT @OuterList= STUFF((
						SELECT ' [' + ColumnName + '] + ''</td><td>'' + '
						FROM #Columns_table_input
						WHERE ColumnName <> 'external_order_id'
						ORDER BY ColumnOrder
						FOR XML PATH('')
						),1,1,'');

	--PRINT @OuterList;
	SELECT @OuterList = REPLACE(REPLACE( REPLACE( @OuterList, '&lt;', '<' ), '&gt;', '>' ), 'lt;', '<');
	--PRINT @OuterList;
	SELECT @OuterList = LEFT(@OuterList, LEN(@OuterList) - 16); --Strips off last " + '</td><td>' "
	--PRINT @OuterList;
	
	--PRINT 'OuterList: ' + @OuterList;

	DECLARE @columnList VARCHAR(MAX);
	SELECT @columnList = STUFF((
								SELECT ',[' + ColumnName  +'] = ISNULL(CAST([' + ColumnName + '] AS VARCHAR(MAX)), '''')'
								FROM #Columns_table_input
								--WHERE ColumnName <> 'external_order_id'
								ORDER BY ColumnOrder
								FOR XML PATH('')
								),1,1,'');

	--PRINT 'ColumnList: ' + @columnList;

	IF OBJECT_ID('tempdb..#Columns_table_input') IS NOT NULL
		DROP TABLE #Columns_table_input;

	DECLARE @sqlCommand NVARCHAR(MAX)= '
set @body_output = cast( (

select td = {outerlist}

from (

      select {columnlist}

      from {tablename}

      ) as d
{ExternalOrdering}
for xml path( ''tr'' ), type ) as varchar(max) )

 

set @body_output = ''<table cellpadding="2" cellspacing="2" border="1">''

              + ''<tr>{headerlist}</tr>''

              + replace( replace( @body_output, ''&lt;'', ''<'' ), ''&gt;'', ''>'' )

              + ''</table>''
';


	SET @sqlCommand = REPLACE(@sqlCommand, '{headerlist}', @HeaderList);
	SET @sqlCommand = REPLACE(@sqlCommand, '{columnlist}', @columnList);
	SET @sqlCommand = REPLACE(@sqlCommand, '{outerlist}', @OuterList);
	SET @sqlCommand = REPLACE(@sqlCommand, '{tablename}', @table_input);
	
	IF @OrderedByexternal_order_id = 1
		SET @sqlCommand = REPLACE(@sqlCommand, '{ExternalOrdering}', 'ORDER BY CAST(external_order_id AS INT)')
	ELSE 
		SET @sqlCommand = REPLACE(@sqlCommand, '{ExternalOrdering}', '');

	--PRINT @sqlcommand
	EXECUTE sp_executesql @sqlCommand, N'@body_output varchar(max) OUTPUT', @body_output = @body_output	OUTPUT;


	
END;
GO