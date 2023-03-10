# Requirements
# * Must be run on the same drive as Windows to create hard links
# * Must be run as admin to symlink terminal settings
# * Must be run as admin to install gpedit
# * Must be run as admin to set file associations in HKCR

#Requires -RunAsAdministrator

# No Packages (23-01-23)
# MSI Afterburner
# Nvidia Drivers
# Paint.NET
# Razer Synapse

# Standard
winget install -s winget -e 7zip.7zip
winget install -s winget -e Argotronic.ArgusMonitor
winget install -s winget -e Discord.Discord
winget install -s winget -e Mozilla.Firefox
winget install -s winget -e NickeManarin.ScreenToGif
winget install -s winget -e NirSoft.NirCmd
winget install -s winget -e Spotify.Spotify
winget install -s winget -e Valve.Steam
winget install -s winget -e VideoLAN.VLC

# Development - General
winget install -s winget -e Microsoft.VisualStudio.2022.Community
winget install -s winget -e Microsoft.VisualStudioCode
winget install -s winget -e Microsoft.Windows.Terminal
winget install -s winget -e Git.Git
winget install -s winget -e TortoiseGit.TortoiseGit
winget install -s winget -e WinMerge.WinMerge

# Development - Terminal
$terminalSettings = $env:LOCALAPPDATA + "\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
Stop-Process -Name WindowsTerminal
#New-Item -ItemType HardLink -Force -Path $terminalSettings -Target res/windows-terminal-settings.json
Copy-Item -Force -Path $terminalSettings -Destination res/windows-terminal-settings.json

# Development - PowerShell
$pwshProfile = $Profile.CurrentUserAllHosts
winget install -s winget -e Microsoft.PowerShell
New-Item -ItemType HardLink -Force -Path $pwshProfile -Target res/pwsh-profile.ps1
Update-Help

# Development - PowerShell Appearance
winget install -s winget -e JanDeDobbeleer.OhMyPosh
Install-Module posh-git
Install-Module Terminal-Icons -Repository PSGallery
$ompTheme = (Split-Path $pwshProfile) + "\oh-my-posh-theme.omp.json"
New-Item -ItemType HardLink -Force -Path $ompTheme -Target res/oh-my-posh-theme.omp.json
.$pwshProfile

Install-Module PSWinGlue
Import-Module PSWinGlue
./fonts.ps1
foreach ($font in $fonts)
{
	$baseURL = "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/"
	$path = $baseURL + $font.name + "/complete/" + $font.file
	$path = $path.replace(" ", "%20")
	curl -Lo $font.file $path
	Install-Font $font.file -Scope User -Method Shell
	Remove-Item $font.file
}
Uninstall-Module PSWinGlue

./res/windows/registry-utilities.ps1
$registryFiles = (Get-ChildItem res\windows\*.reg)
foreach ($registryFile in $registryFiles)
{
	regedit /s $registryFile
}

$registryScripts = (Get-ChildItem res\windows\*.ps1 -Exclude registry-utilities.ps1)
foreach ($registryScript in $registryScripts)
{
	.$registryScript
}
