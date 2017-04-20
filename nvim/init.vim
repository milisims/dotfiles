" Section: General
set runtimepath+=~/.config/vim

" Section: plugins
call plug#begin('~/.config/nvim/plugged')
source ~/.config/nvim/plugins.vim    " neovim specific or 'bigger' plugins
source ~/.config/vim/plugins.vim     " basic plugins, visual stuff, kept lightweight
call plug#end()

" might be able to remove this after an update soon:
" Tue 24 Jan 2017 06:08:18 PM EST
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
" Removed on Thu Apr 20 11:41:03 EDT 2017

" Section: modular configs
runtime! config/*.vim
runtime! config/plugins/*.vim
runtime! local.vim
