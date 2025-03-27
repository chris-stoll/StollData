
SELECT * FROM dbo.setting s

EXEC dbo.setting_get_by_setting_text


EXEC dbo.setting_get_by_setting_text @setting_text = 'is_working'


EXEC dbo.setting_get_by_setting_text @setting_text = 'does_not_exist'

