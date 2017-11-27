" Section: General
" adds to front, so it will be overridden by everything else
set runtimepath+=~/.config/vim

let $TERM='xterm'                         " not sure why, but having some color issues on
let $COLORTERM='gnome-terminal'           " some terms which are solved by these two lines
let $VARPATH=$HOME.'/.local/share/nvim'   " should depend on XDG_CONFIG?

runtime general.vim
runtime file.vim
runtime map.vim
runtime plugins.vim
runtime local.vim
