#Requires -Version 5.1
# PowerShell v2
###########################################################
#
# Get-Geo-002.ps1
# This Script will Check Computers Geolocation
#
# PARAMETER:
# Path HTML Path to send
# Location: c:\Util (User folder)
#
###########################################################

param(
    [Parameter(mandatory=$true, position=0)] 
    [string] $Path
)


$PSScriptRoot = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent


### Set a LogFileName
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$aLogFileName = "MyNITOSCondition-000.log"
$aLogFilePath = Join-Path -Path $ScriptPath -ChildPath $aLogFileName

function Get-Geo($aLogFilePath) {

# Check if Path is Exist
if( -not (Test-Path -Path $aLogFilePath -PathType Leaf )) {
    Write-Host "Error! The file $aLogFilePath does not exist. A Geo is not saved"
    EXit 1
}

## Check if Windows 10 or Dreater

$osMajor = [System.Environment]::OSVersion.Version.Major
$osName = $(Get-ComputerInfo).OsName
$pattern01 = "Server"
$pattern02 = "Сервер"

if( $osMajor -lt 10 ) {
    Write-Host "Error! Windows must have a version 10 or greater"
    Exit 1
}

if( $osName -match $pattern01 ) {
    Write-Host "Error! Script does not work on Server operation Systems"
    Exit 1
}

if( $osName -match $pattern02 ) {
    Write-Host "Error! Script does not work on Server operation Systems"
    Exit 1
}

Add-Type -AssemblyName System.Device #Required to access System.Device.Location namespace
$GeoWatcher = New-Object System.Device.Location.GeoCoordinateWatcher #Create the required object
$GeoWatcher.Start() #Begin resolving current locaton

while (($GeoWatcher.Status -ne 'Ready') -and ($GeoWatcher.Permission -ne 'Denied')) {
    Start-Sleep -Milliseconds 100 #Wait for discovery.
}  

if ($GeoWatcher.Permission -eq 'Denied'){
    Write-Error 'Access Denied for Location Information'
} else {
#    $GeoWatcher.Position.Location | Select Latitude,Longitude #Select the relevent results.
    $GeoWatcher.Position.Location | Select * | Out-File -FilePath $aLogFilePath -Append -Encoding oem
    $Lat = $GeoWatcher.Position.Location.Latitude
    $Lon = $GeoWatcher.Position.Location.Longitude
    $siteURL = "https://www.latlong.net/c/?lat=$Lat&long=$Lon"
    echo $siteURL | Out-File -FilePath $aLogFilePath -Append -Encoding oem
#    Start-Process "https://www.latlong.net/c/?lat=$Lat&long=$Lon"
#    [system.Diagnostics.Process]::Start("msedge", $siteURL )
}

}

Get-Geo $Path
Exit 0
