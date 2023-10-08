@ECHO OFF

SET VS_WHERE="%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
FOR /F "delims=" %%P IN ('%VS_WHERE% -latest -property installationPath') DO (
	SET VS_INSTALL_DIR=%%P
)

IF [%1] == [] (
	CALL "%VS_INSTALL_DIR%\VC\Auxiliary\Build\vcvars64.bat"
) ELSE (
	CALL "%VS_INSTALL_DIR%\VC\Auxiliary\Build\vcvarsall.bat" %*
)

:: vcvars scripts don't set errorlevel reliably. Just check for cl directly
where cl >nul 2>&1
IF %ERRORLEVEL% NEQ 0 EXIT

code-gui.bat
