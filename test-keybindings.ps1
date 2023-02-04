<#
    .   + +
    oem - -
c   .   + -
c   oem + -
s   >   + +
s   oem - -
a   .   + +
a   oem - -
cs  >   + -
cs  oem + -
ca  .   - -
ca  oem + -
sa  >   + +
sa  oem - -
csa >   - -
csa oem + -
#>

Function Inject-Command([String] $command) {
	[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert($command)
	[Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadLineKeyHandler -Chord "Ctrl+," -ScriptBlock { Inject-Command("echo Ctrl+,") } # +pwsh, -vscode
Set-PSReadLineKeyHandler -Chord "Ctrl+." -ScriptBlock { Inject-Command("echo Ctrl+.") } # +pwsh, -vscode
Set-PSReadLineKeyHandler -Chord "Ctrl+/" -ScriptBlock { Inject-Command("echo Ctrl+/") } # +pwsh, -vscode
Set-PSReadLineKeyHandler -Chord "Ctrl+;" -ScriptBlock { Inject-Command("echo Ctrl+;") } # +pwsh, -vscode
Set-PSReadLineKeyHandler -Chord "Ctrl+'" -ScriptBlock { Inject-Command("echo Ctrl+'") } # +pwsh, -vscode
Set-PSReadLineKeyHandler -Chord "Ctrl+[" -ScriptBlock { Inject-Command("echo Ctrl+[") } # -pwsh, -vscode
Set-PSReadLineKeyHandler -Chord "Ctrl+]" -ScriptBlock { Inject-Command("echo Ctrl+]") } # +pwsh, +vscode
Set-PSReadLineKeyHandler -Chord "Ctrl+\" -ScriptBlock { Inject-Command("echo Ctrl+\") } # +pwsh, +vscode

Set-PSReadLineKeyHandler -Chord "Shift+<"  -ScriptBlock { Inject-Command("echo Shift+<" ) } # +pwsh, +vscode
Set-PSReadLineKeyHandler -Chord "Shift+>"  -ScriptBlock { Inject-Command("echo Shift+>" ) } # +pwsh, +vscode
Set-PSReadLineKeyHandler -Chord "Shift+?"  -ScriptBlock { Inject-Command("echo Shift+?" ) } # +pwsh, +vscode
Set-PSReadLineKeyHandler -Chord "Shift+:"  -ScriptBlock { Inject-Command("echo Shift+:" ) } # +pwsh, +vscode
Set-PSReadLineKeyHandler -Chord "Shift+`"" -ScriptBlock { Inject-Command("echo Shift+`"") } # +pwsh, +vscode
Set-PSReadLineKeyHandler -Chord "Shift+{"  -ScriptBlock { Inject-Command("echo Shift+{" ) } # +pwsh, +vscode
Set-PSReadLineKeyHandler -Chord "Shift+}"  -ScriptBlock { Inject-Command("echo Shift+}" ) } # +pwsh, +vscode
Set-PSReadLineKeyHandler -Chord "Shift+|"  -ScriptBlock { Inject-Command("echo Shift+|" ) } # +pwsh, +vscode

Set-PSReadLineKeyHandler -Chord "Alt+," -ScriptBlock { Inject-Command("echo Alt+,") } # pwsh - works, vscode - mnemonics
Set-PSReadLineKeyHandler -Chord "Alt+." -ScriptBlock { Inject-Command("echo Alt+.") } # pwsh - works, vscode - mnemonics
Set-PSReadLineKeyHandler -Chord "Alt+/" -ScriptBlock { Inject-Command("echo Alt+/") } # pwsh - works, vscode - mnemonics
Set-PSReadLineKeyHandler -Chord "Alt+;" -ScriptBlock { Inject-Command("echo Alt+;") } # pwsh - works, vscode - mnemonics
Set-PSReadLineKeyHandler -Chord "Alt+'" -ScriptBlock { Inject-Command("echo Alt+'") } # pwsh - works, vscode - mnemonics
Set-PSReadLineKeyHandler -Chord "Alt+[" -ScriptBlock { Inject-Command("echo Alt+[") } # pwsh - works, vscode - mnemonics
Set-PSReadLineKeyHandler -Chord "Alt+]" -ScriptBlock { Inject-Command("echo Alt+]") } # pwsh - works, vscode - mnemonics
Set-PSReadLineKeyHandler -Chord "Alt+\" -ScriptBlock { Inject-Command("echo Alt+\") } # pwsh - works, vscode - mnemonics

Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+." -ScriptBlock { Inject-Command("echo Ctrl+Alt+.") } # pwsh - doesn't work, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+/" -ScriptBlock { Inject-Command("echo Ctrl+Alt+/") } # pwsh - doesn't work, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+;" -ScriptBlock { Inject-Command("echo Ctrl+Alt+;") } # pwsh - doesn't work, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+'" -ScriptBlock { Inject-Command("echo Ctrl+Alt+'") } # pwsh - doesn't work, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+[" -ScriptBlock { Inject-Command("echo Ctrl+Alt+[") } # pwsh - doesn't work, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+]" -ScriptBlock { Inject-Command("echo Ctrl+Alt+]") } # pwsh - works,        vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+\" -ScriptBlock { Inject-Command("echo Ctrl+Alt+\") } # pwsh - works,        vscode - doesn't work

Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+<"  -ScriptBlock { Inject-Command("echo Ctrl+Shift+<" ) } # pwsh - works, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+>"  -ScriptBlock { Inject-Command("echo Ctrl+Shift+>" ) } # pwsh - works, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+?"  -ScriptBlock { Inject-Command("echo Ctrl+Shift+?" ) } # pwsh - works, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+:"  -ScriptBlock { Inject-Command("echo Ctrl+Shift+:" ) } # pwsh - works, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+`"" -ScriptBlock { Inject-Command("echo Ctrl+Shift+`"") } # pwsh - works, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+{"  -ScriptBlock { Inject-Command("echo Ctrl+Shift+{" ) } # pwsh - works, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+}"  -ScriptBlock { Inject-Command("echo Ctrl+Shift+}" ) } # pwsh - works, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+|"  -ScriptBlock { Inject-Command("echo Ctrl+Shift+|" ) } # pwsh - works, vscode - doesn't work

Set-PSReadLineKeyHandler -Chord "Alt+Shift+<"  -ScriptBlock { Inject-Command("echo Alt+Shift+<" ) } # pwsh - works,        vscode - works (mnemonics)
Set-PSReadLineKeyHandler -Chord "Alt+Shift+>"  -ScriptBlock { Inject-Command("echo Alt+Shift+>" ) } # pwsh - works,        vscode - works (mnemonics)
Set-PSReadLineKeyHandler -Chord "Alt+Shift+?"  -ScriptBlock { Inject-Command("echo Alt+Shift+?" ) } # pwsh - works,        vscode - works (mnemonics)
Set-PSReadLineKeyHandler -Chord "Alt+Shift+:"  -ScriptBlock { Inject-Command("echo Alt+Shift+:" ) } # pwsh - works,        vscode - works (mnemonics)
Set-PSReadLineKeyHandler -Chord "Alt+Shift+`"" -ScriptBlock { Inject-Command("echo Alt+Shift+`"") } # pwsh - works,        vscode - works (mnemonics)
Set-PSReadLineKeyHandler -Chord "Alt+Shift+{"  -ScriptBlock { Inject-Command("echo Alt+Shift+{" ) } # pwsh - works,        vscode - works (mnemonics)
Set-PSReadLineKeyHandler -Chord "Alt+Shift+}"  -ScriptBlock { Inject-Command("echo Alt+Shift+}" ) } # pwsh - works,        vscode - works (mnemonics)
Set-PSReadLineKeyHandler -Chord "Alt+Shift+|"  -ScriptBlock { Inject-Command("echo Alt+Shift+|" ) } # pwsh - doesn't work, vscode - works (mnemonics)

Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+Shift+<"  -ScriptBlock { Inject-Command("echo Ctrl+Alt+Shift+<" ) } # pwsh - doesn't work, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+Shift+>"  -ScriptBlock { Inject-Command("echo Ctrl+Alt+Shift+>" ) } # pwsh - doesn't work, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+Shift+?"  -ScriptBlock { Inject-Command("echo Ctrl+Alt+Shift+?" ) } # pwsh - doesn't work, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+Shift+:"  -ScriptBlock { Inject-Command("echo Ctrl+Alt+Shift+:" ) } # pwsh - doesn't work, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+Shift+`"" -ScriptBlock { Inject-Command("echo Ctrl+Alt+Shift+`"") } # pwsh - doesn't work, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+Shift+{"  -ScriptBlock { Inject-Command("echo Ctrl+Alt+Shift+{" ) } # pwsh - doesn't work, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+Shift+}"  -ScriptBlock { Inject-Command("echo Ctrl+Alt+Shift+}" ) } # pwsh - doesn't work, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+Shift+|"  -ScriptBlock { Inject-Command("echo Ctrl+Alt+Shift+|" ) } # pwsh - doesn't work, vscode - doesn't work
