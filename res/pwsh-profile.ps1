$pwshProfile = $Profile.CurrentUserAllHosts
$ompTheme = (Split-Path $pwshProfile) + "\oh-my-posh-theme.omp.json"

oh-my-posh init pwsh --config $ompTheme | Invoke-Expression

Import-Module posh-git
$env:POSH_GIT_ENABLED = $true

Import-Module Terminal-Icons

Function Inject-Command([String] $command) {
	[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert($command)
	[Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Function Edit-Profile { code $pwshProfile }
Function Reload-Profile { .$pwshProfile }
Function Edit-Theme { code $ompTheme }
Function Exit-Shell { Exit }

Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -CompletionQueryItems 1e6
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Chord "Ctrl+RightArrow" -Function ForwardWord
Set-PSReadLineKeyHandler -Chord "Shift+<" -ScriptBlock { Inject-Command("Edit-Profile") }
Set-PSReadLineKeyHandler -Chord "Shift+>" -ScriptBlock { Inject-Command("Reload-Profile") }
Set-PSReadLineKeyHandler -Chord "Shift+?" -ScriptBlock { Inject-Command("Edit-Theme") }

# Tab auto-completion for winget
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
	param($wordToComplete, $commandAst, $cursorPosition)
		[Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
		$Local:word = $wordToComplete.Replace('"', '""')
		$Local:ast = $commandAst.ToString().Replace('"', '""')
		winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
			[System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
		}
}
