class Font
{
	$name
	$file
}

$fonts = [Font[]] (
	@{
		name = "Inconsolata"
		file = "Inconsolata Regular Nerd Font Complete Windows Compatible.ttf"
	},
	@{
		name = "Inconsolata"
		file = "Inconsolata Bold Nerd Font Complete Windows Compatible.ttf"
	},
	@{
		name = "Inconsolata"
		file = "Inconsolata Regular Nerd Font Complete Mono Windows Compatible.ttf"
	},
	@{
		name = "Inconsolata"
		file = "Inconsolata Bold Nerd Font Complete Mono Windows Compatible.ttf"
	}
)

Set-ExecutionPolicy Bypass
$hash = "c4946587a5978a119165181935e36faa4bbc0bb5"
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
Remove-Item "Install-Font.ps1"
