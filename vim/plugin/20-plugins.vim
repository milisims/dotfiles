scriptencoding utf-8

" Deferring: {{{
" TODO: List of 'files' to call in order
function! s:idledefer() abort
	autocmd! IdleCmd
	doautocmd User VimDeferPack
	if has('nvim')
		silent UpdateRemotePlugins
	endif
	doautocmd User VimDeferCall
	autocmd! User VimDeferPack
	autocmd! User VimDeferCall
endfunction

augroup IdleCmd
	if has('vim_starting')
		autocmd CursorHold,InsertEnter,CmdWinEnter,TextChanged * call s:idledefer()
	endif
augroup END

function! s:defer(file, evalable) abort
	execute 'autocmd User ' . a:file . ' '  . a:evalable
endfunction

command -nargs=1 Dpackadd call s:defer('VimDeferPack', 'packadd ' . <f-args>)
command -nargs=1 Defer call s:defer('VimDeferCall', 'call ' . <f-args>)
" }}}

" packadd vim-defer

" gruvbox {{{
packadd! gruvbox
" }}}
" vim-repeat {{{
packadd vim-repeat
" }}}
" vim-sneak {{{
packadd vim-sneak
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F

nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

nmap ; <Plug>Sneak_;
xmap ; <Plug>Sneak_;
nmap , <Plug>Sneak_,
xmap , <Plug>Sneak_,

nmap \ <Plug>Sneak_s
nmap <leader>\ <Plug>Sneak_S
nmap <leader>s <Plug>Sneak_s
nmap <leader>S <Plug>Sneak_S
" }}}
" vim-cursorword {{{
packadd vim-cursorword
" }}}
" vim-highlightedyank {{{
packadd vim-highlightedyank
if !exists('##TextYankPost')
	nmap y <Plug>(highlightedyank)
	xmap y <Plug>(highlightedyank)
endif
" }}}
" echodoc.vim {{{
packadd echodoc.vim
let g:echodoc#enable_at_startup = 1
" }}}
" fzf.vim {{{
if executable('fzf')
	set rtp+=~/.fzf
	packadd fzf.vim

	nnoremap <silent> <leader>f   :Files<CR>
	nnoremap <silent> <leader>gf  :GFiles<CR>
	nnoremap <silent> <leader>gst :GFiles?<CR>
	nnoremap <silent> <leader>b   :Buffers<CR>
	nnoremap <silent> <leader>l   :Lines<CR>
	nnoremap <silent> <leader>bl  :BLines<CR>
	nnoremap <silent> <leader>O   :Tags<CR>
	nnoremap <silent> <leader>mr  :History<CR>
	nnoremap <silent> <leader>/   :execute 'Ag ' . input('Ag/')<CR>
	nnoremap <silent> <leader>A   :Ag<CR>
	nnoremap <silent> <leader>ht  :Helptags<CR>

	nnoremap <expr> <silent> K ':Ag ' . expand('<cword>') . '<CR>'
	vnoremap <silent> K y:Ag <C-r>"<CR>
	nnoremap <silent> <leader>gl :Commits<CR>
	nnoremap <silent> <leader>gbl :BCommits<CR>

	imap <c-x><c-k> <Plug>(fzf-complete-word)
	imap <c-x><c-f> <Plug>(fzf-complete-path)
	imap <c-x><c-j> <Plug>(fzf-complete-file-ag)
	imap <c-x><c-l> <Plug>(fzf-complete-line)

	imap <C-x><C-f> <Plug>(fzf-complete-file-ag)
	imap <C-x><C-l> <Plug>(fzf-complete-line)

endif
" }}}
" vim-easy-align {{{
packadd! vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" }}}
" loupe {{{
packadd loupe
" }}}

" ft specific
" vim-python-pep8-indent {{{
packadd vim-python-pep8-indent
" }}}
" python_match.vim {{{
packadd python_match.vim
" }}}
" vim-pandoc {{{
packadd vim-pandoc
packadd vim-pandoc-syntax
let g:pandoc#folding#fdc = 0
" }}}


" Deferred:
" vim-surround {{{
Dpackadd vim-surround
" }}}
" vim-unimpaired {{{
Dpackadd vim-unimpaired
" }}}
" vim-eunuch {{{
Dpackadd vim-eunuch
" }}}
" vim-fugitive {{{
Dpackadd vim-fugitive
" }}}
" vim-commentary {{{
Dpackadd vim-commentary
xmap gc  <Plug>Commentary
nmap gc  <Plug>Commentary
omap gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
nmap cgc <Plug>ChangeCommentary
nmap gcu <Plug>Commentary<Plug>Commentary
" }}}
" vim-exchange {{{
Dpackadd vim-exchange
" }}}
" syntax-vim-ex {{{
Dpackadd syntax-vim-ex
" }}}
" vim-yass {{{
Dpackadd vim-yass
" }}}
" vim-gitgutter {{{
Dpackadd vim-gitgutter
Defer gitgutter#all(1)
let g:gitgutter_max_signs = 1000
" }}}

if has('nvim')
	" deoplete {{{
	" NOTE: packadd! works here because we're calling an autoloaded function
	" later. If we need to UpdateRemotePlugins, packadd! won't work.
	packadd! deoplete.nvim
	packadd! neco-syntax
	packadd! neco-vim
	packadd! deoplete-jedi
	let g:deoplete#enable_at_startup = 0
	let g:deoplete#sources#jedi#show_docstring = 1
	call deoplete#enable()
	" }}}
	" ultisnips {{{
	Dpackadd vim-snippets
	Dpackadd ultisnips
	let g:UltiSnipsExpandTrigger            = "<Plug>(ultisnips_expand)"
	let g:UltiSnipsRemoveSelectModeMappings = 0
	" }}}
	" denite.nvim {{{
	packadd! denite.nvim
	packadd! neomru.vim
	packadd! unite-location
	function! s:deniteinit() abort
		" mappings {{{
		nnoremap <C-p> :Denite -mode=normal grep<CR>
		nnoremap <C-n> :Denite -mode=normal quickfix location_list<CR>

		nnoremap <silent> <Leader>dr :<C-u>Denite -resume<CR>
		nnoremap <silent> <Leader>df :<C-u>Denite file_mru file_rec<CR>
		nnoremap <silent> <Leader>db :<C-u>Denite buffer -default-action=switch<CR>
		nnoremap <silent> <Leader>dl :<C-u>Denite location_list -mode=normal<CR>
		nnoremap <silent> <Leader>dq :<C-u>Denite quickfix -mode=normal<CR>
		nnoremap <silent> <Leader>dj :<C-u>Denite jump change<CR>
		nnoremap <silent> <Leader>dg :<C-u>Denite -mode=normal grep<CR>
		nnoremap <silent> <Leader>do :<C-u>Denite outline<CR>
		nnoremap <silent> <Leader>d/ :<C-u>Denite line<CR>
		nnoremap <silent> <Leader>dc :<C-u>Denite -mode=normal references<CR>
		nnoremap <silent> <Leader>d* :<C-u>DeniteCursorWord -mode=normal line<CR>
		nnoremap <silent> <Leader>gf :DeniteCursorWord file_rec<CR>
		nnoremap <silent> <Leader>gg :DeniteCursorWord grep<CR>
		" nnoremap <silent> <Leader>dt :<C-u>Denite
		vnoremap <silent> <Leader>gg
					\ :<C-u>call <SID>get_selection('/')<CR>
					\ :execute 'Denite grep:::'.@/<CR><CR>

		function! s:get_selection(cmdtype)
			let temp = @s
			normal! gv"sy
			let @/ = substitute(escape(@s, '\'.a:cmdtype), '\n', '\\n', 'g')
			let @s = temp
		endfunction
		" }}}
		" Interface {{{
		" ----------
		call denite#custom#option('_', {
					\ 'prompt': 'λ:',
					\ 'empty': 0,
					\ 'auto_highlight': v:true,
					\ 'short_source_names': v:true
					\ })

		call denite#custom#option('_', {
					\ 'highlight_mode_insert': 'CursorLine',
					\ 'highlight_matched_range': 'None',
					\ 'highlight_matched_char': 'None'
					\ })

		call denite#custom#option('list', {
					\ 'mode': 'normal',
					\ 'winheight': 12
					\ })

		call denite#custom#option('mpc', {
					\ 'quit': 0,
					\ 'mode': 'normal',
					\ 'winheight': 12
					\ })
		" }}}
		" Commands {{{
		" ---------
		call denite#custom#var(
					\ 'file_rec', 'command',
					\ ['ag', '--nocolor', '--nogroup', '-g', ''])

		call denite#custom#var('grep', 'command', ['ag'])
		call denite#custom#var('grep', 'default_opts',
					\ ['-i', '--vimgrep'])
		call denite#custom#var('grep', 'recursive_opts', [])
		call denite#custom#var('grep', 'pattern_opt', [])
		call denite#custom#var('grep', 'separator', ['--'])
		call denite#custom#var('grep', 'final_opts', [])

		" Change ignore_globs
		call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
					\ [ '.git/', '.ropeproject/', '__pycache__/',
					\   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

		" CONVERTERS
		" Default is none
		call denite#custom#source(
					\ 'buffer,file_mru,file_old',
					\ 'converters', ['converter_relative_word'])

		" }}}
		" Denite-mode mappings {{{
		" ---------------------
		let insert_mode_mappings = [
					\  ['jk', '<denite:enter_mode:normal>', 'noremap'],
					\  ['<Tab>', '<denite:enter_mode:normal>', 'noremap'],
					\  ['<C-j>', '<denite:move_to_next_line>', 'noremap'],
					\  ['<C-k>', '<denite:move_to_previous_line>', 'noremap'],
					\  ['<C-n>', '<denite:assign_next_matched_text>', 'noremap'],
					\  ['<C-p>', '<denite:assign_previous_matched_text>', 'noremap'],
					\  ['<C-Y>', '<denite:redraw>', 'noremap'],
					\ ]

		let normal_mode_mappings = [
					\  ["'", '<denite:toggle_select_down>', 'noremap'],
					\  ['<C-q>', '<denite:do_action:quickfix>', 'noremap'],
					\  ['<C-n>', '<denite:jump_to_next_source>', 'noremap'],
					\  ['<C-p>', '<denite:jump_to_previous_source>', 'noremap'],
					\  ['gg', '<denite:move_to_first_line>', 'noremap'],
					\  ['t', '<denite:do_action:tabopen>', 'noremap'],
					\  ['v', '<denite:do_action:vsplit>', 'noremap'],
					\  ['s', '<denite:do_action:split>', 'noremap'],
					\  ['r', '<denite:redraw>', 'noremap'],
					\ ]

		for m in insert_mode_mappings
			call denite#custom#map('insert', m[0], m[1], m[2])
		endfor
		for m in normal_mode_mappings
			call denite#custom#map('normal', m[0], m[1], m[2])
		endfor
		" }}}
	endfunction
	Defer s:deniteinit()
	" }}}
	" neomake {{{
	packadd neomake
	set signcolumn=yes

	let g:neomake_python_enabled_makers = ['pycodestyle', 'pydocstyle', 'pyflakes']
	Defer neomake#configure#automake({
				\ 'TextChanged': {},
				\ 'InsertLeave': {},
				\ 'BufWritePost': {'delay': 0},
				\ 'BufWinEnter': {},
				\ }, 100)
	" }}}
	" vim-gutentags {{{
	if executable('ctags')
		Dpackadd vim-gutentags
		let g:gutentags_cache_dir = $DATADIR.'/tags'
		let g:gutentags_ctags_executable = $HOME.'/bin/ctags'  " probably unnecessary
	else
		let g:gutentags_enabled = 0
	endif
	" }}}
	" iron.nvim {{{
	Dpackadd iron.nvim
	let g:iron_map_defaults = 0
	augroup vimrc_iron
		autocmd!
		autocmd Filetype python nmap <buffer> <localleader>t <Plug>(iron-send-motion)
		autocmd Filetype python vmap <buffer> <localleader>t <Plug>(iron-send-motion)
		autocmd Filetype python nmap <buffer> <localleader>l <Plug>(iron-repeat-cmd)
	augroup END
	" }}}
	" thesaurus_query.vim {{{
	Dpackadd thesaurus_query.vim
	" }}}
endif

" Colorscheme {{{
if !empty(globpath(&rtp, 'colors/gruvbox.vim'))
	let g:gruvbox_italic = 1
	let g:gruvbox_number_column = 'bg0'
	set background=dark
	colorscheme gruvbox
endif
" }}}

delcommand Dpackadd
delcommand Defer
" vim: set ts=2 sw=2 tw=80 noet :
