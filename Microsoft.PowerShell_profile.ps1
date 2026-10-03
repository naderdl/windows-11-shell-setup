#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module
Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58


# ============================================================
# PSReadLine
# ============================================================

Import-Module PSReadLine

Set-PSReadLineOption `
    -PredictionSource HistoryAndPlugin `
    -PredictionViewStyle ListView `
    -EditMode Windows `
    -Colors @{
        Selection              = "`e[7m"
        InlinePrediction       = "`e[38;5;244m"
        ListPrediction         = "`e[38;5;244m"
        ListPredictionSelected = "`e[48;5;238m"
    }

# Prediction navigation
Set-PSReadLineKeyHandler -Chord 'Ctrl+DownArrow' -Function NextSuggestion
Set-PSReadLineKeyHandler -Chord 'Ctrl+UpArrow'   -Function PreviousSuggestion

# Accept next suggested word
Set-PSReadLineKeyHandler -Chord 'Ctrl+RightArrow' -Function AcceptNextSuggestionWord

# Completion
Set-PSReadLineKeyHandler -Chord 'Tab'       -Function MenuComplete
Set-PSReadLineKeyHandler -Chord 'Shift+Tab' -Function TabCompletePrevious


# ============================================================
# Carapace
# ============================================================

carapace _carapace | Out-String | Invoke-Expression


# ============================================================
# PSFzf
# ============================================================

Import-Module PSFzf

Set-PsFzfOption `
    -PSReadlineChordReverseHistory 'Alt+r' `
    -PSReadlineChordProvider 'Ctrl+t'


# ============================================================
# zoxide
# Replace cd with smart zoxide navigation
# ============================================================

Invoke-Expression (& {
    (zoxide init powershell --cmd cd | Out-String)
})


# ============================================================
# eza
# Replace ls with modern directory listing
# ============================================================

Remove-Item Alias:ls -ErrorAction SilentlyContinue

function global:ls {
    eza `
        --icons=auto `
        --group-directories-first `
        @args
}

function global:ll {
    eza `
        -lah `
        --git `
        --icons=auto `
        --group-directories-first `
        @args
}


# ============================================================
# Atuin
# ============================================================

atuin init powershell --disable-ctrl-r | Out-String | Invoke-Expression

Set-PSReadLineKeyHandler -Chord 'Alt+t' -ScriptBlock {
    atuin search -i
}


# ============================================================
# Starship
# Keep last
# ============================================================

Invoke-Expression (&starship init powershell)