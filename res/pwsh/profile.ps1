$pwshProfile = $Profile.CurrentUserAllHosts
$ompTheme = "$(Split-Path $pwshProfile)\theme.omp.json"

((& oh-my-posh init pwsh --config $ompTheme --print) -join "`n") | Invoke-Expression
$env:POSH_GIT_ENABLED = $true
#Import-Module Terminal-Icons

function Inject-Command([String] $command)
{
	[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
	[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert($command)
	[Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

function Revert-LineAndPrediction
{
	[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
	[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
}

function Reload-Path
{
	$SysEnv = [System.Environment]
	$EnvVar = [System.EnvironmentVariableTarget]

	$userPath = $SysEnv::GetEnvironmentVariable("Path", $EnvVar::User)
	$machPath = $SysEnv::GetEnvironmentVariable("Path", $EnvVar::Machine)
	$env:Path = "$machPath;$userPath"
}

function Backup-Config { &"$env:DotfilesDir\setup.ps1" Backup }
function Restore-Config { &"$env:DotfilesDir\setup.ps1" Restore }
function Edit-Profile { code $pwshProfile }
function Reload-Profile { .$pwshProfile }
function Edit-Theme { code $ompTheme }
function Exit-Shell { exit }

Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -CompletionQueryItems 1e6

Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Chord "Ctrl+w"       -Description "Exit-Shell"     -ScriptBlock { Inject-Command("Exit-Shell") }
Set-PSReadLineKeyHandler -Chord "Ctrl+l"       -Description "Clear-Host"     -ScriptBlock { Inject-Command("Clear-Host") }
Set-PSReadLineKeyHandler -Chord "Escape"       -Description "Revert-Line"    -ScriptBlock { Revert-LineAndPrediction }
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+<" -Description "Edit-Profile"   -ScriptBlock { Inject-Command("Edit-Profile") }
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+>" -Description "Reload-Profile" -ScriptBlock { Inject-Command("Reload-Profile") }
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+?" -Description "Edit-Theme"     -ScriptBlock { Inject-Command("Edit-Theme") }

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
