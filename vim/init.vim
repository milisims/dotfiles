let s:defaultdir=has('win32') ? $HOME.'\AppData\Local\nvim' : $HOME.'/.config/nvim'
let $CFGDIR=empty($XDG_CONFIG_HOME) ? s:defaultdir : $XDG_CONFIG_HOME.'/nvim'

" share datadir with vim
" this might be dangerous at some point, but for now it's fine.
let s:defaultdir=has('win32') ? $HOME.'\AppData\Local\nvim-data' : $HOME.'/.local/share/vim'
let $DATADIR=empty($XDG_DATA_HOME) ? s:defaultdir : $XDG_DATA_HOME.'/vim'
" vim: set ts=2 sw=2 tw=99 noet :
