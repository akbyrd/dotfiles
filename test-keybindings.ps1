Function Inject-Command([String] $command) {
	[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert($command)
	[Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadLineKeyHandler -Chord "Ctrl+," -ScriptBlock { Inject-Command("echo success") } # pwsh - works,        vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+." -ScriptBlock { Inject-Command("echo success") } # pwsh - works,        vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+/" -ScriptBlock { Inject-Command("echo success") } # pwsh - works,        vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+;" -ScriptBlock { Inject-Command("echo success") } # pwsh - works,        vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+'" -ScriptBlock { Inject-Command("echo success") } # pwsh - works,        vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+[" -ScriptBlock { Inject-Command("echo success") } # pwsh - doesn't work, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+]" -ScriptBlock { Inject-Command("echo success") } # pwsh - works,        vscode - works
Set-PSReadLineKeyHandler -Chord "Ctrl+\" -ScriptBlock { Inject-Command("echo success") } # pwsh - works,        vscode - works

Set-PSReadLineKeyHandler -Chord "Alt+," -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - mnemonics
Set-PSReadLineKeyHandler -Chord "Alt+." -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - mnemonics
Set-PSReadLineKeyHandler -Chord "Alt+/" -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - mnemonics
Set-PSReadLineKeyHandler -Chord "Alt+;" -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - mnemonics
Set-PSReadLineKeyHandler -Chord "Alt+'" -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - mnemonics
Set-PSReadLineKeyHandler -Chord "Alt+[" -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - mnemonics
Set-PSReadLineKeyHandler -Chord "Alt+]" -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - mnemonics
Set-PSReadLineKeyHandler -Chord "Alt+\" -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - mnemonics

Set-PSReadLineKeyHandler -Chord "Shift+<"  -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - works
Set-PSReadLineKeyHandler -Chord "Shift+>"  -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - works
Set-PSReadLineKeyHandler -Chord "Shift+?"  -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - works
Set-PSReadLineKeyHandler -Chord "Shift+:"  -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - works
Set-PSReadLineKeyHandler -Chord "Shift+`"" -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - works
Set-PSReadLineKeyHandler -Chord "Shift+{"  -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - works
Set-PSReadLineKeyHandler -Chord "Shift+}"  -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - works
Set-PSReadLineKeyHandler -Chord "Shift+|"  -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - works

Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+." -ScriptBlock { Inject-Command("echo success") } # pwsh - doesn't work, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+/" -ScriptBlock { Inject-Command("echo success") } # pwsh - doesn't work, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+;" -ScriptBlock { Inject-Command("echo success") } # pwsh - doesn't work, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+'" -ScriptBlock { Inject-Command("echo success") } # pwsh - doesn't work, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+[" -ScriptBlock { Inject-Command("echo success") } # pwsh - doesn't work, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+]" -ScriptBlock { Inject-Command("echo success") } # pwsh - works,        vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+\" -ScriptBlock { Inject-Command("echo success") } # pwsh - works,        vscode - doesn't work

Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+<"  -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+>"  -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+?"  -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+:"  -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+`"" -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+{"  -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+}"  -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+|"  -ScriptBlock { Inject-Command("echo success") } # pwsh - works, vscode - doesn't work

Set-PSReadLineKeyHandler -Chord "Alt+Shift+<"  -ScriptBlock { Inject-Command("echo success") } # pwsh - works,        vscode - works (mnemonics)
Set-PSReadLineKeyHandler -Chord "Alt+Shift+>"  -ScriptBlock { Inject-Command("echo success") } # pwsh - works,        vscode - works (mnemonics)
Set-PSReadLineKeyHandler -Chord "Alt+Shift+?"  -ScriptBlock { Inject-Command("echo success") } # pwsh - works,        vscode - works (mnemonics)
Set-PSReadLineKeyHandler -Chord "Alt+Shift+:"  -ScriptBlock { Inject-Command("echo success") } # pwsh - works,        vscode - works (mnemonics)
Set-PSReadLineKeyHandler -Chord "Alt+Shift+`"" -ScriptBlock { Inject-Command("echo success") } # pwsh - works,        vscode - works (mnemonics)
Set-PSReadLineKeyHandler -Chord "Alt+Shift+{"  -ScriptBlock { Inject-Command("echo success") } # pwsh - works,        vscode - works (mnemonics)
Set-PSReadLineKeyHandler -Chord "Alt+Shift+}"  -ScriptBlock { Inject-Command("echo success") } # pwsh - works,        vscode - works (mnemonics)
Set-PSReadLineKeyHandler -Chord "Alt+Shift+|"  -ScriptBlock { Inject-Command("echo success") } # pwsh - doesn't work, vscode - works (mnemonics)

Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+Shift+<"  -ScriptBlock { Inject-Command("echo success") } # pwsh - doesn't work (crazy shit), vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+Shift+>"  -ScriptBlock { Inject-Command("echo success") } # pwsh - doesn't work (crazy shit), vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+Shift+?"  -ScriptBlock { Inject-Command("echo success") } # pwsh - doesn't work (crazy shit), vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+Shift+:"  -ScriptBlock { Inject-Command("echo success") } # pwsh - doesn't work (crazy shit), vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+Shift+`"" -ScriptBlock { Inject-Command("echo success") } # pwsh - doesn't work (crazy shit), vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+Shift+{"  -ScriptBlock { Inject-Command("echo success") } # pwsh - doesn't work (crazy shit), vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+Shift+}"  -ScriptBlock { Inject-Command("echo success") } # pwsh - doesn't work (crazy shit), vscode - doesn't work
Set-PSReadLineKeyHandler -Chord "Ctrl+Alt+Shift+|"  -ScriptBlock { Inject-Command("echo success") } # pwsh - doesn't work (crazy shit), vscode - doesn't work
