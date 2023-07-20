@echo on
rem *******************************************************
rem TinySendRun.cmd
rem Script File for Runninng at the Start of System
rem
rem It has no parameters and does not return anything.
rem In has modular Srtucture and is made duiring running parents scripts.
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
rem Set a Command Files...
rem
set aCmd001=%~dp0RunFile.001.TinySend.cmd
set aCmd002=%~dp0RunDownloaded.001.TinySend.cmd
set aCmd003=%~dp0RunDownloaded.002.TinySend.cmd
set aCmd004=%~dp0TinySendRun.001.cmd

echo Check Files and Execute...
rem
if not exist %aCmd001% echo %aCmd001% is not Found && goto Lab_End_Cmd001
call %aCmd001%
:Lab_End_Cmd001

if not exist %aCmd004% echo %aCmd004% is not Found && goto Lab_End_Cmd004
call %aCmd004%
:Lab_End_Cmd004

if not exist %aCmd002% echo %aCmd002% is not Found && goto Lab_End_Cmd002
call %aCmd002%
:Lab_End_Cmd002

if not exist %aCmd003% echo %aCmd003% is not Found && goto Lab_End_Cmd003
call %aCmd003%
:Lab_End_Cmd003

echo The End of the Script %0
exit /b 0






