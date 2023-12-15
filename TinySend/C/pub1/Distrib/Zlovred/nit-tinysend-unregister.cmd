@echo off
rem *******************************************************
rem nit-tinysend-register.cmd
rem This Script will Unegister a Schedule Task for 
rem TinySend Command via Command Line
rem
rem PARAMETERS:	NONE
rem RETURNS:	0 if Script Success Run
rem		1 if Check Integrity Error
rem		2 if Task Cannot be Created
rem		17 if Script Runs without Elevated Privileges
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Set a Directoryrem Metadata

set PRODUCT_NAME=TinySend
set REDACT=
set FIRM=NIT

rem

set CURDIR=%CD%
set SCRIPTDIR=%~dp0

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set a Variables
rem

rem Set Paths...
rem

set pathCMD=%SystemRoot%\system32
set SCHPROGPATH=d:\yuden
set ZLOVRED=C:\pub1\Distrib\Zlovred

rem Set a File
rem
set SCHEDEXE=%pathCMD%\schtasks.exe
set SCHBAT=%SCHPROGPATH%\time_stamp_00.bat
set SCHWSF=%ZLOVRED%\TinySendRun.wsf
set WSCRIPTEXE=%pathCMD%\wscript.exe

Rem Set Other Variables
rem
set SCHTASKNAME=%FIRM%\NIT_TINYSEND
set SCHBATCMD="%COMSPEC% /c %SCHBAT%"
set SCHWSFCMD="%WSCRIPTEXE% //NoLogo //B %SCHWSF%"

echo Check System Integrity...
rem
if not exist %SCHEDEXE% echo %SCHEDEXE% is not found && exit /b 1
rem if not exist %SCHBAT% echo %SCHBAT% is not found && exit /b 1
if not exist %SCHWSF% echo %SCHWSF% is not found && exit /b 1

echo Download and Run Payload..
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
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%TPDL%\%getadminvbs%"

    %wscriptexe% "%TPDL%\%getadminvbs%"
    del "%TPDL%\%getadminvbs%"
    exit /B 0

:gotAdmin
echo Run as Admin...

echo Run Payloads...
rem
rem %SCHEDEXE% /CREATE /Sc ONSTART /Tn %SCHTASKNAME% /Tr %SCHBATCMD% /Ru system /DELAY 0000:00 /F
%SCHEDEXE% /Delete /Tn %SCHTASKNAME% /F
if %errorlevel% neq 0 goto Error_Sched
goto End

:Error_Sched
echo Error at Script %0! Task is not Deleted
exit /b 2

:End
echo Script %0 is Terminated Successfully!
exit /b 0