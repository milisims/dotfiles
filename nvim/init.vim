" Section: General
set runtimepath+=~/.config/vim

" Section: plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'Konfekt/FastFold'              " updates only when necessary
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'           " Jedi (python) source
Plug 'Shougo/neoinclude.vim'         " include files source
Plug 'Shougo/neco-vim'               " vim source
Plug 'Shougo/neopairs.vim'           " auto inserts parens when necessary
Plug 'Shougo/context_filetype.vim'   " gets filetypes from context?
Plug 'neomake/neomake'               " used for linting, etc.
Plug 'Shougo/denite.nvim'            " makes a nice buffer to search through
Plug 'Shougo/neomru.vim'             " adds most recently used as a den source

source ~/.config/vim/plugins.vim

call plug#end()

" Section: modular configs
runtime! config/*.vim
runtime! config/plugins/*.vim
runtime! local.vim
