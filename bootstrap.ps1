# Run this command to bootstrap and run setup
# iex (iwr "dotfiles.akbyrd.email").Content

# The latest version of this file can be found at
# https://github.com/akbyrd/dotfiles/blob/main/bootstrap.ps1

# Requirements
# * Must be run on the same drive as Windows to create hard links
# * Must be run as admin to symlink terminal settings
# * Must be run as admin to install gpedit
# * Must be run as admin to set file associations in HKCR
#
# It's easier to require admin here rather than setup.ps1 so we don't have to deal with elevation
# and multiple windows
#Requires -RunAsAdministrator

$SysEnv = [System.Environment]
$EnvVar = [System.EnvironmentVariableTarget]

# Install winget if it's not already installed
($winget = Get-Command -CommandType Application winget) *> $null
if (!$winget)
{
	# Using github instead of the store since it's not guaranteed to be installed (Windows Sandbox,
	# corporate environments, etc).
	# https://learn.microsoft.com/en-us/windows/package-manager/winget/#install-winget-on-windows-sandbox

	# We have to manually grab dependencies. This is fragile and will hopefully be fixed one day.
	# https://github.com/microsoft/winget-cli/issues/401
	$wingetUrls = @(
		"https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx",
		"https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.7.3/Microsoft.UI.Xaml.2.7.x64.appx",
		"https://aka.ms/getwinget"
	)

	# Disable progress because it slows downloads to a crawl
	$progressPreference = "silentlyContinue"
	$tempDir = "dotfiles-temp"
	Write-Information "Downloading WinGet and its dependencies..."
	New-Item $tempDir -ItemType Directory -Force | Out-Null
	for ($i = 0; $i -lt $wingetUrls.Length; $i++)
	{
		$url = $wingetUrls[$i]
		$filename = "$tempDir/WingetFile_$i.msixbundle";

		Invoke-WebRequest -Uri $url -OutFile $filename
		Add-AppxPackage $filename
		Remove-Item $filename
	}
	Remove-Item $tempDir
	$progressPreference = 'Continue'
}

function Reload-Path {
	$userPath = $SysEnv::GetEnvironmentVariable("Path", $EnvVar::User)
	$machPath = $SysEnv::GetEnvironmentVariable("Path", $EnvVar::Machine)
	$env:Path = "$machPath;$userPath"
}

winget install -s winget "Git.Git"
winget install -s winget -e "Microsoft.PowerShell"
Reload-Path

git clone "https://github.com/akbyrd/dotfiles.git"

Push-Location dotfiles
Set-ExecutionPolicy Bypass
pwsh -Command ./setup.ps1
Pop-Location

Reload-Path
$pwshProfile = $Profile.CurrentUserAllHosts
.$pwshProfile
