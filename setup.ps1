# TODO: Rename scripts (keep default name, use separate folders)
# TODO: Remove the workaround for font file locks
# TODO: Decide what to do about hard linking
# TODO: Fix dism in Windows Sandbox
# TODO: Fix registry-utilities in Windows Sandbox

param (
	[string] $Task = "Setup")

class Config
{
	[string] $src
	[string] $dst
	[scriptblock] $pre
	[scriptblock] $post
}

$configs = [Config[]] (
	@{ # Git
		src = "res\.gitconfig"
		dst = "~\.gitconfig"
	},
	@{ # Windows Terminal
		src = "res\windows-terminal-settings.json"
		dst = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
		pre = { Stop-Process -Name WindowsTerminal 2> $null }
	},
	@{ # PowerShell
		src  = "res\pwsh-profile.ps1"
		dst  = $Profile.CurrentUserAllHosts
		post = { .$Profile.CurrentUserAllHosts }
	},
	@{ # Oh My Posh
		src = "res\oh-my-posh-theme.omp.json"
		dst = "$(Split-Path $Profile.CurrentUserAllHosts)\oh-my-posh-theme.omp.json"
	}
)

function Backup-Config
{
	foreach ($config in $configs)
	{
		Copy-Item -Force -Path $config.dst -Destination $config.src
	}
}

function Restore-Config
{
	foreach ($config in $configs)
	{
		if ($config.pre)
		{
			&$config.pre
		}

		$dir = Split-Path $config.dst
		New-Item -Type Directory $dir 2> $null

		#New-Item -ItemType HardLink -Force -Path $config.dst -Target $config.src
		Copy-Item -Force -Path $config.src -Destination $config.dst

		if ($config.post)
		{
			&$config.post
		}
	}
}

function Setup-Software
{
	# No Packages (23-01-23)
	# MSI Afterburner
	# Nvidia Drivers
	# Paint.NET
	# Razer Synapse

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

	# Development
	winget install -s winget -e "Git.Git"
	winget install -s winget -e "Hugo.Hugo.Extended"
	winget install -s winget -e "JanDeDobbeleer.OhMyPosh"
	winget install -s winget -e "Microsoft.PowerShell"
	winget install -s winget -e "Microsoft.VisualStudio.2022.Community"
	winget install -s winget -e "Microsoft.VisualStudioCode"
	winget install -s winget -e "Microsoft.WindowsTerminal"
	winget install -s winget -e "TortoiseGit.TortoiseGit"
	winget install -s winget -e "WinMerge.WinMerge"

	# PowerShell
	# TODO: Is this still needed?
	#Set-ExecutionPolicy Bypass
	Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
	Install-Module -Repository PSGallery "posh-git"
	Install-Module -Repository PSGallery "Terminal-Icons"

	# TODO: Can this be done in a config file?
	# TODO: Load Oh My Posh before running this
	#oh-my-posh disable notice
}

function Setup-Environment
{
	$SysEnv = [System.Environment]
	$EnvVar = [System.EnvironmentVariableTarget]

	$machPath = $SysEnv::GetEnvironmentVariable("Path", $EnvVar::Machine)
	$userPath = $SysEnv::GetEnvironmentVariable("Path", $EnvVar::User)

	# Dotfiles
	$dotfilesDir = Split-Path $MyInvocation.MyCommand.Path
	$SysEnv::SetEnvironmentVariable("DotfilesDir", $dotfilesDir, $EnvVar::User)

	# Bin
	$userPath = "$userPath;$dotfilesDir\bin"

	# MSBuild
	$vswhere      = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
	$vsInstallDir = (.$vswhere -latest -property installationPath)

	$msBuildDir = "$vsInstallDir\Msbuild\Current\Bin"
	$msBuildDir = $msBuildDir.Replace("${env:ProgramFiles}", "%ProgramFiles%")
	$msBuildDir = $msBuildDir.Replace("${env:ProgramFiles(x86)}", "%ProgramFiles(x86)%")
	$userPath = "$userPath;$msBuildDir"

	# Apply changes
	$SysEnv::SetEnvironmentVariable("Path", $userPath, $EnvVar::User)
	$env:Path = "$machPath;$userPath"
}

function Setup-Config
{
	Restore-Config
}

function Setup-Fonts
{
	$tempDir = "fonts"
	New-Item $tempDir -ItemType Directory -Force | Out-Null
	Push-Location $tempDir
	$progressPreference = "silentlyContinue"

	$installFontUrl = "https://raw.githubusercontent.com/ralish/PSWinGlue/master/Scripts/Install-Font.ps1"
	Invoke-WebRequest $installFontUrl -OutFile "Install-Font.ps1"

	$fontUrl = "https://api.github.com/repos/ryanoasis/nerd-fonts/contents/patched-fonts/Inconsolata"
	$headers = @{ Accept = "application/vnd.github.raw" }
	$result = iwr -UseBasicParsing -Headers $headers -Uri $fontUrl
	$fontFiles = ConvertFrom-JSON $result.Content
	foreach ($fontFile in $fontFiles)
	{
		if ($fontFile.name.EndsWith(".ttf"))
		{
			Invoke-WebRequest -Uri $fontFile.download_url -OutFile $fontFile.name

			# Workaround for the fact that Install-Font ends up holding a file lock until PowerShell is closed.
			# This only happens with the Manual method, but the Shell method doesn't work in Windows Sandbox so
			# we can't avoid it.
			# https://github.com/ralish/PSWinGlue/issues/9
			pwsh -Command {
				Install-Font.ps1 -Verbose . -Scope User -Method Manual
			}

			Remove-Item $fontFile.name
		}
	}

	Remove-Item "Install-Font.ps1"

	$progressPreference = "Continue"
	Pop-Location
	Remove-Item $tempDir
}

function Setup-Help
{
	# Suppress errors to workaround a problem with PSReadLine
	# https://github.com/PowerShell/PSReadLine/issues/3359
	Update-Help 2> $null
}

function Setup-Registry
{
	&"res\windows\registry-utilities.ps1"
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
}

switch ($Task)
{
	"Backup" { Backup-Config }
	"Restore" { Restore-Config }
	"Setup"
	{
		Setup-Software
		Setup-Environment
		Setup-Config
		Setup-Fonts
		Setup-Help
		Setup-Registry
	}
}
