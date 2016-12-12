#!/usr/bin/zsh

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

local orginial_dir=$PWD
source ${0:a:h}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[path]=none
