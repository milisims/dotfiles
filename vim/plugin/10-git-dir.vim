set noautochdir
let s:gitfail='^fatal: .* .git'
function! s:goto_gitdir() abort
	if exists('b:git_auchdir')
		execute 'cd ' . b:git_auchdir
	endif
	if !executable('git') | return | endif

	let l:filedir = resolve(expand('%:p:h'))
	if empty(l:filedir)
		let l:filedir = resolve(getcwd())
	endif

	let l:gitroot = system('cd ' . expand('%:p:h') . ' && git rev-parse --git-dir')
	let l:gitroot = substitute(l:gitroot, '\%x00', '', '')
	let l:failmatch = matchstr(l:gitroot, s:gitfail)
	if !empty(l:failmatch)
		let b:git_auchdir = getcwd()
		execute 'cd ' . getcwd()
		return
	endif

	let l:gitroot = substitute(l:gitroot, '\C\.git$', '', '')
	if !empty(l:gitroot)
		let b:git_auchdir = l:gitroot
		execute 'cd ' . l:gitroot
	endif
endfunction

augroup vimrc_gitchdir
	autocmd!
	autocmd DirChanged * let b:git_auchdir = getcwd()
	autocmd BufEnter,BufWinEnter * call s:goto_gitdir()
augroup END
