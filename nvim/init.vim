" Section: General
" adds to front, so it will be overridden by everything else
set runtimepath+=~/.config/vim

let $TERM='xterm'
let $COLORTERM='gnome-terminal'
let $VARPATH=$HOME.'/.local/share/nvim'    " Not sure where, but this should depend  on XDG_CONFIG

" Section: plugins
call plug#begin('~/.config/nvim/plugged')
source ~/.config/vim/plugins.vim     " basic plugins, visual stuff, kept lightweight
source ~/.config/nvim/plugins.vim    " neovim specific or 'bigger' plugins
call plug#end()

" Section: modular configs
runtime! config/*.vim
runtime! config/plugins/*.vim
runtime! local.vim
