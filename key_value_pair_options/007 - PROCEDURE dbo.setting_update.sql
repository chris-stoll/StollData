CREATE OR ALTER PROCEDURE dbo.setting_update
(
	 @setting_text NVARCHAR(500)
	,@setting_value NVARCHAR(MAX)
)
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY;
		--Validation
		IF NOT EXISTS(SELECT NULL FROM dbo.setting s where s.setting_text = @setting_text)
			THROW 50000, 'input @setting_text does not exist', 1;

		IF @setting_value IS NULL
			THROW 50000, 'input @setting_value is null', 1;



		UPDATE s
		SET s.setting_value = @setting_value
		FROM dbo.setting s
		WHERE s.setting_text = @setting_text
			AND NOT EXISTS(SELECT s.setting_value INTERSECT SELECT @setting_value);

	END TRY
	BEGIN CATCH

		THROW;

	END CATCH;
END
GO