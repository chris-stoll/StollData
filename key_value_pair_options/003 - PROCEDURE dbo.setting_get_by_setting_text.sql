

CREATE OR ALTER PROCEDURE dbo.setting_get_by_setting_text
(
	@setting_text NVARCHAR(500) = NULL
)
AS
BEGIN
	DECLARE @setting_column_list NVARCHAR(MAX) = '';
	SELECT @setting_column_list = STRING_AGG(QUOTENAME(s.setting_text), ',') FROM dbo.setting s WHERE (@setting_text IS NULL OR s.setting_text = @setting_text)

	DECLARE @dSQL NVARCHAR(MAX) = '
		SELECT ' + @setting_column_list + '
		FROM 
		(
			SELECT s.setting_text, s.setting_value
			FROM dbo.setting s
		) as source_table
		PIVOT
		(
			MAX(setting_value)
			FOR setting_text IN (' + @setting_column_list + ')
		) as pivot_table'


	EXEC (	@dSQL)

END