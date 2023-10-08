Set-ExecutionPolicy Bypass
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
		.\Install-Font.ps1 -Verbose $fontFile.name -Scope User -Method Shell
		Remove-Item $fontFile.name
	}
}
Remove-Item "Install-Font.ps1"
