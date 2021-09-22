hook global WinSetOption filetype=python %{
    set-option buffer indentwidth 4
    set-option buffer formatcmd 'black -'
    lsp-enable-window
    hook buffer BufWritePre .* %{format}
}
