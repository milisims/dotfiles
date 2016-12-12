#!/usr/bin/zsh
#------------------------------------------////
# Terminal title settings
#------------------------------------------////

# TODO: when executing a command, rename title?
precmd () {print -Pn "\e]0;%n@%m: %~\a"}

