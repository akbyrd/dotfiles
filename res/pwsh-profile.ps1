$pwshProfile = $Profile.CurrentUserAllHosts
$ompTheme = (Split-Path $pwshProfile) + "\oh-my-posh-theme.omp.json"

((& oh-my-posh init pwsh --config $ompTheme --print) -join "`n") | Invoke-Expression
$env:POSH_GIT_ENABLED = $true
#Import-Module Terminal-Icons

function Inject-Command([String] $command) {
	[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
	[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert($command)
	[Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

function Revert-LineAndPrediction {
	[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
	[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
}

function Edit-Profile { code $pwshProfile }
function Reload-Profile { .$pwshProfile }
function Edit-Theme { code $ompTheme }
function Exit-Shell { exit }

Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -CompletionQueryItems 1e6

Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Chord "Ctrl+RightArrow" -Function ForwardWord
Set-PSReadLineKeyHandler -Chord "Ctrl+w" -ScriptBlock { Inject-Command("Exit-Shell") }
Set-PSReadLineKeyHandler -Chord "Ctrl+l" -ScriptBlock { Inject-Command("Clear-Host") }
Set-PSReadLineKeyHandler -Chord "Escape" -ScriptBlock { Revert-LineAndPrediction }
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+<" -ScriptBlock { Inject-Command("Edit-Profile") }
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+>" -ScriptBlock { Inject-Command("Reload-Profile") }
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+?" -ScriptBlock { Inject-Command("Edit-Theme") }
Set-PSReadLineKeyHandler -Chord "Ctrl+LeftArrow" -Function ShellBackwardWord
Set-PSReadLineKeyHandler -Chord "Ctrl+RightArrow" -Function ShellForwardWord
Set-PSReadLineKeyHandler -Chord "Shift+Ctrl+LeftArrow" -Function SelectShellBackwardWord
Set-PSReadLineKeyHandler -Chord "Shift+Ctrl+RightArrow" -Function SelectShellForwardWord

# Tab auto-completion for winget
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
	param($wordToComplete, $commandAst, $cursorPosition)
		[Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
		$local:word = $wordToComplete.Replace('"', '""')
		$local:ast = $commandAst.ToString().Replace('"', '""')
		winget complete --word="$local:word" --commandline "$local:ast" --position $cursorPosition | ForEach-Object {
			[System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
		}
}
