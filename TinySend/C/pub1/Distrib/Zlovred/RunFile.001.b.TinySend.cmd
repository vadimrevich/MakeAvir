@echo on
rem *******************************************************
rem RunDownloaded.001.TinySend.cmd
rem This Script Runs Application File
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
set aPrefix1=FlRn
rem
rem
rem Set Suffix...
rem
set aSuffix1=alldefeat
rem

rem Set File Extension...
rem
set anExtension=hta
rem

rem
rem Set Full Temporary File Name...
rem
set TEMPCMDFILENAME=%aPrefix1%-%aPrefix2%-%aSuffix1%.%anExtension%
rem

rem Set a System Folder...
rem
rem Set TinyDefender...
set TINDEF=C:\.BIN\TinyDefender
rem Check if files Exist
rem
if not exist %TINDEF% echo %TINDEF% is not found && exit /b 1
rem
echo Local Folder = %TINDEF%
rem
rem Set Local File...
set localfile=%TINDEF%\%TEMPCMDFILENAME%
rem
rem Check if files Exist
rem
if not exist %localfile% echo %localfile% is not found && exit /b 1
rem
echo Local File = %localfile%
rem

echo Run File...
rem
echo Nothing to do
rem start %localfile%

exit /b 0



