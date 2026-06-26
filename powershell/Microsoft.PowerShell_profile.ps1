oh-my-posh init pwsh --config "$env:USERPROFILE\Documents\PowerShell\takuyaGruv.omp.json" | Invoke-Expression

Set-Alias nvim nvim
Set-Alias ff fastfetch.exe
Set-Alias g git
Set-Alias lg lazygit
Set-Alias leg Legendary

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

