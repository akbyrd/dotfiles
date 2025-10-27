#TODO: The registry key is no longer valid as of 25-10-23
if ($false)
{
	$keys = "HKCU:\Software\Classes\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\shell\empty\command"
	$values =
	@{
		type = "String"
		name = "DelegateExecute"
		value = ""
	},
	@{
		type = "String"
		name = "(Default)"
		value = $env:LOCALAPPDATA + "\Microsoft\WinGet\Packages\NirSoft.NirCmd_Microsoft.Winget.Source_8wekyb3d8bbwe\nircmd.exe emptybin"
	}
	Set-RegistryValue $keys $values
}