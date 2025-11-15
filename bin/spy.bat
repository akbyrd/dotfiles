@ECHO OFF

SET VS_WHERE="%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
FOR /F "delims=" %%P IN ('%VS_WHERE% -latest -property installationPath') DO (
	SET VS_INSTALL_DIR=%%P
)

START "" "%VS_INSTALL_DIR%\Common7\Tools\spyxx_amd64.exe"
