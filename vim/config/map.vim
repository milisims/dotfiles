
" Global Mappings "{{{
" ---------------
let g:mapleader=' '
let g:maplocalleader=';'
inoremap jk <ESC>

" Release keymappings prefixes, evict entirely for use of plug-ins.
nnoremap <Space>  <Nop>
xnoremap <Space>  <Nop>
nnoremap ,        <Nop>
xnoremap ,        <Nop>
nnoremap ;        <Nop>
xnoremap ;        <Nop>
nnoremap m        <Nop>
xnoremap m        <Nop>

" Fix keybind name for Ctrl+Spacebar
map <Nul> <C-Space>
map! <Nul> <C-Space>

" Disable arrow movement, resize splits instead.
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :bp<CR>
nnoremap <Right> :bn<CR>

" Toggle fold
nnoremap <CR> za

nnoremap <leader>to :e ~/.vimtodo<CR>

" Focus the current fold by closing all others
nnoremap <S-Return> zMza

" Makes up and down work as expected
nnoremap j gj
nnoremap k gk

" Better way to move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Close the current buffer
nnoremap <leader>bd :bd<CR>
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>

" Windows, wk for window kill, wc still works
nnoremap <leader>w <C-w>

"Remap VIM 0
nnoremap 0 ^
nnoremap ^ 0

" Make cmd work as alt
if has("mac")
	nnoremap <D-j> <M-j>
	nnoremap <D-k> <M-k>
	vnoremap <D-j> <M-j>
	vnoremap <D-k> <M-k>
endif

" " Use backspace key for matchit.vim
" nmap <BS> %
" xmap <BS> %
" }}}
" Global niceties {{{
" ---------------

" Start an external command with a single bang
nnoremap ! :!

" Allow misspellings
" Abolish me
cnoreabbrev qw wq
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev Bd bd
cnoreabbrev bD bd
" cnoreabbrev t tabe  " can't search for the letter t ? mapping would be better
" cnoreabbrev T tabe

" Start new line from any cursor position
" inoremap <S-CR> <C-o>o

" Quick substitute within selected area
xnoremap s :s//g<Left><Left>

" Improve scroll, credits: https://github.com/Shougo
nnoremap <expr> zz (winline() == (winheight(0)+1) / 2) ?
	\ 'zt' : (winline() == 1) ? 'zb' : 'zz'
" noremap <expr> <C-f> max([winheight(0) - 2, 1])
" 	\ ."\<C-d>".(line('w$') >= line('$') ? "L" : "M")
" noremap <expr> <C-b> max([winheight(0) - 2, 1])
" 	\ ."\<C-u>".(line('w0') <= 1 ? "H" : "M")
" noremap <expr> <C-e> (line("w$") >= line('$') ? "j" : "2\<C-e>")
" noremap <expr> <C-y> (line("w0") <= 1         ? "k" : "2\<C-y>")

" Window control
nnoremap <C-q> <C-w>
nnoremap <C-x> <C-w>x
nnoremap <silent><C-w>z :vert resize<CR>:resize<CR>:normal! ze<CR>

" Select blocks after indenting
xnoremap < <gv
xnoremap > >gv|

" Use tab for indenting in visual mode
vnoremap <Tab> >gv|
vnoremap <S-Tab> <gv
nnoremap > >>_
nnoremap < <<_

" Select last paste
nnoremap <expr> gp '`['.strpart(getregtype(), 0, 1).'`]'

" Navigation in command line
cnoremap <C-j> <Left>
cnoremap <C-k> <Right>
cnoremap <C-h> <Home>
cnoremap <C-l> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-d> <C-w>

" Switch history search pairs, matching my bash shell
cnoremap <C-p>  <Up>
cnoremap <C-n>  <Down>
cnoremap <Up>   <C-p>
cnoremap <Down> <C-n>

" maybe
cnoremap $h e $HOME/
cnoremap $d <C-\>eCurrentFileDir("e")<CR>
cnoremap $j e ./

nnoremap <leader><CR> :nohlsearch<CR>

" }}}
" File operations {{{
" ---------------

" When pressing <leader>cd switch to the directory of the open buffer
nnoremap <Leader>cd :lcd %:p:h<CR>:pwd<CR>

" " Fast saving
" nnoremap <silent><Leader>w :write<CR>:nohlsearch<CR>
" vnoremap <silent><Leader>w <Esc>:write<CR>:nohlsearch<CR>
" nnoremap <silent><C-s> :<C-u>write<CR>:nohlsearch<CR>
" vnoremap <silent><C-s> :<C-u>write<CR>:nohlsearch<CR>
" cnoremap <silent><C-s> <C-u>write<CR>:nohlsearch<CR>

" Save a file with sudo
" http://forrst.com/posts/Use_w_to_sudo_write_a_file_with_Vim-uAN
cmap W!! w !sudo tee % >/dev/null

" }}}
" Editor UI {{{
" ---------

" Toggle paste mode
set pastetoggle=<F2>
nnoremap cp yap<S-}>p
nnoremap <leader>a =ip

" I like to :quit with 'q', shrug.
nnoremap <silent> q :<C-u>:quit<CR>
nnoremap gQ <Nop>

" Macros
nnoremap Q q
nnoremap M @q
vnoremap M :norm @q<CR>

" Show highlight names under cursor
nmap gh :echo 'hi<'.synIDattr(synID(line('.'), col('.'), 1), 'name')
	\.'> trans<'.synIDattr(synID(line('.'), col('.'), 0), 'name').'> lo<'
	\.synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name').'>'<CR>

" Toggle editor visuals
nmap <silent> <Leader>ts :setlocal spell!<cr>
nmap <silent> <Leader>tn :setlocal nonumber!<CR>
nmap <silent> <Leader>tl :setlocal nolist!<CR>
nmap <silent> <Leader>th :nohlsearch<CR>
nmap <silent> <Leader>tw :setlocal wrap! breakindent!<CR>

" Tabs
nnoremap <silent> g0 :<C-u>tabfirst<CR>
nnoremap <silent> g$ :<C-u>tablast<CR>
nnoremap <silent> gr :<C-u>tabprevious<CR>

" }}}
" Totally Custom {{{
" --------------

" C-r: Easier search and replace
xnoremap <C-r> :<C-u>call <SID>get_selection('/')<CR>:%s/\V<C-R>=@/<CR>//gc<Left><Left><Left>

" Returns visually selected text
function! s:get_selection(cmdtype) "{{{
	let temp = @s
	normal! gv"sy
	let @/ = substitute(escape(@s, '\'.a:cmdtype), '\n', '\\n', 'g')
	let @s = temp
endfunction "}}}

" Location list movement
nmap <Leader>j :lnext<CR>
nmap <Leader>k :lprev<CR>

" " Duplicate lines
" cute, but I want <leader>d for denite commands
" nnoremap <Leader>d m`YP``
" vnoremap <Leader>d YPgv
" vnoremap <Leader>d YPgv

" Source line and selection in vim
" TODO: put in autobuffer for vim files
vnoremap <Leader>S y:execute @@<CR>:echo 'Sourced selection.'<CR>
nnoremap <Leader>S ^vg_y:execute @@<CR>:echo 'Sourced line.'<CR>

" Yank buffer's absolute path to X11 clipboard
nnoremap <Leader>y :let @+=expand("%:p")<CR>:echo 'Copied to clipboard.'<CR>

" Drag current line/s vertically and auto-indent
vnoremap <M-k> :move-2<CR>gv=gv
vnoremap <M-j> :move'>+<CR>gv=gv
noremap  <M-k> :move-2<CR>
noremap  <M-j> :move+<CR>

" Insert a newline from cursor
nnoremap g<CR> i<CR><Esc>

" Last session management shortcuts
nmap <Leader>se :<C-u>SessionSave last<CR>
nmap <Leader>os :<C-u>execute 'source '.g:session_directory.'/last.vim'<CR>

" }}}
" Display diff from last save {{{
command! DiffOrig vert new | setlocal bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" }}}
" Append modeline to EOF {{{
nnoremap <silent> <Leader>ml :call <SID>append_modeline()<CR>

" Append modeline after last line in buffer
" See: http://vim.wikia.com/wiki/Modeline_magic
function! s:append_modeline() "{{{
	let l:modeline = printf(' vim: set ts=%d sw=%d tw=%d %set :',
				\ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
	let l:modeline = substitute(&commentstring, '%s', l:modeline, '')
	call append(line('$'), l:modeline)
endfunction "}}}
" }}}
" s: Windows and buffers {{{

" nnoremap <silent> [Window]v  :<C-u>split<CR>
" nnoremap <silent> [Window]g  :<C-u>vsplit<CR>
" nnoremap <silent> [Window]t  :tabnew<CR>
" nnoremap <silent> [Window]o  :<C-u>only<CR>
" nnoremap <silent> [Window]b  :b#<CR>
" nnoremap <silent> [Window]c  :close<CR>
" nnoremap <silent> [Window]x  :<C-u>call <SID>BufferEmpty()<CR>

" " Split current buffer, go to previous window and previous buffer
" nnoremap <silent> [Window]sv :split<CR>:wincmd p<CR>:e#<CR>
" nnoremap <silent> [Window]sg :vsplit<CR>:wincmd p<CR>:e#<CR>

function! s:BufferEmpty() "{{{
	let l:current = bufnr('%')
	if ! getbufvar(l:current, '&modified')
		enew
		silent! execute 'bdelete '.l:current
	endif
endfunction "}}}
" }}}
"
