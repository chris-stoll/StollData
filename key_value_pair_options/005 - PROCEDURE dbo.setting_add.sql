CREATE OR ALTER PROCEDURE dbo.setting_add
(
	 @setting_id INT
	,@setting_text NVARCHAR(500)
	,@setting_value NVARCHAR(MAX)
)
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY;
		--Validation
		IF EXISTS(SELECT NULL FROM dbo.setting s where s.setting_id = @setting_id)
			THROW 50000, 'input @setting_id already exists', 1;
			
		IF EXISTS(SELECT NULL FROM dbo.setting s where s.setting_text = @setting_text)
				THROW 50000, 'input @setting_text already exists', 1;


		IF @setting_value IS NULL
				THROW 50000, 'input @setting_value is null', 1;



		INSERT INTO dbo.setting(setting_id, setting_text, setting_value)
		VALUES 
			(@setting_id, @setting_text, @setting_value);

	END TRY
	BEGIN CATCH

		THROW;

	END CATCH;
END
GO