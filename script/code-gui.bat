@ECHO OFF
SETLOCAL

SET VSCODE_DEV=
SET ELECTRON_RUN_AS_NODE=1
SET VSCODE_DIR=C:\Users\akbyrd\AppData\Local\Programs\Microsoft VS Code\
START "" "%VSCODE_DIR%\Code.exe" "%VSCODE_DIR%\resources\app\out\cli.js" --ms-enable-electron-run-as-node %*

ENDLOCAL
