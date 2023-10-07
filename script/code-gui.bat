@echo off
setlocal
set VSCODE_DEV=
set ELECTRON_RUN_AS_NODE=1
set VSCODE_DIR=C:\Users\akbyrd\AppData\Local\Programs\Microsoft VS Code\
start "" "%VSCODE_DIR%\Code.exe" "%VSCODE_DIR%\resources\app\out\cli.js" --ms-enable-electron-run-as-node %*
endlocal
