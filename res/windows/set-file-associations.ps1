#Requires -RunAsAdministrator

#TODO: The registry keys are no longer valid as of 25-10-23
if ($false)
{
	$keys = [String[]] (
		"HKCR:SystemFileAssociations\document\shell\edit\command",
		"HKCR:SystemFileAssociations\system\shell\edit\command",
		"HKCR:SystemFileAssociations\text\shell\edit\command",
		"HKCU:Software\Classes\batfile\shell\edit\command",
		"HKCU:Software\Classes\regfile\shell\edit\command"
	)
	$values =
	@{
		type = "String"
		name = "(Default)"
		value = '"{0}" "%1"' -f ($env:LOCALAPPDATA + "\Programs\Microsoft VS Code\Code.exe")
	}
	Set-RegistryValue $keys $values

	$keys = "HKCR:SystemFileAssociations\image\shell\edit\command"
	$values =
	@{
		type = "String"
		name = "(Default)"
		value = '"{0}" "%1"' -f ($env:ProgramFiles + "\paint.net\PaintDotNet.exe")
	}
	Set-RegistryValue $keys $values
}
