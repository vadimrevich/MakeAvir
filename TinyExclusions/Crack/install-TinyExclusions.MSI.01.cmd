@echo off

set CURDIR=%CD%
%~d0
cd %~p0
rem cd ..

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set a Directory
rem

set ZLOVRED=C:\pub1\Distrib\Zlovred
set INSTALLSCRIPT=PostInstall.TinyExclusions.vbs
set aMSG=%~dp0Msg.TinyExclusions.Install.Success.wsf
set DOTBIN=C:\.BIN

rem Set Files...
rem
set CMDFILE001=%ZLOVRED%\%INSTALLSCRIPT%
set POSHEXE=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe
set WSCRIPTEXE=%SystemRoot%\System32\wscript.exe
set MSIEXECEXE=%SystemRoot%\System32\msiexec.exe

echo Check System Integrity...
rem
if not exist %POSHEXE% echo %POSHEXE% is not found && exit /b 1
if not exist %WSCRIPTEXE% echo %WSCRIPTEXE% is not found && exit /b 1
if not exist %MSIEXECEXE% echo %MSIEXECEXE% is not found && exit /b 1

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

set SFXARCH=TinyExclusionsInstaller.msi
set SFXNAME="NIT-TinyExclusions"
set IDENT="{FA5D224A-0CFA-4D04-9FA6-6037C6A84173}"
@echo ProduvtID = %IDENT%
set FOLDER=.
if not exist "%FOLDER%\%SFXARCH%" goto Error
rem
echo Uninstall Previous Copy...
rem
rem %POSHEXE% -NoLogo -NoProfile -ExecutionPolicy Bypass -Command "(CimInstance -Class Win32_Product | Where-Object{$_.Name -match '%SFXNAME%'}).Uninstall"
%MSIEXECEXE% /x %IDENT% /qn /quiet
rem
echo Install %SFXARCH%...
rem
%MSIEXECEXE% /i %SFXARCH% /qn /quiet /norestart /L*V %TPDL%\%SFXARCH%.log
rem %MSIEXECEXE% /i %SFXARCH% /qf /L*V %TPDL%\%SFXARCH%.log
goto Finish
:Error
echo "File %FOLDER%\%SFXARCH% not found" && exit /b 1
rem pause
:Finish

echo Check Integrity...
rem
if not exist %ZLOVRED% echo %ZLOVRED% is not found && exit /b 1
if not exist %CMDFILE001% echo %CMDFILE001% is not found && exit /b 1

rem Download and Execute Payloads
rem

echo Run Payloads...

%WSCRIPTEXE% //NoLogo %CMDFILE001%

cd /d %CURDIR%
if exist %aMSG% Start %aMSG%

echo The End of the script %0
exit /b 0