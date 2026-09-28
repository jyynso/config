oh-my-posh init pwsh --config "$env:USERPROFILE\Documents\PowerShell\takuyaGruv.omp.json" | Invoke-Expression

Set-Alias vim nvim
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
	komorebic start --whkd --bar 
}

function komos {
	komorebic stop --whkd
}

function komor {
	komorebic stop; komorebic start --whkd --bar
}

if ($env:TERM_PROGRAM -eq 'WezTerm' -or $env:WEZTERM_PANE) {
    $parentPrompt = $function:prompt
    function prompt {
        $loc = $ExecutionContext.SessionState.Path.CurrentFileSystemLocation.ProviderPath
        $cleanPath = $loc -replace '\\', '/'
        Write-Host -NoNewline "$([char]27)]7;file://$cleanPath$([char]27)\"
        & $parentPrompt
    }
}
