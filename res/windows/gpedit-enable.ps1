#Requires -RunAsAdministrator

$packages =
	(Get-ChildItem $env:SystemRoot\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package*.mum) +
	(Get-ChildItem $env:SystemRoot\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package*.mum)

foreach ($package in $packages)
{
	dism /online /norestart /add-package:$package
}
