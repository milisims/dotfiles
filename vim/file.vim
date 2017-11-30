set nobackup                 " Auto backup
set nowritebackup            " Backup overwrite
set fileformats=unix,dos,mac " Use Unix as the standard file type

augroup vimrc_general
	autocmd!
	" General: {{{
	au BufWinLeave ?* mkview            " Save fold
	au BufWinEnter ?* silent! loadview   " load fold

	" Check if file changed when its window is focus, more eager than 'autoread'
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
	autocmd InsertLeave *
		\ if &paste | setlocal nopaste mouse=a | echo 'nopaste' | endif |
		\ if &l:diff | diffupdate | endif

	" }}}
	" Filetype: {{{
	autocmd FileType help
		\ setlocal iskeyword+=: | setlocal iskeyword+=# | setlocal iskeyword+=-

	autocmd FileType vim setlocal foldmethod=marker

	autocmd FileType gitcommit setlocal spell
	autocmd FileType gitcommit,qfreplace setlocal nofoldenable

	autocmd FileType python,pyrex setlocal nosmartindent
	autocmd FileType python,pyrex setlocal expandtab tabstop=4
	if executable('yapf')
		autocmd FileType python setlocal formatprg=yapf
	endif
	autocmd BufNewFile,BufRead *.yapf set filetype=cfg

	autocmd FileType sh setlocal expandtab tabstop=2
	autocmd FileType markdown
				\ setlocal spell expandtab autoindent
				\ formatoptions=tcroqn2 comments=n:>
	" }}}
augroup END

let g:python_highlight_all = 1
