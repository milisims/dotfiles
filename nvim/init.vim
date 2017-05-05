" Section: General
set runtimepath+=~/.config/vim

" Section: plugins
call plug#begin('~/.config/nvim/plugged')
source ~/.config/nvim/plugins.vim    " neovim specific or 'bigger' plugins
source ~/.config/vim/plugins.vim     " basic plugins, visual stuff, kept lightweight
call plug#end()

" Section: modular configs
runtime! config/*.vim
runtime! config/plugins/*.vim
runtime! local.vim
