hook global WinSetOption filetype=(c|cpp) %{
  ctags-enable-autocomplete
  ctags-disable-autocomplete

  map buffer goto d ':: ctags-search<ret>'\
      -docstring 'definition (universal-ctags)'

  # gdb commands
  # declare-user-mode gdb

  # map global user G ': enter-user-mode gdb<ret>' \
  #   -docstring 'gdb commands'

  # map global gdb b ': gdb-toggle-breakpoint<ret>' \
  #   -docstring "toggle breakpoint"
  # map global gdb c ': gdb-continue-or-run<ret>' \
  #   -docstring "continue or run"
}

