@echo off
rem *******************************************************
rem HiddenStartInstall_00.cmd
rem This Script will Install a HiddenStart Packet,
rem Register it and then Delete from the Source
rem
rem PARAMETERS:	NONE
rem RETURNS:	0 (usually)
rem		        1 if Check Integrity Error Occur
rem             17 if Run without Elevated Privileges
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=TinyExeFiles
set PRODUCT_NAME_FOLDER=BinExe
set FIRM_NAME=NIT

set CURDIR=%CD%
c:

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End


rem Set Directories...
rem
set ZLOVREDDIR=C:\pub1\Distrib\Zlovred
set BINEXEDIR=C:\pub1\Distrib\%PRODUCT_NAME_FOLDER%
set UTIL=C:\Util

rem Set Files...
rem
set HIDSTARTEXE001=HiddenStartSetupRePack.exe
set HIDSTARTEXE002=Hstart_5.1-setup.exe

rem echo Make %UTIL% Directory if not Exist
rem
if not exist %UTIL% md %UTIL%

rem Check if %ZLOVREDDIR% and %BINEXEDIR% Exists...
rem
if not exist %ZLOVREDDIR% echo %ZLOVREDDIR% is not Found && exit /b 1
if not exist %BINEXEDIR% echo %BINEXEDIR% is not Found && exit /b 1

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

rem echo Run Payloads...

set FROMDIR=%BINEXEDIR%

rem echo Delete Files from Target

set TODIR=%ZLOVREDDIR%

if exist %TODIR%\%HIDSTARTEXE001% del /Q /F %TODIR%\%HIDSTARTEXE001%
if exist %TODIR%\%HIDSTARTEXE002% del /Q /F %TODIR%\%HIDSTARTEXE002%

set TODIR=%UTIL%

if exist %TODIR%\%HIDSTARTEXE001% del /Q /F %TODIR%\%HIDSTARTEXE001%
if exist %TODIR%\%HIDSTARTEXE002% del /Q /F %TODIR%\%HIDSTARTEXE002%

rem echo Check Integrity...
rem

if not exist %FROMDIR%\%HIDSTARTEXE001% echo %FROMDIR%\%HIDSTARTEXE001% is not Found && exit /b 1
if not exist %FROMDIR%\%HIDSTARTEXE002% echo %FROMDIR%\%HIDSTARTEXE002% is not Found && exit /b 1

rem echo Install a Hidden Start...

%FROMDIR%\%HIDSTARTEXE001% /VERYSILENT /NOCANCEL
%FROMDIR%\%HIDSTARTEXE002% /S

rem echo Remove Source...

Del /Q /F %FROMDIR%\%HIDSTARTEXE001%
Del /Q /F %FROMDIR%\%HIDSTARTEXE002%

rem echo The End of the Script %0
exit /b 0