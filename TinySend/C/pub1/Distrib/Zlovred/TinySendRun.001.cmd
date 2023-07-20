@echo on
rem *******************************************************
rem This Part of the Script Fakes File Prefixes and Suffixes
rem *******************************************************
rem
set aPrefix2=TinySendRun
rem
set aPrefix1=Reboot

rem Set User Computer Name suffix1
rem
set aSuffix1=%USERNAME%@%COMPUTERNAME%@%USERDOMAIN%
rem
rem Set a Suffix 2 with Datatime
rem
set CMDFILE01=%~dp0getBootDateTime.TinySend.cmd
if not exist %CMDFILE01% echo %CMDFILE01% not found && exit /b 1
FOR /F "delims=" %%i IN ('%CMDFILE01%') DO set aSuffix2=%%i
set CMDFILE01=
rem
rem Set a USERDNS0 Variable...
rem
set CMDFILE02=%~dp0get.DomainDNSSuffix.TinySend.cmd
if not exist %CMDFILE02% echo %CMDFILE02% not found && exit /b 1
FOR /F "delims=" %%i IN ('%CMDFILE02%') DO set USERDNS0=%%i
set CMDFILE02=
rem
rem Set a Suffix 3 with Computer DNS
rem
set aSuffix3=%COMPUTERNAME%@%USERDNS0%
rem



rem Set File Extension...
rem
set anExtension=log

rem
rem Set Full Temporary File Name...
rem
rem set TEMPLOGFILENAME=%aPrefix1%-%aPrefix2%-%aSuffix1%-%aSuffix2%.%anExtension%
rem set TEMPLOGFILENAME=%aPrefix1%-%aPrefix2%-%aSuffix1%.%anExtension%
set TEMPLOGFILENAME=%aPrefix1%-%aPrefix2%-%aSuffix3%.%anExtension%

rem
rem Test File....
rem
rem echo %aSuffix2% > %~dp0%TEMPLOGFILENAME%
rem

rem
set CMDFILE01=%~dp0TinySendRun.002.cmd
if not exist %CMDFILE01% echo %CMDFILE01% is not found && goto LAB_CMDEND01
call %CMDFILE01% %TEMPLOGFILENAME%
del %TEMPLOGFILENAME%
:LAB_CMDEND01
set CMDFILE01=

exit /b 0

