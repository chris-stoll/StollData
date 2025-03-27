
--Successes

--Only succeeds the first time. Any subsequent runs will fail
EXEC dbo.setting_add
	@setting_id = 5
	,@setting_text = 'mouse_enabled'
	,@setting_value = 'true';




--Failures
EXEC dbo.setting_add
	 @setting_id = 5
	,@setting_text = 'mouse_enabled'
	,@setting_value = 'true';

EXEC dbo.setting_add
	 @setting_id = 999
	,@setting_text = 'mouse_enabled'
	,@setting_value = 'true';

EXEC dbo.setting_add
	 @setting_id = 999
	,@setting_text = 'new_setting'
	,@setting_value = NULL;
