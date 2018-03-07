set noautochdir
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
	if v:shell_error > 0
		let b:git_auchdir = getcwd()
		execute 'cd ' . getcwd()
		return
	endif

	let l:gitroot = substitute(l:gitroot, '\%x00', '', '')
	let l:gitroot = substitute(l:gitroot, '\C\.git$', '', '')
	if !empty(l:gitroot)
		let b:git_auchdir = l:gitroot
		execute 'cd ' . l:gitroot
	endif
endfunction

augroup vimrc_gitchdir
	autocmd!
	if exists('##DirChanged')
		autocmd DirChanged * let b:git_auchdir = getcwd()
	endif
	autocmd BufEnter,BufWinEnter * call s:goto_gitdir()
augroup END
