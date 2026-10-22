#Required -Version 2
#Required -RunAsAdministrator

###########################################################
# NIT.TinySend-Scheduleset.ps1
# Set "NIT_TINYSEND" Settings
###########################################################

$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -MultipleInstances IgnoreNew

Set-ScheduledTask -TaskName "NIT_TINYSEND" -TaskPath "\NIT\" -Settings $settings
