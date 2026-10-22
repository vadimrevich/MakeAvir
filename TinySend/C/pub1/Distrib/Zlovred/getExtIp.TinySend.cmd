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
echo. >> %localfile%
echo External IP: >> %localfile%
"%CURLEXE%" http://ifconfig.me/ip >> %localfile% 2>nul
echo. >> %localfile%
echo External IPv4: >> %localfile%
rem "%CURLEXE%" 2ip.ua >> %localfile%
"%CURLEXE%" -4 icanhazip.com  >> %localfile% 2>nul
echo External IPv6: >> %localfile%
rem "%CURLEXE%" 2ip.com.ua >> %localfile%
"%CURLEXE%" -6 icanhazip.com >> %localfile% 2> nul
rem Set an IP as Variable
FOR /F "tokens=* USEBACKQ" %%F IN (`%CURLEXE% -4 icanhazip.com`) DO (
SET anIPV4=%%F
)
FOR /F "tokens=* USEBACKQ" %%F IN (`%CURLEXE% -6 icanhazip.com`) DO (
SET anIPV6=%%F
)
rem Get Info about IP
rem
echo. >> %localfile% 2> nul
echo an IPv4 Data: >> %localfile%
"%CURLEXE%" http://ipwho.is/%anIPV4% >> %localfile% 2> nul
echo.  >> %localfile% 2> nul
echo an IPv6 Data: >> %localfile%
"%CURLEXE%" http://ipwho.is/%anIPV6% >> %localfile% 2> nul

exit /b 0