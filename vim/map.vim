" General: {{{
" ---------------
" Release keymappings prefixes, evict entirely for use of plug-ins.
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
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Quick substitute within selected area
xnoremap s :s//g<Left><Left>

" Window control
nnoremap <C-q> <C-w>
nnoremap <silent><C-w>z :vert resize<CR>:resize<CR>:normal! ze<CR>

" Select blocks after indenting
xnoremap < <gv
xnoremap > >gv|

" Select last edited text. improved over `[v`], eg works with visual block
nnoremap <expr> <leader>v '`['.strpart(getregtype(), 0, 1).'`]'

nnoremap <leader><CR> :nohlsearch<CR>
" }}}
" File operations {{{
" ---------------

" When pressing <leader>cd switch to the directory of the open buffer
nnoremap <Leader>cd :lcd %:p:h<CR>:pwd<CR>

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

nnoremap Q q
" }}}
" Custom {{{
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

" Drag current line/s vertically and auto-indent
vnoremap <M-j> :move '>+1<CR>gv=gv
vnoremap <M-k> :move '<-2<CR>gv=gv
noremap  <M-j> :move .+1<CR>==
noremap  <M-k> :move .-2<CR>==

" Insert a newline from cursor
nnoremap g<CR> i<CR><Esc>
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
