""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: Leader
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = " "     " <leader> mapping
let g:mapleader = " "   " global?
inoremap jk <ESC>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: Command mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cnoremap $h e $HOME/
cnoremap $d <C-\>eCurrentFileDir("e")<CR>
cnoremap $j e ./
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: Normal mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Makes up and down work as expected
nnoremap j gj
nnoremap k gk

" clear search highlights
nnoremap <silent> <leader><CR> :nohlsearch<CR>

" Better way to move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Close the current buffer
nnoremap <leader>bd :bd<CR>

" Close all the buffers
nnoremap <leader>ba :1,300 bd!<CR>

" Use the arrows to something usefull
nnoremap <right> :bn<CR>
nnoremap <left> :bp<CR>
nnoremap <up> :lprev<CR>
nnoremap <down> :lnext<CR>

" Windows, wk for window kill, wc still works
nnoremap <leader>w <C-w>

" When pressing <leader>cd switch to the directory of the open buffer
nnoremap <leader>cd :cd %:p:h<CR>

"Remap VIM 0
nnoremap 0 ^

" Make cmd work as alt
if has("mac")
  nnoremap <D-j> <M-j>
  nnoremap <D-k> <M-k>
  vnoremap <D-j> <M-j>
  vnoremap <D-k> <M-k>
endif

" Move a line of text using ALT+[jk]
" Maybe do this with up/down?
nnoremap <M-j> mz:m+<CR>`z
nnoremap <M-k> mz:m-2<CR>`z
vnoremap <M-j> :m'>+<CR>`<my`>mzgv`yo`z
vnoremap <M-k> :m'<-2<CR>`>my`<mzgv`yo`z

" Insert a newline from cursor
nnoremap <CR> i<CR><Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: Insert mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set pastetoggle=<F2>    " paste toggle for insert mode only
