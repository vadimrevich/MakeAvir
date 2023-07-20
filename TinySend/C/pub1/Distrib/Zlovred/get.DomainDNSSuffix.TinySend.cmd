@echo off
rem *******************************************************
rem get.DomainDNSSuffix.cmd
rem This Script Gets User Domain and Main DNS Suffix
rem and Prints on at Console
rem
rem PARAMETERS:	NONE
rem RETURNS: 	0 (usually)
rem		1 if Check Integrity Error
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem
rem Set System Files,,,
rem
set REGEXE=%SystemRoot%\System32\reg.exe
set FINDEXE=%SystemRoot%\System32\find.exe
rem
rem Set Registry Key and Node
rem
set regnode01="HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
set regkey02=Domain
rem set regkey02=qwerty
rem

rem echo Check Integrity...
rem
if not exist %REGEXE% echo %REGEXE% is not found && exit /b 1
if not exist %FINDEXE% echo %FINDEXE% is not found && exit /b 1
rem

rem echo Check if DNS Suffix Exist...
rem Check if Node Exist
%REGEXE% QUERY %regnode01% 2>&1 >nul
if ERRORLEVEL 1 echo Node %regnode01% does not exist && exit /b 1
rem
rem Check if Suffix Exist and Set Variables
rem
for /f "tokens=3" %%i in (
	'2^>nul %REGEXE% query "%regnode01%" /v "%regkey02%"^|%FINDEXE% /i "%regkey02%"'
) do set DNSSUFFIX=%%i

if defined DNSSUFFIX (
	goto Lab_Present
) else (
	goto Lab_Empty
)

:Lab_Present
set USERDNS0=%USERDOMAIN%.%DNSSUFFIX%
goto Lab_End_USERDNS0

:Lab_Empty
set USERDNS0=%USERDOMAIN%
goto Lab_End_USERDNS0

:Lab_End_USERDNS0
echo %USERDNS0%

exit /b 0

