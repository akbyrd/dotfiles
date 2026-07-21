$env:VSCODE_DEV = ""
$env:ELECTRON_RUN_AS_NODE = 1
$VSCODE_DIR = "$env:LOCALAPPDATA\Programs\Microsoft VS Code"
$VSCODE_ARGS = @("3c631b164c\resources\app\out\cli.js") + $args

Push-Location $VSCODE_DIR
try
{
	Start-Process "$VSCODE_DIR\Code.exe" $VSCODE_ARGS -RedirectStandardOutput Out-Default
}
finally
{
	Pop-Location
}
