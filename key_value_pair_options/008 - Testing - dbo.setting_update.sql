

--Successes
EXEC dbo.setting_update
	 @setting_text = 'mouse_enabled'
	,@setting_value = 'true';



--Failures
EXEC dbo.setting_update
	 @setting_text = NULL
	,@setting_value = 'true';

EXEC dbo.setting_update
	 @setting_text = 'does_not_exist'
	,@setting_value = 'true';

EXEC dbo.setting_update
	 @setting_text = 'mouse_enabled'
	,@setting_value = NULL;