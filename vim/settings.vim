" Settings:
" General: {{{
set mouse=niv                " Disable mouse in command-line mode
set modeline                 " automatically setting options from modelines
set report=0                 " Don't report on line changes
set noerrorbells             " DO NOT Trigger bell on error
set novisualbell             " NO Use visual bell instead of beeping
set hidden                   " hide buffers when abandoned instead of unload
set magic                    " Set vims regex to the same as greps
set path=.,**                " Directories to search when using gf
set virtualedit=block        " Position cursor anywhere in visual block

set synmaxcol=1000           " Don't syntax highlight long lines

set formatoptions=1crl
if has('patch-7.3.541')
  set formatoptions+=j       " Remove comment leader when joining lines
endif

set ttyfast                  " Makes drawing nicer - nvim on by default
set updatetime=500           " update faster (eg, gitgutter plugin)
set winaltkeys=no            " Don't let windows handle the alt key
set pastetoggle=<F2>

if has('vim_starting')
  set encoding=utf-8
  scriptencoding utf-8
endif

set viewoptions=folds,cursor,slash,unix

if has('clipboard')
  set clipboard+=unnamedplus
endif
" }}}
" Backup, Swap, Undo: {{{
if exists('$SUDO_USER')
  set nobackup
  set nowritebackup            " Don't create root owned files
else
  set backupdir=$DATADIR/tmp/backup
  set backupdir+=.
  set backup
endif

if exists('$SUDO_USER')
  set noswapfile               " Don't create root owned files
else
  set directory=$DATADIR/tmp/swap//  " // ensures the name is built from complete path
  set directory+=.
endif

if has("persistent_undo")  " for both nvim and vim
  if exists('$SUDO_USER')
    set noundofile             " Don't create root owned files
  else
    set undodir=$DATADIR/tmp/undo
    set undodir+=.
    set undofile
  endif
endif

set fileformats=unix,dos,mac " Use Unix as the standard file type
" }}}
" History: {{{
set history=10000
if exists('$SUDO_USER')
  if has('nvim')
    set shada=
  else
    set viminfo=
  endif
else
  if has('nvim')
    "  ShaDa/viminfo:
    "   ' - Maximum number of previously edited files marks
    "   < - Maximum number of lines saved for each register
    "   @ - Maximum number of items in the input-line history to be
    "   s - Maximum size of an item contents in KiB
    "   h - Disable the effect of 'hlsearch' when loading the shada
    set shada='300,<10,@50,s100,h
  else
    set viminfo='300,<10,@50,h,n$DATADIR/viminfo
  endif
endif
" }}}
" Tabs and Indents: {{{
set textwidth=80    " Text width maximum chars before wrapping
set noexpandtab     " Don't expand tabs to spaces. Spaces are better, but... eh
set softtabstop=2   " While performing editing operations
set shiftwidth=2    " Number of spaces to use in auto(indent)
set smarttab        " Tab insert blanks according to 'shiftwidth'
set autoindent      " Use same indenting on new lines
set shiftround      " Round indent to multiple of 'shiftwidth'
" }}}
" Timing: {{{
set timeout ttimeout
set timeoutlen=750  " Time out on mappings
set ttimeoutlen=250 " for key codes
" }}}
" Searching: {{{
set ignorecase      " Search ignoring case
set smartcase       " Keep case when searching with *
set infercase       " Adjust case in insert completion mode
set incsearch       " Incremental search
set hlsearch        " Highlight search results
set wrapscan        " Searches wrap around the end of the file
set showmatch       " Jump to matching bracket
set matchpairs+=<:> " Add HTML brackets to pair matching
set matchtime=1     " Tenths of a second to show the matching paren
set cpoptions-=m    " showmatch will wait 0.5s or until a char is typed
" }}}
" Behavior: {{{
set nowrap                      " No wrap by default
set linebreak                   " Break long lines at 'breakat'
set breakat=\ \	;:,!?           " Long lines break chars
set nostartofline               " Cursor in same column for few commands
set whichwrap+=h,l,<,>,[,],~    " Move to following line on certain keys
set splitright " splitbelow     " Splits open bottom right
set switchbuf=useopen,usetab    " Jump to the first open window in any tab
set backspace=indent,eol,start  " Intuitive backspacing in insert mode
set diffopt=filler,iwhite       " Diff mode: show fillers, ignore white
set showfulltag                 " Show tag and tidy search in completion
set complete=.                  " No wins, buffs, tags, include scanning
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
set noshowmode          " Don't show mode in cmd window
set shortmess=aAoOTI     " Shorten messages and don't show intro
set scrolloff=4         " Keep at least 4 lines above/below
set sidescrolloff=2     " Keep at least 2 lines left/right
set number              " Show line numbers
set relativenumber      " Show relative line numbers from cursor
set noruler             " Disable default status ruler
set lazyredraw          " Don't redraw while executing macros

set showtabline=2       " Always show the tabs line
set tabpagemax=15       " Maximum number of tab pages
set winminwidth=12      " Minimum width for inactive windows
set winminheight=0      " Minimum height for inactive windows
set pumheight=20        " Pop-up menu's line height
set helpheight=12       " Minimum help window height
set previewheight=12    " Completion preview height

set showcmd             " Show command in status line
set cmdheight=2         " Height of the command line
set cmdwinheight=5      " Command-line lines
set equalalways         " Resize all windows on split or close
set laststatus=2        " Always show a status line
set colorcolumn=80      " Highlight the 80th character limit
set cursorline
set display=lastline

set list
set listchars=nbsp:⊗
set listchars+=tab:▷‒
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=trail:•
set nojoinspaces

set showbreak=↘
set fillchars=vert:┃

if has('termguicolors')
  set termguicolors
else
  set t_Co=256
endif
colorscheme evolution

" Do not display completion messages
if has('patch-7.4.314')
  set shortmess+=c
endif
" Do not display message when editing files
if has('patch-7.4.1570')
  set shortmess+=F
endif

" For snippet_complete marker
if has('conceal') && v:version >= 703
  set conceallevel=2 concealcursor=
endif
" }}}
" Folds: {{{
if has('folding')
  set foldenable
  set foldmethod=syntax
  set foldlevelstart=99
endif

set foldtext=FoldText()
function! FoldText() abort
  let l:fs = v:foldstart
  while getline(l:fs) !~# '\w'
    let l:fs = nextnonblank(l:fs + 1)
  endwhile
  if l:fs > v:foldend
    let l:line = getline(v:foldstart)
  else
    let l:line = substitute(getline(l:fs), '\t', repeat(' ', &tabstop), 'g')
  endif

  let l:w = winwidth(0) - &foldcolumn - &number * &numberwidth
  let l:foldSize = 1 + v:foldend - v:foldstart
  let l:foldSizeStr = ' ' . l:foldSize . ' lines '
  let l:foldLevelStr = repeat('  +  ', v:foldlevel)
  let l:lineCount = line('$')
  let l:expansionString = repeat(' ', l:w - strwidth(l:foldSizeStr.l:line.l:foldLevelStr))
  return l:line . l:expansionString . l:foldSizeStr . l:foldLevelStr
endfunction

" }}}
" Plugin setup: {{{
if has('packages')
  set packpath+=$CFGDIR
endif
" }}}
" Filetype: {{{
let g:python_highlight_all = 1
" }}}

" Autocommands:
" General: {{{
augroup vimrc_general
  autocmd!
  au BufWinLeave ?* if empty(&buftype) | mkview | endif            " Save fold
  au BufWinEnter ?* if empty(&buftype) | silent! loadview | endif   " load fold

  autocmd WinEnter,FocusGained * checktime

  " Update filetype on save if empty
  autocmd BufWritePost * nested
        \ if &l:filetype ==# '' || exists('b:ftdetect')
        \ |   unlet! b:ftdetect
        \ |   filetype detect
        \ | endif

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  autocmd BufReadPost *
        \ if &ft !~ '^git\c' && ! &diff && line("'\"") > 0 && line("'\"") <= line("$")
        \|   execute 'normal! g`"zvzz'
        \| endif

  " Disable paste and/or update diff when leaving insert mode
  autocmd InsertLeave * if &paste | setlocal nopaste | echo 'nopaste' | endif
  autocmd InsertLeave * if &l:diff | diffupdate | endif

  " TODO: This, smarter. save values
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline

augroup END    " vimrc_general
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
augroup END    " vimrc_filetype
" }}}
" Numbertoggle: {{{
" -------------
augroup vimrc_numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END    " vimrc_numbertoggle
" }}}

" Mappings:
" Simple: {{{
nnoremap K       <nop>
xnoremap K       <nop>
nnoremap <Space> <nop>
xnoremap <Space> <nop>
nnoremap '       <nop>
xnoremap '       <nop>

nnoremap <silent> <Up>    :cprevious<CR>
nnoremap <silent> <Down>  :cnext<CR>
nnoremap <silent> <Left>  :cpfile<CR>
nnoremap <silent> <Right> :cnfile<CR>

let g:mapleader=' '
let g:maplocalleader="'"
inoremap jk <ESC>
snoremap jk <ESC>
nnoremap Y y$
nnoremap <CR> za
xnoremap <CR> za
nnoremap <BS> <c-^>
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap 0 ^
nnoremap ^ 0
nnoremap <silent> m i_<esc>r
nnoremap gU <Nop>
nnoremap gu gU
nnoremap gl gu
xnoremap gu gU
xnoremap gl gu

nnoremap <expr> j (v:count > 8 ? "m'" . v:count : '') . 'gj'
nnoremap <expr> k (v:count > 8 ? "m'" . v:count : '') . 'gk'

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

" Make cmd work as alt
if has('mac')
  nnoremap <D-j> <M-j>
  nnoremap <D-k> <M-k>
  vnoremap <D-j> <M-j>
  vnoremap <D-k> <M-k>
endif

nnoremap ! :!
cnoreabbrev qw wq
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev Bd bd
cnoreabbrev bD bd
cnoreabbrev vh <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert help' : 'vh')<CR>

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
nnoremap Q q

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

nnoremap <leader>p "0p
nnoremap <leader>P "0P
xnoremap <leader>p "0p
xnoremap <leader>P "0P

nnoremap <leader>evr :e $MYVIMRC<CR>
nnoremap <leader>evs :e $CFGDIR/settings.vim<CR>
nnoremap <leader>evp :e $CFGDIR/plugins.vim<CR>
nnoremap <leader>rv :so $MYVIMRC<CR>

nnoremap <leader>tws /\v +$<CR>

nnoremap <leader>do :DiffOrig<CR>

" Select last edited text. improved over `[v`], eg works with visual block
" doesn't work currently?
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

" Make this window big. <C-w>= makes all windows equal.
nnoremap <silent><C-w>b :vert resize<CR>:resize<CR>:normal! ze<CR>

" copy/paste line number -/+[count] below the current line
nnoremap - :<C-u>execute '-'.v:count1.'copy.'<CR>
nnoremap + :<C-u>execute '+'.v:count1.'copy.'<CR>

nnoremap d- :<C-u>execute '-'.v:count1.'delete'<CR><C-o>
nnoremap d+ :<C-u>execute '+'.v:count1.'delete'<CR><C-o>
nnoremap d= :<C-u>execute '+'.v:count1.'delete'<CR><C-o>

nnoremap y- :<C-u>execute '-'.v:count1.'yank '.v:register<CR>
nnoremap y+ :<C-u>execute '+'.v:count1.'yank '.v:register<CR>
nnoremap y= :<C-u>execute '+'.v:count1.'yank '.v:register<CR>

" Quick substitute within selected area
xnoremap s :s//g<Left><Left>
xnoremap gs y:%s/<C-r>"//g<Left><Left>
" TODO: mark a region, select a region of text, hit keybinding, replace only that region.

" Drag current line/s vertically and auto-indent
xnoremap <M-j> :move '>+1<CR>gv=gv
xnoremap <M-k> :move '<-2<CR>gv=gv
nnoremap <M-j> :move .+1<CR>==
nnoremap <M-k> :move .-2<CR>==
inoremap <M-j> <C-c>:move .+1<CR>==gi
inoremap <M-k> <C-c>:move .-2<CR>==gi

" }}}
" Functions: {{{
nnoremap <silent> <Leader>ml :call <SID>append_modeline()<CR>
" Append modeline after last line in buffer
" See: http://vim.wikia.com/wiki/Modeline_magic
function! s:append_modeline()
  let l:modeline = printf(' vim: set ts=%d sw=%d tw=%d %set :',
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, '%s', l:modeline, '')
  call append(line('$'), l:modeline)
endfunction

function! s:difforig() abort
  let l:filetype = &filetype
  vert new
  set buftype=nofile
  set modifiable
  read ++edit # | 0d_
  let &filetype = l:filetype
  set nomodifiable
  nnoremap <buffer> q :diffoff!<CR>:bd<CR>
  diffthis
  set noscrollbind
  wincmd p
  diffthis
  set foldlevel=1
endfunction

command! DiffOrig call s:difforig()
" }}}
