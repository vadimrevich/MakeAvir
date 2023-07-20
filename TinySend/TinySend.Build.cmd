rem This script create 7Zip archive for creating an SFX packets installer
rem Than this archive is given to s-SFX Builder program for creating
rem a self-extracted archive with password.
rem
rem A password for archive is needed because so far many antiviruses
rem detect this packet as malware although all harmful code will be deleted
rem from it.
rem
rem The password will be changed from version to version and from manufacturer
rem to manufacturer. Also You can set your own password by the assembly
rem of installer
rem
rem For an archive creation You must satisfy yourself that You have installed
rem a program of 7Zip, and its path is scripted at system environment.
rem After You must run this script. 

rem The password for creating archive is <szbeck>
set SCRIPT=TinySend.7z
set PASS=szbeck
del .\Scripts\%SCRIPT%
7z a -m0=LZMA2 -p%PASS% -r .\Scripts\%SCRIPT% .\C\*.*