$SysEnv = [System.Environment]
$EnvVar = [System.EnvironmentVariableTarget]

# Add script folder to path
$setupPath = $MyInvocation.MyCommand.Path
$dotfilesDir = Split-Path $setupPath
$userPath = $SysEnv::GetEnvironmentVariable("Path", $EnvVar::User)
$userPath = "$userPath;$dotfilesDir\script"
$SysEnv::SetEnvironmentVariable("Path", $userPath, $EnvVar::User)

# TODO: Fix fonts
# TODO: Allow script to be run multiple times
# TODO: Decide what to do about hard linking
# TODO: Implement save and restore
# TODO: Set font for PowerShell terminal
# TODO: Set font for Windows PowerShell terminal
# TODO: Setup profile for Windows PowerShell

# TODO: Remove this
winget install -s winget -e "JanDeDobbeleer.OhMyPosh"; ""
winget install -s winget -e "Microsoft.WindowsTerminal"; ""

# No Packages (23-01-23)
# MSI Afterburner
# Nvidia Drivers
# Paint.NET
# Razer Synapse

<#
# Standard
winget install -s winget -e "7zip.7zip"
winget install -s winget -e "Argotronic.ArgusMonitor"
winget install -s winget -e "Discord.Discord"
winget install -s winget -e "Mozilla.Firefox"
winget install -s winget -e "NickeManarin.ScreenToGif"
winget install -s winget -e "NirSoft.NirCmd"
winget install -s winget -e "Spotify.Spotify"
winget install -s winget -e "Valve.Steam"
winget install -s winget -e "VideoLAN.VLC"

# Development - General
winget install -s winget -e "Git.Git"
winget install -s winget -e "JanDeDobbeleer.OhMyPosh"
winget install -s winget -e "Microsoft.PowerShell"
winget install -s winget -e "Microsoft.VisualStudio.2022.Community"
winget install -s winget -e "Microsoft.VisualStudioCode"
winget install -s winget -e "Microsoft.WindowsTerminal"
winget install -s winget -e "TortoiseGit.TortoiseGit"
winget install -s winget -e "WinMerge.WinMerge"

# Config - Visual Studio
$vswhere      = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
$vsInstallDir = (.$vswhere -latest -property installationPath)

$msBuildDir = "$vsInstallDir\Msbuild\Current\Bin"
$msBuildDir = $msBuildDir.Replace("${env:ProgramFiles}", "%ProgramFiles%")
$msBuildDir = $msBuildDir.Replace("${env:ProgramFiles(x86)}", "%ProgramFiles(x86)%")

$machPath = $SysEnv::GetEnvironmentVariable("Path", $EnvVar::Machine)
$userPath = $SysEnv::GetEnvironmentVariable("Path", $EnvVar::User)
$env:Path = "$machPath;$userPath;$msBuildDir"
#>

# Update path so oh-my-posh can be configured
$userPath = $SysEnv::GetEnvironmentVariable("Path", $EnvVar::User)
$machPath = $SysEnv::GetEnvironmentVariable("Path", $EnvVar::Machine)
$env:Path = "$machPath;$userPath"

# Config- Terminal
$terminalSettings = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
Stop-Process -Name WindowsTerminal 2> $null
#New-Item -ItemType HardLink -Force -Path $terminalSettings -Target res\windows-terminal-settings.json
Copy-Item -Force -Path "res\windows-terminal-settings.json" -Destination $terminalSettings

# Config - PowerShell
Set-ExecutionPolicy Bypass
$pwshProfile = $Profile.CurrentUserAllHosts
$pwshProfileDir = Split-Path $pwshProfile
#New-Item -ItemType HardLink -Force -Path $pwshProfile -Target "res\pwsh-profile.ps1"
New-Item -Type Directory $pwshProfileDir 2> $null
Copy-Item -Force -Path "res\pwsh-profile.ps1" -Destination $pwshProfile

# Development - PowerShell Appearance
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Repository PSGallery "posh-git"
Install-Module -Repository PSGallery "Terminal-Icons"
$ompTheme = "$pwshProfileDir\oh-my-posh-theme.omp.json"
#New-Item -ItemType HardLink -Force -Path $ompTheme -Target "res\oh-my-posh-theme.omp.json"
Copy-Item -Force -Path "res\oh-my-posh-theme.omp.json" -Destination $ompTheme

.$pwshProfile
oh-my-posh disable notice

class Font
{
	$name
	$file
}

$fonts = [Font[]] (
	@{
		name = "Inconsolata"
		file = "Inconsolata Regular Nerd Font Complete Windows Compatible.ttf"
	},
	@{
		name = "Inconsolata"
		file = "Inconsolata Bold Nerd Font Complete Windows Compatible.ttf"
	},
	@{
		name = "Inconsolata"
		file = "Inconsolata Regular Nerd Font Complete Mono Windows Compatible.ttf"
	},
	@{
		name = "Inconsolata"
		file = "Inconsolata Bold Nerd Font Complete Mono Windows Compatible.ttf"
	}
)

Install-Module -Repository PSGallery "PSWinGlue"
Import-Module -DisableNameChecking "PSWinGlue"
foreach ($font in $fonts)
{
	$baseURL = "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts"
	$path = "$baseURL/$($font.name)/complete/$($font.file)"
	$path = $path.replace(" ", "%20")
	curl -Lo $font.file $path
	Install-Font $font.file -Scope User -Method Shell
	Remove-Item $font.file
}
Uninstall-Module PSWinGlue

<#
# Suppress errors to workaround a problem with PSReadLine
# https://github.com/PowerShell/PSReadLine/issues/3359
Update-Help 2> $null

.\res\windows\registry-utilities.ps1
$registryFiles = Get-ChildItem "res\windows\*.reg"
foreach ($registryFile in $registryFiles)
{
	regedit /s $registryFile
}

$registryScripts = Get-ChildItem "res\windows\*.ps1" -Exclude "registry-utilities.ps1"
foreach ($registryScript in $registryScripts)
{
	.$registryScript
}
#>
