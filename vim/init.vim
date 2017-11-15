" Section: General
" adds to front, so it will be overridden by everything else
set runtimepath+=~/.config/vim

let $TERM='xterm'                         " not sure why, but having some color issues on
let $COLORTERM='gnome-terminal'           " some terms which are solved by these two lines
let $VARPATH=$HOME.'/.local/share/nvim'   " should depend on XDG_CONFIG?

" Section: plugins
call plug#begin('~/.config/nvim/plugged')
runtime plugin-list.vim
runtime plugin-list-neovim.vim
call plug#end()

runtime general.vim
runtime file.vim
runtime map.vim
runtime plugin-configs.vim
runtime local.vim

runtime plugin-configs-neovim.vim
runtime local-neovim.vim
