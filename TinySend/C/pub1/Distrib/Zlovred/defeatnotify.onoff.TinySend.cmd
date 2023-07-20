@echo on
rem *******************************************************
rem defeatnotify.onoff.TinySend.cmd
rem When Parameter %1 of the Script is On, Turns on
rem the All Defeat Notification at Computer Startup, and
rem Turns Off Notification when Parameter is off
rem *******************************************************
@echo off

rem
rem Set Command Files..
rem
set CMDMAIN=%~dp0RunFile.001.TinySend.cmd
set CMDFILEA=%~dp0RunFile.001.a.TinySend.cmd
set CMDFILEB=%~dp0RunFile.001.b.TinySend.cmd

echo Check Integrity...
rem
if not exist %CMDMAIN% echo %CMDMAIN% is not found && exit /b 1
if not exist %CMDFILEA% echo %CMDFILEA% is not found && exit /b 1
if not exist %CMDFILEB% echo %CMDFILEB% is not found && exit /b 1

rem
rem Check Valid options...
rem
if [%1]==[] goto Lab_ParError

if %1==On goto Lab_On
if %1==on goto Lab_On
if %1==off goto Lab_Off
if %1==Off goto Lab_Off

goto Lab_ParError

:Lab_ParError
echo Error! Empty Parameter or Wrong Parameter Value.
echo "USAGE: defeatnotify.onoff.TinySend.cmd On|Off"
echo Script %0 is Terminated.
exit /b 1

:Lab_On
echo Turn on The Notification
copy /Y /V %CMDFILEA% %CMDMAIN%
goto End

:Lab_Off
echo Turn off the Notification
copy /Y /V %CMDFILEB% %CMDMAIN%
goto End

:End
echo The Success Script %0 Termination
exit /b 0


