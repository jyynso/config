oh-my-posh init pwsh --config "$env:USERPROFILE\Documents\PowerShell\takuyaGruv.omp.json" | Invoke-Expression

#Aliases
Set-Alias ff fastfetch.exe
Set-Alias vim nvim
Set-Alias g git
Set-Alias adb .\adb
Set-Alias lg lazygit

#functionscause pwsh is a bitch
function ll {
    eza -l --icons $args
}

function la {
    eza -la --icons $args
}

function komo {
	komorebic start --whkd 
}

function komos {
	komorebic stop --whkd
}

function komor {
	komorebic stop; komorebic start --whkd
}

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
