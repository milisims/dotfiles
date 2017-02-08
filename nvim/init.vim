" Section: General
set runtimepath+=~/.config/vim

" Section: plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'           " Jedi (python) completion
Plug 'Shougo/neco-vim'               " vim completion

Plug 'Shougo/denite.nvim'            " makes a nice buffer to search through
Plug 'Shougo/neomru.vim'             " most recently used files source
Plug 'Shougo/neoinclude.vim'         " include files source
Plug 'chemzqm/unite-location'        " quickfix and location list source

Plug 'Konfekt/FastFold'              " updates only when necessary

" for linting and automatic execution of linting
Plug 'neomake/neomake'

source ~/.config/vim/plugins.vim     " basic plugins, visual stuff

call plug#end()

" might be able to remove this after an update soon:
" Tue 24 Jan 2017 06:08:18 PM EST
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0

" Section: modular configs
runtime! config/*.vim
runtime! config/plugins/*.vim
runtime! local.vim
