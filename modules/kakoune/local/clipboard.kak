declare-user-mode clip

map global user c ': enter-user-mode clip<ret>' \
  -docstring 'clipboard commands'

map global clip y %{<a-|>wl-copy<ret>} \
  -docstring "Copy selection to clipboard"

map global clip p %{<!>wl-paste -n<ret>} \
  -docstring "Paste clipboard before selection" 
map  global clip P %{<a-!>lwl-paste -n<ret>} \
  -docstring "Paste clipboard after selection"
