hook global WinSetOption filetype=rust %{
    set-option buffer indentwidth 0
    set-option buffer formatcmd rustfmt
    lsp-enable-window
    hook buffer BufWritePre .* %{format}

    # set-option buffer gdb_program rust-gdb
}

