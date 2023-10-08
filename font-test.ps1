Set-ExecutionPolicy Bypass
.\fonts.ps1
$hash = "02e977fa9e2fdb10f6e2320f6634682309ba4c19"
$url = "https://raw.githubusercontent.com/ralish/PSWinGlue/$hash/Scripts/Install-Font.ps1"
Invoke-WebRequest $url -OutFile "Install-Font.ps1"
foreach ($i in 1..1)
{
	$font = $fonts[$i]
	$baseURL = "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts"
	$path = "$baseURL/$($font.name)/complete/$($font.file)"
	$path = $path.replace(" ", "%20")
	curl -Lo $font.file $path
	.\Install-Font.ps1 $font.file -Scope User -Method Shell
	Remove-Item $font.file
}
Remove-Item $font.file
"Install-Font.ps1"
