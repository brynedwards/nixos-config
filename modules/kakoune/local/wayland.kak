define-command wl-terminal-float -params 1.. -shell-completion -docstring '
wl-terminal <program> [<arguments>]: create a new terminal
The program passed as argument will be executed in the new terminal' \
%{
    evaluate-commands -save-regs 'a' %{
        set-register a %arg{@}
        evaluate-commands %sh{
            setsid foot -f "Mono:size=${TERM_FLOAT_FONT_SIZE:-14}" -a 'foot-floating' -W "${TERM_FLOAT_GEOMETRY:-80x24}" sh -c "$kak_quoted_reg_a" < /dev/null > /dev/null 2>&1 &
        }
    }
}

alias global terminal-float wl-terminal-float

