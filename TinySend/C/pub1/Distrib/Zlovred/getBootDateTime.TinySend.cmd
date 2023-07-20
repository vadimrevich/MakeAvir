@echo on
rem *******************************************************
rem getBootDateTime.TinySend.cmd
rem This Script Gets Date and Time in special Format
rem and Put it onto Concole
rem PPARAMETERS:	NONE
rem RETURNS:	0 always
rem *******************************************************
echo off

rem Get Current Date and Time
rem
set CURDATE=%DATE%
set CURTIME=%TIME%

rem Set DateTime Suffix...
rem
set newSuffix2=%CURDATE:~8,2%%CURDATE:~3,2%%CURDATE:~0,2%_%CURTIME:~0,2%%CURTIME:~3,2%%CURTIME:~6,2%
rem
rem Replace Delimiters " " to "0"
rem
set newSuffix2=%newSuffix2: =0% 

rem Print Suffix...
rem
echo %newSuffix2%

rem Delete Variables...
rem
set newSuffix2=
set CURDATE=
set CURTIME=
rem
exit /b 0
