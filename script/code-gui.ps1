$env:VSCODE_DEV = ""
$env:ELECTRON_RUN_AS_NODE = 1
$VSCODE_DIR = "$env:APPDATA\Local\Programs\Microsoft VS Code"
$VSCODE_ARGS = "resources\app\out\cli.js", "--ms-enable-electron-run-as-node" + $args

Push-Location $VSCODE_DIR
try
{
	Start-Process "$VSCODE_DIR\Code.exe" $VSCODE_ARGS -RedirectStandardOutput Out-Default
}
finally
{
	Pop-Location
}
