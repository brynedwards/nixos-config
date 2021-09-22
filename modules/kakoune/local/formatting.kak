declare-user-mode fmt

map global user f ': enter-user-mode fmt<ret>' \
  -docstring 'formatting commands'

map -docstring "Comment the current line" global fmt c %{: comment-line<ret>}
map -docstring "Comment the current selection" global fmt C %{: comment-block<ret>}
map -docstring "Run formatter on file" global fmt f %{: format<ret>}
map -docstring "Format selection to 80 column width" global fmt w '|fmt -w80<ret>'
