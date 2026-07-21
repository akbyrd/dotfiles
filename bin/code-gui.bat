@ECHO OFF
SETLOCAL

SET VSCODE_DEV=
SET ELECTRON_RUN_AS_NODE=1
SET VSCODE_DIR=%LOCALAPPDATA%\Programs\Microsoft VS Code
START "" "%VSCODE_DIR%\Code.exe" "%VSCODE_DIR%\3c631b164c\resources\app\out\cli.js" --ms-enable-electron-run-as-node %*

ENDLOCAL
