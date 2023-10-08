Set-ExecutionPolicy Bypass

$tempDir = "fonts"
New-Item $tempDir -ItemType Directory -Force | Out-Null
Push-Location $tempDir
$progressPreference = "silentlyContinue"

$installFontUrl = "https://raw.githubusercontent.com/ralish/PSWinGlue/master/Scripts/Install-Font.ps1"
Invoke-WebRequest $installFontUrl -OutFile "Install-Font.ps1"

$fontUrl = "https://api.github.com/repos/ryanoasis/nerd-fonts/contents/patched-fonts/Agave"
$headers = @{ Accept = "application/vnd.github.raw" }
$result = iwr -UseBasicParsing -Headers $headers -Uri $fontUrl
$fontFiles = ConvertFrom-JSON $result.Content
foreach ($fontFile in $fontFiles)
{
	if ($fontFile.name.EndsWith(".ttf"))
	{
		Invoke-WebRequest -Uri $fontFile.download_url -OutFile $fontFile.name

		# Workaround for the fact taht Install-Font ends up holding a file lock until PowerShell is closed.
		# This only happens with the Manual method, but the Shell method doesn't work in Windows Sandbox so
		# we can't avoid it.
		# https://github.com/ralish/PSWinGlue/issues/9
		pwsh -Command {
			.\Install-Font.ps1 -Verbose . -Scope User -Method Manual
		}

		Remove-Item $fontFile.name
	}
}

Remove-Item "Install-Font.ps1"

$progressPreference = "Continue"
Pop-Location
Remove-Item $tempDir
