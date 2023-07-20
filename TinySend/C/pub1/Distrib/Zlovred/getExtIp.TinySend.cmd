@echo off
rem *******************************************************
rem getExtIp.TinySend.cmd
rem This Script Gets an External IP Address and Saves it
rem at Text File
rem
rem PARAMETERS %1 is a Text File
rem RETURNS: always 0
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

echo ===***===***=== >> %localfile%
echo External IP: >> %localfile%
"%CURLEXE%" http://ifconfig.me/ip >> %localfile%
echo External IPv4: >> %localfile%
"%CURLEXE%" 2ip.ua >> %localfile%
echo External IPv6: >> %localfile%
"%CURLEXE%" 2ip.com.ua >> %localfile%

exit /b 0