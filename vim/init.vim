" Seems like CFGDIR and DATADIR should be already set up somewhere?
let s:defaultdir=has('win32') ? $HOME.'\AppData\Local\nvim' : $HOME.'/.config/vim'
let $CFGDIR=empty($XDG_CONFIG_HOME) ? s:defaultdir : $XDG_CONFIG_HOME.'/vim'
set runtimepath+=$CFGDIR

" this might be dangerous at some point, but for now it's fine.
let s:defaultdir=has('win32') ? $HOME.'\AppData\Local\nvim-data' : $HOME.'/.local/share/vim'
let $DATADIR=empty($XDG_DATA_HOME) ? s:defaultdir : $XDG_DATA_HOME.'/vim'

runtime shared.vim
runtime plugins.vim
runtime local.vim
" vim: set ts=2 sw=2 tw=99 noet :
