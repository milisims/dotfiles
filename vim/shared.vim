" Settings:{{{
" General: {{{
" --------
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
set formatoptions+=1         " Don't break lines after a one-letter word
set formatoptions-=t         " Don't auto-wrap text
set formatoptions-=o         " Don't insert comment leader after o or O
set ttyfast                  " Makes drawing nicer - nvim on by default
set updatetime=250           " update faster (eg, gitgutter plugin)
set winaltkeys=no            " Don't let windows handle the alt key
set pastetoggle=<F2>
if has('patch-7.3.541')
	set formatoptions+=j       " Remove comment leader when joining lines
endif

if has('vim_starting')
	set encoding=utf-8
	scriptencoding utf-8
endif

" What to save for views:
set viewoptions-=options
set viewoptions+=slash,unix

" What to save in sessions:
set sessionoptions-=blank
set sessionoptions-=options
set sessionoptions-=globals
set sessionoptions-=folds
set sessionoptions-=help
set sessionoptions-=buffers
set sessionoptions+=tabpages

if has('clipboard')
	set clipboard& clipboard+=unnamedplus
endif
" }}}
" Filetype: {{{
set nobackup                 " Auto backup
set nowritebackup            " Backup overwrite
let &directory=$DATADIR.'/swap//'
set fileformats=unix,dos,mac " Use Unix as the standard file type
let g:python_highlight_all = 1
" }}}
" Wildmenu: {{{
" ---------
if has('wildmenu')
	set nowildmenu
	set wildmode=list:longest,full
	set wildoptions=tagfile
	set wildignorecase
	set wildignore+=.git,.hg,.svn,.stversions,*.pyc,*.spl,*.o,*.out,*~,%*
	set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store
	set wildignore+=**/node_modules/**,**/bower_modules/**,*/.sass-cache/*
	set wildignore+=__pycache__,*.egg-info
endif
" }}}
" History and undo saving: {{{
" ------------------------
set history=10000
if has('nvim')
	"  ShaDa/viminfo:
	"   ' - Maximum number of previously edited files marks
	"   < - Maximum number of lines saved for each register
	"   @ - Maximum number of items in the input-line history to be
	"   s - Maximum size of an item contents in KiB
	"   h - Disable the effect of 'hlsearch' when loading the shada
	set shada='300,<10,@50,s100,h
else
	set viminfo='300,<10,@50,h,n$DATADIR/viminfo  " set in  vimrc
endif
if has("persistent_undo")  " for both nvim and vim
	set undodir=$DATADIR/undo
	set undofile
endif
" }}}
" Tabs and Indents: {{{
" -----------------
set textwidth=80    " Text width maximum chars before wrapping
set noexpandtab     " Don't expand tabs to spaces. aucmds for ft specific
set softtabstop=2   " While performing editing operations
set shiftwidth=2    " Number of spaces to use in auto(indent)
set smarttab        " Tab insert blanks according to 'shiftwidth'
set autoindent      " Use same indenting on new lines
set shiftround      " Round indent to multiple of 'shiftwidth'
" }}}
" Timing: {{{
" -------
set timeout ttimeout
set timeoutlen=750  " Time out on mappings
set ttimeoutlen=250 " for key codes
set updatetime=2000 " Idle time to write swap and trigger CursorHold
" }}}
" Searching: {{{
" ----------
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
" ---------
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
" Editor UI Appearance: {{{
" ---------------------
set noshowmode          " Don't show mode in cmd window
set shortmess=aoOTI     " Shorten messages and don't show intro
set scrolloff=4         " Keep at least 4 lines above/below
set sidescrolloff=2     " Keep at least 2 lines left/right
set number              " Show line numbers
set relativenumber      " Show relative line numbers from cursor
set noruler             " Disable default status ruler
set nolist              " Don't show hidden characters in vim by default
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

" Do not display completion messages
if has('patch-7.4.314')	| set shortmess+=c | endif
" Do not display message when editing files
if has('patch-7.4.1570') | set shortmess+=F | endif

" For snippet_complete marker
if has('conceal') && v:version >= 703
	set conceallevel=2 concealcursor=
endif
" }}}
" Folds: {{{
" ------
if has('folding')
	set foldenable
	set foldmethod=syntax
	set foldlevelstart=99
	set foldtext=FoldText()
endif

" Improved Vim fold-text
" See: http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/
function! FoldText()
	" Get first non-blank line
	let fs = v:foldstart
	while getline(fs) =~? '^\s*$' | let fs = nextnonblank(fs + 1)
	endwhile
	if fs > v:foldend
		let line = getline(v:foldstart)
	else
		let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
	endif

	let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
	let foldSize = 1 + v:foldend - v:foldstart
	let foldSizeStr = ' ' . foldSize . ' lines '
	let foldLevelStr = repeat('+--', v:foldlevel)
	let lineCount = line('$')
	let foldPercentage = printf('[%.1f', (foldSize*1.0)/lineCount*100) . '%] '
	let expansionString = repeat('.', w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
	return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endfunction
" }}}
" Disable default plugins: {{{
" ------------------------
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_logiPat = 1
let g:loaded_matchit = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwSettings = 1
let g:loaded_rrhelper = 1
let g:loaded_ruby_provider = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
if has('patch-7.4.786')             " aligns with parenmatch in plugins list
	let g:loaded_matchparen = 1
endif
" }}}
" }}}

" Autocommands: {{{
" General: {{{
augroup vimrc_general
	autocmd!
	au BufWinLeave ?* mkview            " Save fold
	au BufWinEnter ?* silent! loadview   " load fold

	autocmd CursorHold * if &modified | silent! wa | endif
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

augroup END    " vimrc_general
" }}}
" Filetype: {{{
augroup vimrc_filetype
	autocmd!
	if has('nvim')
		autocmd FileType help setlocal nu rnu signcolumn=no
	endif
	if exists(':helpclose')
		autocmd FileType help nnoremap <buffer> q :helpclose<CR>
	else
		autocmd FileType help nnoremap <buffer> q :q<CR>
	endif

	autocmd FileType vim setlocal foldmethod=marker

	autocmd FileType gitcommit setlocal spell
	autocmd FileType gitcommit,qfreplace setlocal nofoldenable

	autocmd FileType python,pyrex setlocal expandtab tabstop=4 shiftwidth=4
	if executable('yapf')
		autocmd FileType python setlocal formatprg=yapf
	endif
	autocmd BufNewFile,BufRead *.yapf set filetype=cfg

	autocmd FileType sh setlocal expandtab tabstop=2 shiftwidth=2
	autocmd FileType markdown setlocal spell expandtab autoindent tw=0
	autocmd FileType markdown setlocal formatoptions=crqn2 comments=n:>
	autocmd FileType markdown setlocal wrap breakindent briopt=min:50,shift:2
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
" DictionaryPopup: {{{
let s:count=0
function! s:PopUpDict() abort
	let AsciiCode=char2nr(v:char)
	if (AsciiCode <=# 122 && AsciiCode >=# 97) || (AsciiCode <=# 90 && AsciiCode >=# 65)
		let s:count+=1
		if s:count >=# 3
			call feedkeys("\<c-x>\<c-k>")
		endif
	else
		let s:count=0
	endif
endfunction

augroup vimrc_dictpopup
	autocmd!
	autocmd InsertCharPre *.{md,txt} call <SID>PopUpDict()
augroup END
" }}}
" }}}

" Mappings: {{{
" Simple: {{{
" Release keymappings
nnoremap <Space>  <Nop>
xnoremap <Space>  <Nop>
nnoremap \|       <Nop>
xnoremap \|       <Nop>
onoremap \|       <Nop>

let g:mapleader=' '
let g:maplocalleader="'"
inoremap jk <ESC>
nnoremap <Up>    <Nop>
nnoremap <Down>  <Nop>
nnoremap <Left>  <Nop>
nnoremap <Right> <Nop>
nnoremap Y y$
nnoremap <CR> za
nnoremap j gj
nnoremap k gk
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap 0 ^
nnoremap ^ 0
nnoremap <silent> m i_<esc>r

" Make cmd work as alt
if has("mac")
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
nnoremap <leader><CR> :nohlsearch<CR>
cmap W!! w !sudo tee % >/dev/null
nnoremap <Leader>cd :lcd %:p:h<CR>:pwd<CR>
nnoremap cp yap<S-}>p
nnoremap <leader>a =ip

" }}}
" LessSimple: {{{

" Make this window big. z= makes all windows equal.
nnoremap <silent><C-w>b :vert resize<CR>:resize<CR>:normal! ze<CR>
" Select last edited text. improved over `[v`], eg works with visual block
nnoremap <expr> <leader>v '`['.strpart(getregtype(), 0, 1).'`]'
" Quick substitute within selected area
xnoremap s :s//g<Left><Left>

" Drag current line/s vertically and auto-indent
vnoremap <M-j> :<C-u>'<,'>move '>+1<CR>gv=gv
vnoremap <M-k> :<C-u>'<,'>move '<-2<CR>gv=gv
nnoremap  <M-j> :<C-u>move .+1<CR>==
nnoremap  <M-k> :<C-u>move .-2<CR>==
inoremap  <M-j> <C-c>:move .+1<CR>==gi
inoremap  <M-k> <C-c>:move .-2<CR>==gi

" Insert a newline from cursor
nnoremap g<CR> i<CR><Esc>

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

" }}}
" }}}
" vim: set ts=2 sw=2 tw=99 noet :
