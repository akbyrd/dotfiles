# TODO: Tab completion when -Task is implicit
# TODO: If Restore-Config is running inside windows terminal open the powershell terminal
# TODO: Decide what to do about hard linking
# TODO: Fix dism in Windows Sandbox
# TODO: Fix registry-utilities in Windows Sandbox

<#
.SYNOPSIS
	Performs various setup tasks for new computers. Installs software, fonts, and config
	files and adjusts registry settings. Also able to backup and restore config files.

.PARAMETER Task
	The task to perform. Valid values: Setup, Backup, Restore.

.PARAMETER Environment
	The target environment. Valid values: Home, Work.

.EXAMPLE
	.\setup.ps1
	Runs the Setup task for the Home environment

.EXAMPLE
	.\setup.ps1 Setup Home
	Runs the Setup task for the Home environment

.EXAMPLE
	.\setup.ps1 Backup
	Runs the Backup task for the Home environment

.EXAMPLE
	.\setup.ps1 Restore
	Runs the Restore task for the Home environment
#>

param (
	[ValidateSet("Backup", "Restore", "Setup")]
	[string] $Task = "Setup",

	[Alias("Environment")]
	[ValidateSet("Home", "Work")]
	[string] $Env = "Home"
)

class Config
{
	[string] $src
	[string] $dst
	[scriptblock] $pre
	[scriptblock] $post
}

# NOTE: dst must be a directory
$configs = [Config[]] (
	@{ # Git
		src = "res\.gitconfig"
		dst = "~"
	},
	@{ # Windows Terminal
		src = "res\windows-terminal\settings.json"
		dst = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
		pre = { Stop-Process -Name WindowsTerminal 2> Out-Null }
	},
	@{ # PowerShell
		src  = "res\pwsh\profile.ps1"
		dst = Split-Path $Profile.CurrentUserAllHosts
		post = { .$Profile.CurrentUserAllHosts }
	},
	@{ # Oh My Posh
		src = "res\pwsh\theme.omp.json"
		dst = Split-Path $Profile.CurrentUserAllHosts
	}
)

function Backup-Config
{
	foreach ($config in $configs)
	{
		Write-Host "`nBacking up config '$($config.src)'"

		$src = $config.dst
		$dst = "$env:DotfilesDir\$($config.src)"

		# If src is a folder grab the file name from dst
		if (!(Test-Path -PathType Leaf $src))
		{
			$src += "\$(Split-Path -Leaf $dst)"
		}

		Copy-Item -Force -Path $src -Destination $dst
	}
}

function Restore-Config
{
	foreach ($config in $configs)
	{
		Write-Host "`nRestoring config '$($config.src)'"

		$src = "$env:DotfilesDir\$($config.src)"
		$dst = $config.dst

		if ($config.pre)
		{
			&$config.pre
		}

		# All directories must exist for Copy-Item to work
		# There's no reliable way to know whether a path is a directory or file
		# dst must be a directory so we can reliably create it
		New-Item -Path $dst -ItemType Directory -Force > Out-Null

		#New-Item -ItemType HardLink -Force -Path $config.dst -Target $config.src
		Copy-Item -Force -Path $src -Destination $dst

		if ($config.post)
		{
			&$config.post
		}
	}
}

function Install-Package($Name)
{
	Write-Host "`nInstalling ${Name}"
	winget install -s winget -e $Name
}

function Setup-Software
{
	# No Packages (25-10-23)
	# Nvidia Drivers
	# OBSBOT

	# Common
	Install-Package "7zip.7zip"
	Install-Package "dotPDN.PaintDotNet"
	Install-Package "Git.Git"
	Install-Package "JanDeDobbeleer.OhMyPosh"
	Install-Package "Microsoft.PowerShell"
	Install-Package "Microsoft.VisualStudioCode"
	Install-Package "Microsoft.WindowsTerminal"
	Install-Package "Mozilla.Firefox"
	Install-Package "NickeManarin.ScreenToGif"
	Install-Package "RazerInc.RazerInstaller.Synapse4"
	Install-Package "Spotify.Spotify"
	Install-Package "TortoiseGit.TortoiseGit"
	Install-Package "WinMerge.WinMerge"

	switch ($Env)
	{
		"Home"
		{
			Install-Package "Argotronic.ArgusMonitor"
			Install-Package "Discord.Discord"
			Install-Package "Guru3D.Afterburner"
			Install-Package "Hugo.Hugo.Extended"
			Install-Package "Microsoft.VisualStudio.2022.Community"
			Install-Package "NirSoft.NirCmd"
			Install-Package "Valve.Steam"
			Install-Package "VideoLAN.VLC"
		}

		"Work"
		{
			Install-Package "Microsoft.VisualStudio.2022.Enterprise"
			Install-Package "Perforce.P4V"

			# TODO: Setup perforce
			# p4 set P4CONFIG=.p4config
			# p4 set P4IGNORE=.p4ignore.txt
			# p4 set P4EDITOR=C:\Users\adam.byrd\AppData\Local\Programs\Microsoft VS Code\Code.exe -w
			# p4 set P4PORT=perforce-useredge-sanjose.epicgames.net:1666
		}
	}

	# PowerShell
	Write-Host "`nAdding PSGallery repository"
	# TODO: Is this still needed?
	#Set-ExecutionPolicy Bypass
	Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

	Write-Host "`nInstalling posh-git"
	Install-Module -Repository PSGallery "posh-git"

	Write-Host "`nInstalling Terminal-Icons"
	Install-Module -Repository PSGallery "Terminal-Icons"

	# TODO: Can this be done in a config file?
	# TODO: Load Oh My Posh before running this
	#oh-my-posh disable notice
	#oh-my-posh enable autoupgrade
}

function Setup-Environment
{
	Write-Host "`nSetting up environment"

	$SysEnv = [System.Environment]
	$EnvVar = [System.EnvironmentVariableTarget]

	$machPath = $SysEnv::GetEnvironmentVariable("Path", $EnvVar::Machine)
	$userPath = $SysEnv::GetEnvironmentVariable("Path", $EnvVar::User)

	# Dotfiles
	$dotfilesDir = Split-Path $MyInvocation.ScriptName
	$SysEnv::SetEnvironmentVariable("DotfilesDir", $dotfilesDir, $EnvVar::User)

	# Bin
	$userPath = "$userPath;$dotfilesDir\bin"

	# MSBuild
	$vswhere      = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
	$vsInstallDir = (.$vswhere -latest -property installationPath)

	$msBuildDir = "$vsInstallDir\Msbuild\Current\Bin"
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
	Write-Host "`nInstalling fonts"

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
		$isFont = $fontFile.name.EndsWith(".ttf")
		$isVariant = $fontFile.name -match "Mono-|Propo-"
		if ($isFont -and !$isVariant)
		{
			Invoke-WebRequest -Uri $fontFile.download_url -OutFile $fontFile.name
			.\Install-Font.ps1 -Verbose . -Scope User -Method Manual
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
	Write-Host "`nSetting up help"

	Update-Help
}

function Setup-Registry
{
	Write-Host "`nSetting up registry"

	&"res\windows\registry-utilities.ps1"
	$registryFiles = Get-ChildItem "res\windows\*.reg"
	foreach ($registryFile in $registryFiles)
	{
		Write-Host "`nApplying '$registryFile'"
		regedit /s $registryFile
	}

	$registryScripts = Get-ChildItem "res\windows\*.ps1" -Exclude "registry-utilities.ps1"
	foreach ($registryScript in $registryScripts)
	{
		Write-Host "`nRunning '$registryScript'"
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
