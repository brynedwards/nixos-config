hook global WinSetOption filetype=json %{
    set-option buffer formatcmd 'jq .'
}
