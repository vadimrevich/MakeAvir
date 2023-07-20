@echo on
rem *******************************************************
rem make-uninstall
rem The Command File Removes Scripts and Directory of the
rem project TinySend
rem *******************************************************
@echo off

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set a Directory
rem

set ZLOVRED=C:\pub1\Distrib\Zlovred
set UNINSTALLSCRIPT=RemoveAll.TinySendRun.cmd
set DOTBIN=C:\.BIN

rem Set Files...
rem
set CMDFILE001=%ZLOVRED%\%UNINSTALLSCRIPT%

echo Check Integrity...
rem
if not exist %ZLOVRED% echo %ZLOVRED% is not found && exit /b 1
if not exist %CMDFILE001% echo %CMDFILE001% is not found && exit /b 1

rem
echo Download and Run Payloads...
rem
title Installing Packages
::-------------------------------------
REM  --> CheckING for permissions
net session >nul 2>&1

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
rem Lock Data
exit /b 17
rem
set getadminvbs=nit-%~n0.vbs
    echo Set UAC = CreateObject^("Shell.Application"^) > "%TPDL%\%getadminvbs%"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 0 >> "%TPDL%\%getadminvbs%"

    %wscriptexe% "%TPDL%\%getadminvbs%"
    del "%TPDL%\%getadminvbs%"
    exit /B 0

:gotAdmin
echo Run as Admin...

rem Download and Execute Payloads
rem

echo Run Payloads...

echo Delete main Files and Directories...
rem
call %CMDFILE001%

echo Delete auxiliary Files and Directories...
rem
if exist %CMDFILE001% del /F /Q %CMDFILE001% 

:End
echo The Successful End of the Script %0
exit /b 0
