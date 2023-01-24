# Standard
winget install -s winget -e 7zip.7zip
winget install -s winget -e Argotronic.ArgusMonitor
winget install -s winget -e Discord.Discord
winget install -s winget -e Mozilla.Firefox
winget install -s winget -e SlackTechnologies.Slack
winget install -s winget -e Spotify.Spotify
winget install -s winget -e Valve.Steam
winget install -s winget -e VideoLAN.VLC

# Development
winget install -s winget -e Microsoft.PowerShell
winget install -s winget -e Microsoft.VisualStudio.2022.Community
winget install -s winget -e Microsoft.VisualStudioCode
winget install -s winget -e Microsoft.Windows.Terminal
winget install -s winget -e TortoiseGit.TortoiseGit
winget install -s winget -e TortoiseSVN.TortoiseSVN

# Development - Terminal Extras
winget install -s winget -e JanDeDobbeleer.OhMyPosh
Install-Module posh-git
Install-Module -Name Terminal-Icons -Repository PSGallery

Install-Module -Name PSWinGlue
Import-Module PSWinGlue
./fonts.ps1
foreach ($font in $fonts)
{
	$baseURL = "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/"
	$path = $baseURL + $font.name + "/" + $font.folder + "/complete/" + $font.file
	$path = $path.replace(" ", "%20")
	curl -Lo $font.file $path
	Remove-Item $font.file
}

# TODO: Anything we can do about UAC prompts?
# TODO: Copy pwsh profile
# TODO: Copy oh-my-posh profile
# TODO: Copy windows-terminal profile

# No Packages (23-01-23)
# MSI Afterburner
# Nvidia Drivers
# Paint.NET
# Razer Synapse
