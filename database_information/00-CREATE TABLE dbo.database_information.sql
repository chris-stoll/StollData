CREATE TABLE dbo.database_information(
	database_information_id INT NOT NULL IDENTITY(1,1)
		CONSTRAINT pk_dbo_database_information PRIMARY KEY CLUSTERED(database_information_id)
	,created_on DATETIME2 NOT NULL	
		CONSTRAINT df_dbo_database_information_created_on DEFAULT(SYSDATETIME())
	,database_id INT NOT NULL
	,database_name NVARCHAR(128) NOT NULL
	,state_desc NVARCHAR(100) NULL
	,recovery_model_desc NVARCHAR(100) NULL
	,total_size_mb DECIMAL(18,2) NULL
	,data_size_mb DECIMAL(18,2) NULL
	,data_used_size_mb DECIMAL(18,2) NULL
	,log_size_mb DECIMAL(18,2) NULL
	,log_used_size_mb DECIMAL(18,2) NULL
	,full_last_backup_on DATETIME NULL
	,full_backup_size_mb DECIMAL(18,2) NULL
	,log_last_backup_on DATETIME NULL
	,log_backup_size_mb DECIMAL(18,2) NULL
);


CREATE INDEX ix_dbo_database_information_created_on ON dbo.database_information(created_on);
CREATE INDEX ix_dbo_database_information_database_name ON dbo.database_information(database_name);
