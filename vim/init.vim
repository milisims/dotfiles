" Seems like CFGDIR and DATADIR should be already set up somewhere?
let s:defaultdir=has('windows') ? $HOME.'/.config/vim' : $HOME.'\AppData\Local\nvim'
let $CFGDIR=empty($XDG_CONFIG_HOME) ? s:defaultdir : $XDG_CONFIG_HOME.'/vim'
set runtimepath+=$CFGDIR

" this might be dangerous at some point, but for now it's fine.
let s:defaultdir=has('windows') ? $HOME.'/.local/share/vim' : $HOME.'\AppData\Local\nvim-data'
let $DATADIR=empty($XDG_DATA_HOME) ? s:defaultdir : $XDG_DATA_HOME.'/vim'

runtime general.vim
runtime file.vim
runtime map.vim
runtime plugins.vim
runtime local.vim
