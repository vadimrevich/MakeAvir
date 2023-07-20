@echo off
rem *******************************************************
rem This Part of Script Makes a Header of the File
rem *******************************************************
rem

rem Rem Set Temp File
rem
rem set aTEMPTEXTFILE=%~dp0aTempTextContainer.TinySendRun.tmp.txt
set aTEMPTEXTFILE=%1

echo %aTEMPTEXTFILE% > %aTEMPTEXTFILE%
echo "" >> %aTEMPTEXTFILE%
echo "This file start when Computer System is Started or Rebooted" >> %aTEMPTEXTFILE%
echo "Date & Time Started and Rebooted: %DATE% & %TIME%" >> %aTEMPTEXTFILE%
echo "User: %USERNAME%, Computer: %COMPUTERNAME%, Domain: %USERDOMAIN%." >> %aTEMPTEXTFILE%
echo " === *** === *** === " >> %aTEMPTEXTFILE%
echo "" >> %aTEMPTEXTFILE%

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


rem
rem Test Files ...
rem
rem type %aTEMPTEXTFILE%
rem pause
rem del %aTEMPTEXTFILE%
rem

rem Send file...
rem
set CMDFILE01=%~dp0sendRun.TinySend.cmd
if not exist %CMDFILE01% echo %CMDFILE01% is not found && goto LAB_CMDEND02
call %CMDFILE01% %aTEMPTEXTFILE%
:LAB_CMDEND02
set CMDFILE01=

exit /b 0