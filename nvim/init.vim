" Section: General
set runtimepath+=~/.config/vim

" Section: plugins
call plug#begin('~/.config/nvim/plugged')

" Completion plugins
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'

" Linting
Plug 'neomake/neomake'

" All the things
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neomru.vim'

source ~/.config/vim/plugins.vim
call plug#end()

" Section: modular configs
runtime! config/*.vim
runtime! config/plugins/*.vim
runtime! local.vim
