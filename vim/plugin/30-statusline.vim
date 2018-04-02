set laststatus=2

highlight link User2 Pmenu
highlight link User3 IncSearch

highlight link User4 WildMenu
highlight link User5 MatchParen
highlight link User6 PmenuSel
highlight link User7 DiffAdd
highlight link User8 IncSearch
highlight link User9 Constant

function! s:fileinfo() abort
	let l:statuslinetext = ' %f'
	let l:statuslinetext .= ' %m'
	let l:statuslinetext .= '%='
	let l:statuslinetext .= '%y'
	return l:statuslinetext
endfunction

function! s:typeinfo() abort
	let l:statuslinetext =' %{&fileencoding?&fileencoding:&encoding}'
	let l:statuslinetext .= '[%{&fileformat}] '
	return l:statuslinetext
endfunction

function! s:bufinfo() abort
	let l:statuslinetext = '  %p%% ☰  '
	let l:statuslinetext .= '%l/%L ln : %c '
	return l:statuslinetext
endfunction

function! Statusline_active() abort
	" TODO: special file information
	" TODO: show the ascii/unicode of current character in stl.
	" set statusline=%<%f%h%m%r%=%b\ 0x%B\ \ %l,%c%V\ %P

	let l:statuslinetext  = ' '
	let l:statuslinetext .= diy_statusline#modecolor()
	let l:statuslinetext .= diy_statusline#mode()
	let l:statuslinetext .= '%*'
	let l:statuslinetext .= s:fileinfo()
	let l:statuslinetext .= '%1*'  " default background, currently
	let l:statuslinetext .= s:typeinfo()
	let l:statuslinetext .= diy_statusline#modecolor()
	let l:statuslinetext .= s:bufinfo()
	let l:statuslinetext .= '%3*'
	" let l:statuslinetext .= diy_statusline#errors()  " TODO
	return l:statuslinetext
endfunction

function! Statusline_inactive() abort
	let l:statuslinetext  = s:fileinfo()
	let l:statuslinetext .= s:typeinfo()
	let l:statuslinetext .= s:bufinfo()
	return l:statuslinetext
endfunction

set statusline=%!Statusline_inactive()
augroup vimrc_statusline
	autocmd!
	autocmd	WinEnter,VimEnter * setlocal statusline=%!Statusline_active()
	autocmd	WinLeave * setlocal statusline=%!Statusline_inactive()
augroup END
