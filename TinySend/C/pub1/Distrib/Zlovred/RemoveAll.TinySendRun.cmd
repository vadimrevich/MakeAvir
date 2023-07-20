@echo off
rem *******************************************************
rem RemoveAll.TinySendRun.1.cmd
rem This Script Remove all TynySendRun Scripts
rem The Script must be Run with Elevated Privileges (not Checked)
rem
rem PARAMETERS:	NONE
rem RETURNS:	0 (usually)
rem *******************************************************
@echo off

rem
rem Set Zlovred Folder...
rem
set ZLOVDER=C:\pub1\Distrib\Zlovred
set CHWSF=TinySendRun.wsf
set PATHCMD=%SystemRoot%\System32
rem

rem
rem Set a Prefix...
rem
set aPrefix2=TinySendRun
rem
set aPrefix1=DnRn
rem
rem
rem Set Suffix...
rem

rem Set Registry Node
set RegNode01=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
set RegNode02=HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run
rem
if not exist %ZLOVDER% echo %ZLOVDER% folder has already deleted && exit /b 0
if not exist "%PATHCMD%" echo "%PATHCMD% not Exists" && exit /b 1
if not exist "%PATHCMD%\reg.exe" echo "%PATHCMD%\reg.exe not Exists" && exit /b 1

rem Desactivate Startup Run...
"%PATHCMD%\reg.exe" DELETE %RegNode01% /v %CHWSF% /f
"%PATHCMD%\reg.exe" DELETE %RegNode02% /v %CHWSF% /f

rem
echo Delete Scripts...
rem
del /Q /F %ZLOVDER%\TinySendRun.*.cmd
del /Q /F %ZLOVDER%\TinySend-Setup.cmd
del /Q /F %ZLOVDER%\TinySendRun.cmd
del /Q /F %ZLOVDER%\TinySendRun.wsf
del /Q /F %ZLOVDER%\TinySendRun.*.bat
del /Q /F %ZLOVDER%\*.TinySend.cmd
del /Q /F %ZLOVDER%\*.TinySend.bat
del /Q /F %ZLOVDER%\%aPrefix1%-%aPrefix2%-*.bat

exit /b 0
