let $CFGDIR='MYCFGDIR'
set runtimepath^=$CFGDIR

" share datadir with vim
let s:defaultdir=has('win32') ? $HOME.'\AppData\Local\nvim-data' : $HOME.'/.local/share/vim'
let $DATADIR=empty($XDG_DATA_HOME) ? s:defaultdir : $XDG_DATA_HOME.'/vim'

runtime mysettings.vim
runtime myplugins.vim
" vim: set ts=2 sw=2 tw=99 noet :
