<#
.SYNOPSIS
    This function create new Defender Exclusions settings using 
    Add-MpPreference Commnd
.DESCRIPTION
    This script will create Tiny Defender Exclusions settings
.NOTES
    File name: NIT-UserExclusions01.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2022-12-18
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2022-12-18) Script created
    1.0.1 - 
#>

### Define System Function

function Test-IsAdmin {
    try {
        $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
        $principal = New-Object Security.Principal.WindowsPrincipal -ArgumentList $identity
        return $principal.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator )
    } catch {
        throw "Failed to determine if the current user has elevated privileges. The error was: '{0}'." -f $_
    }
}

function GetMyDocumentsPath
{
$MyDocuments = 5 #System.Environment.SpecialFolder.MyDocuments
[System.Environment]::GetFolderPath($MyDocuments)
}

# Code for Self Elevated Script

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}

# Your script here

### Set a Path my Downloads
$MyDownloadsPath=(New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
### Set a Path my Documents
$MyDocumentsPath=GetMyDocumentsPath
### Set a Path My Desktop
$MyDesktopPath=[Environment]::GetFolderPath("Desktop")
### Set OneDrive Folder
$MyOneDrivePath=$env:OneDrive
### Set OneDtiveTemp Folder
$OneDriveTempPath=(Get-Item $env:OneDrive).PSDrive.Name + ":\OneDriveTemp"
### Set PathCMD 
$pathCMD=Join-Path -Path $env:SystemRoot -ChildPath "System32"
### Set SysWOW Path
$pathWOW64=Join-Path -Path $env:SystemRoot -ChildPath "SysWOW64"

### Set User Defined Variables
#
$aPathExclusion001=$MyDownloadsPath
$aPathExclusion002=$MyDocumentsPath
$aPathExclusion003=$MyDesktopPath
$aPathExclusion004=$MyOneDrivePath
$aPathExclusion005=$OneDriveTempPath
# $aPathExclusion006=$pathCMD
$aPathExclusion006=$env:SystemRoot
# $aPathExclusion007=$pathWOW64

### Check System Conditions
#
$isAdmin = Test-IsAdmin

### Run Algorythm

if( $isAdmin ){

### === Script body === ###

	Add-MpPreference -ExclusionPath $aPathExclusion001
	Add-MpPreference -ExclusionPath $aPathExclusion002
	Add-MpPreference -ExclusionPath $aPathExclusion003
	Add-MpPreference -ExclusionPath $aPathExclusion004
    Add-MpPreference -ExclusionPath $aPathExclusion005
    Add-MpPreference -ExclusionPath $aPathExclusion006
#    Add-MpPreference -ExclusionPath $aPathExclusion007

### === End Script Body === ###

    Write-Host Successful Script Run!
    # return 0
}
else {
	Write-Host Warning! Script must be Run with Elevated Privileges!
	# return 17;
}
