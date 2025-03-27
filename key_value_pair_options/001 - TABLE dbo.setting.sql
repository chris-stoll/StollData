
CREATE TABLE dbo.setting(
	 setting_id INT NOT NULL
		CONSTRAINT pk_dbo_setting PRIMARY KEY CLUSTERED (setting_id)
	,setting_text NVARCHAR(500) NOT NULL
		CONSTRAINT uq_dbo_setting_setting_text UNIQUE(setting_text)
	,setting_value NVARCHAR(MAX) NOT NULL
	,updated_on DATETIME2 NOT NULL
		CONSTRAINT df_dbo_setting_updated_on DEFAULT(SYSDATETIME())
);



