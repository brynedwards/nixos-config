hook global BufCreate .*\.cjs %{
    set-option buffer filetype javascript
}

hook global WinSetOption filetype=javascript %{
    set-option buffer formatcmd 'npx prettier --parser flow'
    lsp-enable-window
    hook buffer BufWritePre .* %{format}
}

hook global WinSetOption filetype=typescript %{
    set-option buffer formatcmd 'npx prettier --parser typescript'
    lsp-enable-window
    hook buffer BufWritePre .* %{format}
}
