@echo off
rem *******************************************************
rem getExtIp.TinySend.cmd
rem This Script Gets an System and Net Info and Saves it
rem at Text File
rem
rem PARAMETERS %1 is a Text File
rem RETURNS: always 0
rem *******************************************************
@echo off

rem

rem
rem Set localfile...
set localfile=%1

echo ===***===***=== >> %localfile%
systeminfo.exe >> %localfile%
echo ===***===***=== >> %localfile%
ipconfig.exe /all >> %localfile%

exit /b 0
