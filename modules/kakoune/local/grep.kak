declare-user-mode grep
map global user g ': enter-user-mode grep<ret>' \
  -docstring 'grep commands'
map global normal <c-g> ": grep " \
  -docstring 'grep current selection'
map global grep g ': grep-jump<ret>' \
  -docstring 'go to highlighted match'
map global grep n ': grep-next-match<ret>' \
  -docstring 'go to next match'
map global grep p ': grep-previous-match<ret>' \
  -docstring 'go to previous match'
map global grep b ': b *grep*<ret>' \
  -docstring 'go to grep buffer'
