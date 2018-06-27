scriptencoding utf-8
" Settings:
" General: {{{
set mouse=niv
set modeline
set report=0
set hidden
set path=.,**
set virtualedit=block
set formatoptions=1crl
set autoread
if has('patch-7.3.541')
  set formatoptions+=j
endif
set ttyfast
set updatetime=500
set winaltkeys=no
set pastetoggle=<F2>
if has('vim_starting')
  set encoding=utf-8
endif
set viewoptions=folds,cursor,slash,unix
if has('clipboard')
  set clipboard+=unnamedplus
endif
set timeout ttimeout
set timeoutlen=750  " Time out on mappings
set ttimeoutlen=250 " for key codes
" }}}
" Backup, Swap, Undo, History: {{{
if exists('$SUDO_USER')
  set nowritebackup
  set noswapfile
else
  set backupdir=$DATADIR/tmp/backup
  set backupdir+=.
  set backup
  set directory=$DATADIR/tmp/swap//  " // necessary
  set directory+=.
  if has("persistent_undo")
    set undodir=$DATADIR/tmp/undo
    set undodir+=.
    set undofile
  endif
endif
set fileformats=unix,dos,mac
set history=10000
if has('nvim')
  if exists('$SUDO_USER') | set shada= | endif
  set shada='300,<10,@50,s100,h
else
  set viminfo='300,<10,@50,h,n$DATADIR/viminfo
endif
" }}}
" Tabs and Indents: {{{
set textwidth=99
set softtabstop=2
set shiftwidth=2
set smarttab
set autoindent
set shiftround
" }}}
" Searching: {{{
set ignorecase
set smartcase
set infercase
set incsearch
set showmatch
set matchtime=3
" }}}
" Behavior: {{{
set nowrap
set linebreak
set breakat=\ \	;:,!?
set nostartofline
set whichwrap+=h,l,[,],~
set splitright
set switchbuf=useopen,usetab
set backspace=indent,eol,start
set diffopt=filler,iwhite
set showfulltag
set completeopt=menuone         " Show menu even for one item
if has('patch-7.4.784')
  set completeopt+=noselect       " Do not select a match in the menu
  set completeopt+=noinsert
endif
if exists('+inccommand')
  set inccommand=nosplit
endif
" }}}
" UI: {{{
set noshowmode
set shortmess=aAoOTI
set scrolloff=4
set sidescrolloff=2
set number
set relativenumber
set lazyredraw
set showtabline=2
set pumheight=20
set showcmd
set cmdheight=2
set cmdwinheight=5
set laststatus=2
set colorcolumn=80
set cursorline
set display=lastline

set list
set listchars=nbsp:⊗
set listchars+=tab:▷‒
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=trail:•
set showbreak=↘
set fillchars=vert:┃
set nojoinspaces


if has('termguicolors')
  set termguicolors
elseif match($TERM, 256) >= 0
  set t_Co=256
endif
colorscheme evolution

if has('patch-7.4.1570')
  set shortmess+=c
  set shortmess+=F
endif

if has('conceal') && v:version >= 703
  set conceallevel=2
endif
" }}}
" Folds: {{{
if has('folding')
  set foldmethod=syntax
  set foldlevelstart=99
endif
set foldtext=fold#text()
" }}}
" Plugin setup: {{{
if has('packages')
  set packpath+=$CFGDIR
endif
let g:python_highlight_all = 1
" }}}

" Autocommands:
" General: {{{
augroup vimrc_general
  autocmd!
  au BufWinLeave ?* if empty(&buftype) | mkview | endif
  au BufWinEnter ?* if empty(&buftype) | silent! loadview | endif

  autocmd WinEnter,FocusGained * checktime

  " Update filetype on save if empty
  autocmd BufWritePost * nested
        \ if &l:filetype ==# '' || exists('b:ftdetect')
        \ |   unlet! b:ftdetect
        \ |   filetype detect
        \ | endif

  " When editing a file, always jump to the last known cursor position, if valid.
  autocmd BufReadPost *
        \ if &ft !~ '^git\c' && ! &diff && line("'\"") > 0 && line("'\"") <= line("$")
        \|   execute 'normal! g`"zvzz'
        \| endif

  " Disable paste and/or update diff when leaving insert mode
  autocmd InsertLeave * if &paste | setlocal nopaste | echo 'nopaste' | endif
  autocmd InsertLeave * if &l:diff | diffupdate | endif

  " TODO: save values
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline

augroup END
" }}}
" Filetype: {{{
augroup vimrc_filetype
  autocmd!
  if has('nvim')
    autocmd FileType help setlocal nu rnu signcolumn=no
  endif
  autocmd FileType qfreplace setlocal nofoldenable
  autocmd BufNewFile,BufRead *.yapf set filetype=cfg
  autocmd Filetype sh let g:is_bash=1
  autocmd Filetype sh let g:sh_fold_enabled=5
augroup END
" }}}
" Numbertoggle: {{{
" -------------
augroup vimrc_numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END
" }}}

" Mappings:
" Simple: {{{
nnoremap K       <nop>
xnoremap K       <nop>
nnoremap <Space> <nop>
xnoremap <Space> <nop>
nnoremap '       <nop>
xnoremap '       <nop>

nnoremap <Up>    <nop>
nnoremap <Down>  <nop>
nnoremap <Left>  <nop>
nnoremap <Right> <nop>

let g:mapleader=' '
let g:maplocalleader="\\"
inoremap jk <ESC>
snoremap jk <ESC>
nnoremap Y y$
nnoremap <CR> za
xnoremap <CR> za
nnoremap <BS> <c-^>
if !exists('g:loaded_tmux_navigator')
  nnoremap <C-h> <C-W>h
  nnoremap <C-j> <C-W>j
  nnoremap <C-k> <C-W>k
  nnoremap <C-l> <C-W>l
endif
nnoremap 0 ^
nnoremap ^ 0
nnoremap <silent> m i_<esc>r
nnoremap gu gU
nnoremap gl gu
xnoremap gu gU
xnoremap gl gu
nnoremap Q q

nnoremap <expr> j (v:count > 4 ? "m'" . v:count . 'j' : 'gj')
nnoremap <expr> k (v:count > 4 ? "m'" . v:count . 'k' : 'gk')

if has('nvim')
  augroup vimrc_term
    autocmd!
    autocmd WinEnter term://* startinsert

    " Currently like this so I can unmap for specific plugins/terminal progs.
    autocmd TermOpen * tnoremap <buffer> <C-h> <C-\><C-n><C-w>h
    autocmd TermOpen * tnoremap <buffer> <C-j> <C-\><C-n><C-w>j
    autocmd TermOpen * tnoremap <buffer> <C-k> <C-\><C-n><C-w>k
    autocmd TermOpen * tnoremap <buffer> <C-l> <C-\><C-n><C-w>l
    autocmd TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>
  augroup END

endif

" Make cmd work as alt in MacVim
if has('mac')
  nnoremap <D-j> <M-j>
  nnoremap <D-k> <M-k>
  vnoremap <D-j> <M-j>
  vnoremap <D-k> <M-k>
endif

cnoreabbrev vh <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert help' : 'vh')<CR>

cnoremap <C-a> <Home>
cnoremap <C-e> <End>

nnoremap <C-q> <C-w>
xnoremap < <gv
xnoremap > >gv|
cmap W!! w !sudo tee % >/dev/null
nnoremap cp yap<S-}>p

nnoremap g= gg=G``zz
nnoremap gQ gggqG``
nnoremap g<CR> i<CR><Esc>

inoremap <C-u> <Esc>hgUiwea
" }}}
" Leader: {{{
nnoremap <leader><CR> :nohlsearch<CR>
nnoremap <leader>cd :lcd %:p:h<CR>:pwd<CR>

nnoremap <expr> <leader><leader> ':nnoremap <buffer> <leader' . '><' . 'leader> '
nnoremap <leader>c<space> :execute 'nunmap <buffer> <leader' . '><' . 'leader>'<CR>:echo '<leader leader> cleared.'<CR>

nnoremap <leader>p "0p
nnoremap <leader>P "0P
xnoremap <leader>p "0p
xnoremap <leader>P "0P

nnoremap <leader>evr :e $MYVIMRC<CR>
nnoremap <leader>evs :e $CFGDIR/settings.vim<CR>
nnoremap <leader>evp :e $CFGDIR/plugins.vim<CR>
nnoremap <leader>rv :so $MYVIMRC<CR>:execute 'set ft='.&ft<CR>:echo 'reloaded vimrc'<CR>zv

nnoremap <silent> <leader>tws :let @/='\v\s+$'<CR>:set hls<CR>

" Select last edited text. improved over `[v`], eg works with visual block
nnoremap <expr> <leader>v '`['.strpart(getregtype(), 0, 1).'`]'
nnoremap <leader>w :write<CR>
nnoremap <silent> <leader>col :syntax sync fromstart<CR>
" }}}
" Filetype: {{{
augroup vimrc_filetype_mappings
  autocmd!
  if exists(':helpclose')
    autocmd FileType help nnoremap <buffer> q :helpclose<CR>
  else
    autocmd FileType help nnoremap <buffer> q :q<CR>
  endif

  nnoremap <silent> <Plug>FirstSuggestionFixSpelling 1z= :call repeat#set("\<Plug>FirstSuggestionFixSpelling")<CR>
  autocmd FileType markdown nnoremap <buffer> <localleader>s <Plug>FirstSuggestionFixSpelling
augroup END  " vimrc_filetype_mappings"
" }}}
" LessSimple: {{{

nnoremap <silent><C-w>b :vert resize<CR>:resize<CR>:normal! ze<CR>

xnoremap s :s//g<Left><Left>
xnoremap gs y:%s/<C-r>"//g<Left><Left>

xnoremap <M-j> :move '>+1<CR>gv=gv
xnoremap <M-k> :move '<-2<CR>gv=gv
nnoremap <M-j> :move .+1<CR>==
nnoremap <M-k> :move .-2<CR>==
inoremap <M-j> <C-c>:move .+1<CR>==gi
inoremap <M-k> <C-c>:move .-2<CR>==gi

" }}}
" Autoload: {{{
nnoremap <silent> <leader>do :call difference#orig()<cr>
nnoremap <silent> <leader>du :call difference#undobuf()<cr>
nnoremap <silent> <Leader>ml :call modeline#append()<CR>

inoremap <silent> ( <C-r>=autopairs#check_and_insert('(')<CR>
inoremap <silent> ) <C-r>=autopairs#check_and_insert(')')<CR>
inoremap <silent> [ <C-r>=autopairs#check_and_insert('[')<CR>
inoremap <silent> ] <C-r>=autopairs#check_and_insert(']')<CR>
inoremap <silent> { <C-r>=autopairs#check_and_insert('{')<CR>
inoremap <silent> } <C-r>=autopairs#check_and_insert('}')<CR>
inoremap <silent> " <C-r>=autopairs#check_and_insert('"')<CR>
inoremap <silent> ' <C-r>=autopairs#check_and_insert("'")<CR>
inoremap <silent> <BS> <C-r>=autopairs#backspace()<CR>

" }}}

" vim: set ts=2 sw=2 tw=99 et :
