@ECHO OFF

SET VC_DIR=C:\Program Files\Microsoft Visual Studio\2022\Community\VC

IF [%1] == [] (
	"%VC_DIR%\Auxiliary\Build\vcvars64.bat"
) ELSE (
	"%VC_DIR%\Auxiliary\Build\vcvarsall.bat" %*
)

code-gui.bat
