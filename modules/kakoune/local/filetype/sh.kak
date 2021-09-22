hook global WinSetOption filetype=sh %{
    set-option buffer formatcmd shfmt
    set-option buffer indentwidth 0
}

hook global BufCreate (.*/)?\.in %{
  set-option buffer filetype sh
}
