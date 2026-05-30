#make pwsh prompt really nice
oh-my-posh init pwsh --config "$env:USERPROFILE\Documents\PowerShell\takuyaGruv.omp.json" | Invoke-Expression
#Aliases
Set-Alias ff fastfetch.exe
Set-Alias vim nvim
Set-Alias g git
Set-Alias adb .\adb
Set-Alias komo komorebicStart
Set-Alias komos komorebicStop
Set-Alias komor komorebicRestart
Set-Alias lg lazygit

#Functions cause pwsh is a bitch

function komorebicStart {
	komorebic start --whkd 
}

function komorebicStop {
	komorebic stop --whkd
}

function komorebicRestart {
	komorebic stop; komorebic start --whkd
}

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
