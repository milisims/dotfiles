function! diy_statusline#git_branch() abort
	if ! exists('b:diy_gitdir')
		let b:diy_gitdir = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
	endif
	return b:diy_gitdir
endfunction

let s:modes ={
			\ 'n'  : 'NORMAL',
			\ 'i'  : 'INSERT',
			\ 'R'  : 'REPLACE',
			\ 'v'  : 'VISUAL',
			\ 'V'  : 'V-LINE',
			\ 'c'  : 'COMMAND',
			\ '' : 'V-BLOCK',
			\ 's'  : 'SELECT',
			\ 'S'  : 'S-LINE',
			\ '' : 'S-BLOCK',
			\ 't'  : 'TERMINAL',
			\ '-'  : '--------'}

let s:colorgroups ={
			\ '-'  : '%2*',
			\ 'n'  : '%5*',
			\ 'i'  : '%6*',
			\ 'R'  : '%7*',
			\ 'v'  : '%8*',
			\ 'V'  : '%8*',
			\ 'c'  : '%2*',
			\ '' : '%8*',
			\ 's'  : '%9*',
			\ 'S'  : '%9*',
			\ '' : '%9*',
			\ 't'  : '%4*' }

function! diy_statusline#modecolor() abort
	return get(s:colorgroups, mode(), '%*')
endfunction

function! diy_statusline#mode() abort
	return '  ' . get(s:modes, mode(), '-') . '  '
endfunction

function! diy_statusline#errors() abort
	" Trailing whitespace
	" quickfix, location-list
	" mixed indentation
	return ''
endfunction

