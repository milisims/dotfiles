#!/usr/bin/zsh
#------------------------------------------////
# Functions
#------------------------------------------////
alias open=open_command
    function open_command() {
    emulate -L zsh
    setopt shwordsplit

    local open_cmd exit_code

    # define the open command
    case "$OSTYPE" in
        darwin*)    open_cmd='open' ;;
        linux*)     open_cmd='xdg-open' ;;
        *)          echo "Platform $OSTYPE not supported"
                    return 1
                    ;;
    esac

    # don't use nohup on OSX
    if [[ "$OSTYPE" == darwin* ]]; then
        $open_cmd "$@" &>/dev/null
    else
        nohup $open_cmd "$@" &>/dev/null
    fi
    exit_code=$?
    if [[ "$retval" -ne 0 ]]; then
        echo "Exit: $?"
    fi
}
#
