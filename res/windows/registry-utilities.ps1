class RegistryValue
{
	[String] $type
	[String] $name
	[String] $value
}

function global:Set-RegistryValue(
	[Parameter(Mandatory)] [String[]] $keys,
	[Parameter(Mandatory)] [RegistryValue[]] $values)
{
	foreach ($key in $keys)
	{
		if (-NOT (Test-Path $key))
		{
			New-Item -Path $key | Out-Null
		}
		foreach ($value in $values)
		{
			New-ItemProperty -Force -Path $key -PropertyType $value.type -Name $value.name -Value $value.value | Out-Null
		}
	}
}

if (!(Test-Path "HKCR:"))
{
	# NOTE: HKCU already exists
	New-PSDrive -Scope Global -PSProvider registry -Root HKEY_CLASSES_ROOT -Name HKCR | Out-Null
}
