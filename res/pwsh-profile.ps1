$ompTheme = (Split-Path $Profile) + "\oh-my-posh-theme.omp.json"
oh-my-posh init pwsh --config $ompTheme | Invoke-Expression
Import-Module posh-git
$env:POSH_GIT_ENABLED = $true

Import-Module Terminal-Icons

Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Chord "Ctrl+RightArrow" -Function ForwardWord
