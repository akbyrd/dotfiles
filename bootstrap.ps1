# Run this command to bootstrap and run setup
# iex (iwr "dotfiles.akbyrd.email").Content
# or
# iex (iwr -UseBasicParsing "dotfiles.akbyrd.email").Content

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

function Install-WinGet
{
	# NOTE: Windows now comes with winget, but the Sandbox does not.
	# https://learn.microsoft.com/en-us/windows/package-manager/winget/#install-winget-on-windows-sandbox

	Write-Host "Installing WinGet"
	$progressPreference = 'silentlyContinue'

	Install-PackageProvider -Force -Name NuGet | Out-Null
	Install-Module -Force -Name Microsoft.WinGet.Client -Repository PSGallery
	# TODO: This seems to raise a spurious error
	# Repair-WinGetPackageManager : One or more errors occurred.
	# At line:29 char:2
	# +     Repair-WinGetPackageManager -AllUsers
	# +     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#     + CategoryInfo          : NotSpecified: (:) [Repair-WinGetPackageManager], AggregateException
	#     + FullyQualifiedErrorId : System.AggregateException,Microsoft.WinGet.Client.Commands.RepairWinGetPackageManagerCmdlet
	Repair-WinGetPackageManager -AllUsers

	Write-Host ""
	$progressPreference = "Continue"
}

function Reload-Path
{
	$SysEnv = [System.Environment]
	$EnvVar = [System.EnvironmentVariableTarget]

	$userPath = $SysEnv::GetEnvironmentVariable("Path", $EnvVar::User)
	$machPath = $SysEnv::GetEnvironmentVariable("Path", $EnvVar::Machine)
	$env:Path = "$machPath;$userPath"
}

# Install winget if it's not already installed
($winget = Get-Command -CommandType Application winget) *> $null
if (!$winget)
{
	Install-WinGet
}

winget install -s winget "Git.Git"; ""
Reload-Path
git clone "https://github.com/akbyrd/dotfiles.git"

Push-Location "dotfiles"
Set-ExecutionPolicy Bypass
&".\setup.ps1"
Pop-Location
