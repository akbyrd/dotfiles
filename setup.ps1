# Requirements
# * Must be run on the same drive as Windows to create hard links
# * Must be run as admin to symlink terminal settings

#Requires -RunAsAdministrator

# Standard
winget install -s winget -e 7zip.7zip
winget install -s winget -e Argotronic.ArgusMonitor
winget install -s winget -e Discord.Discord
winget install -s winget -e Mozilla.Firefox
winget install -s winget -e SlackTechnologies.Slack
winget install -s winget -e Spotify.Spotify
winget install -s winget -e Valve.Steam
winget install -s winget -e VideoLAN.VLC

# Development - General
winget install -s winget -e Microsoft.VisualStudio.2022.Community
winget install -s winget -e Microsoft.VisualStudioCode
winget install -s winget -e Microsoft.Windows.Terminal
winget install -s winget -e TortoiseGit.TortoiseGit
winget install -s winget -e TortoiseSVN.TortoiseSVN
winget install -s winget -e WinMerge.WinMerge

# Development - Terminal
$terminalSettings = $env:LOCALAPPDATA + "\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
Stop-Process -Name WindowsTerminal
Remove-Item $terminalSettings
New-Item -ItemType HardLink -Force -Path $terminalSettings -Target res/windows-terminal-settings.json

# Development - PowerShell
winget install -s winget -e Microsoft.PowerShell
New-Item -ItemType HardLink -Force -Path $Profile -Target res/pwsh-profile.ps1
Update-Help

# Development - PowerShell Appearance
winget install -s winget -e JanDeDobbeleer.OhMyPosh
Install-Module posh-git
Install-Module Terminal-Icons -Repository PSGallery
$ompTheme = (Split-Path $Profile) + "\oh-my-posh-theme.omp.json"
New-Item -ItemType HardLink -Force -Path $ompTheme -Target res/oh-my-posh-theme.omp.json
.$Profile

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

# No Packages (23-01-23)
# MSI Afterburner
# Nvidia Drivers
# Paint.NET
# Razer Synapse
