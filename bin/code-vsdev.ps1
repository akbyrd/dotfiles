$vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
$vsInstallDir = .$vswhere -latest -property installationPath
$devShell = "$vsInstallDir\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"
Import-Module $devShell
Enter-VsDevShell -VsInstallPath "$vsInstallDir" -Arch x64
code-gui.ps1
