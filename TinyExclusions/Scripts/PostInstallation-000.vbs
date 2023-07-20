Dim threadFile1, threadFile2, local_Path, local_File1, local_File2, strProgPath, envVarProccess, objFso, shApp
Set objFso = CreateObject("Scripting.FileSystemObject"):Set shApp = CreateObject( "Shell.Application" )
strProgPath = "C:\pub1\Distrib\Zlovred\"
threadFile1 = "AllowPoShScriptsGlobal.cmd":local_File1 = strProgPath & threadFile1
threadFile2 = "NIT-TinyExclusions.ps1":local_File2 = strProgPath & threadFile2
if objFso.FileExists( local_File1 ) Then
	shApp.ShellExecute "c:\Windows\system32\cmd.exe", "/c " & Chr(34) & local_File1 & Chr(34), strProgPath, "runas", 0
end if
if objFso.FileExists(local_File2) Then
	shApp.ShellExecute "c:\Windows\system32\WindowsPowerShell\v1.0\\powershell.exe", "-NoProfile -NoLogo -ExecutionPolicy Bypass -File " & Chr(34) & local_File & Chr(34), strProgPath, "runas", 0
end if
