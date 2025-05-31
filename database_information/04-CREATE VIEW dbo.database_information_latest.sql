/*
	Created By: Chris Stoll
	Created On: 5/31/2025
	Descrption:
		- outputs latest information about databases
	Notes:
	
	Change History:
		- 5/31/2025: initial creation


*/
CREATE OR ALTER VIEW [dbo].[database_information_latest]
AS
WITH latest
AS
(
	SELECT database_name, [created_on] = MAX(created_on)
	FROM dbo.database_information i
	GROUP BY i.database_name
)
SELECT 
	d.database_information_id,
    d.created_on,
    d.database_id,
    d.database_name,
    d.state_desc,
    d.recovery_model_desc,
    d.total_size_mb,
    d.data_size_mb,
    d.data_used_size_mb,
    d.log_size_mb,
    d.log_used_size_mb,
    d.full_last_backup_on,
    d.full_backup_size_mb,
    d.log_last_backup_on,
    d.log_backup_size_mb
FROM dbo.database_information d
JOIN latest cte
	ON d.database_name = cte.database_name
	AND d.created_on = cte.created_on;
GO