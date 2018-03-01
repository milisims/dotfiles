scriptencoding utf-8

call plug#begin($CFGDIR.'/plugged')
" Vim {{{
" loupe {{{
Plug 'wincent/loupe'                     " Prettier searching
" }}}
" vim-surround {{{
Plug 'tpope/vim-surround'                " surrounding text object
" }}}
" vim-unimpaired {{{
Plug 'tpope/vim-unimpaired'              " mapping for common pairs of actions
" }}}
" vim-repeat {{{
Plug 'tpope/vim-repeat'                  " allows more plugin . usage
" }}}
" vim-eunuch {{{
Plug 'tpope/vim-eunuch'                  " vim sugar for unix shell cmds
" }}}
" vim-fugitive {{{
Plug 'tpope/vim-fugitive'                " git wrapper
" }}}
" vim-commentary {{{
Plug 'tpope/vim-commentary'              " easier comments (gc)
xmap gc  <Plug>Commentary
nmap gc  <Plug>Commentary
omap gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
nmap cgc <Plug>ChangeCommentary
nmap gcu <Plug>Commentary<Plug>Commentary
" }}}
" vim-exchange {{{
Plug 'tommcdo/vim-exchange'              " cx exchange 'operator'
" }}}
" syntax-vim-ex {{{
Plug 'vim-jp/syntax-vim-ex'              " Accurate viml syntax
" }}}
" vim-python-pep8-indent {{{
Plug 'Vimjas/vim-python-pep8-indent'     " fix python indentation
" }}}
" python_match.vim {{{
Plug 'vim-scripts/python_match.vim'      " fix python % motion
" }}}
" vim-yass {{{
Plug 'matthsims/vim-yass'                " pretty scrolling
" }}}
" vim-cursorword {{{
Plug 'itchyny/vim-cursorword'            " highlight same word under cursor
" }}}
" vim-highlightedyank {{{
Plug 'machakann/vim-highlightedyank'     " highlights yanked objects
if !exists('##TextYankPost')
	nmap y <Plug>(highlightedyank)
	xmap y <Plug>(highlightedyank)
endif
" }}}
" vim-sneak {{{
Plug 'justinmk/vim-sneak'                " two character movement
nmap f <plug>Sneak_f
nmap F <plug>Sneak_F
xmap f <plug>Sneak_f
xmap F <plug>Sneak_F
omap f <plug>Sneak_f
omap F <plug>Sneak_F

nmap t <plug>Sneak_t
nmap T <plug>Sneak_T
xmap t <plug>Sneak_t
xmap T <plug>Sneak_T
omap t <plug>Sneak_t
omap T <plug>Sneak_T

nmap ; <Plug>Sneak_;
xmap ; <Plug>Sneak_;
nmap , <Plug>Sneak_,
xmap , <Plug>Sneak_,

nmap \ <plug>Sneak_s
nmap <leader>\ <plug>Sneak_S
nmap <leader>s <plug>Sneak_s
nmap <leader>S <plug>Sneak_S

" }}}
" sideways.vim {{{
Plug 'AndrewRadev/sideways.vim'          " function parameter text obj (a)
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

nnoremap <S-Left> :SidewaysLeft<CR>
nnoremap <S-Right> :SidewaysRight<CR>
" }}}
" auto-pairs {{{
Plug 'jiangmiao/auto-pairs'              " autocomplete ()
let g:AutoPairsMapBS = 1
let g:AutoPairsMapCR = 0
let g:AutoPairsShortcutToggle = ''
" }}}
" vim-polyglot {{{
Plug 'sheerun/vim-polyglot'              " vim language pack
let g:polyglot_disabled = ['python']
" }}}
" vim-easy-align {{{
Plug 'junegunn/vim-easy-align'           " align comments, etc
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" }}}
" vim-lucius {{{
Plug 'morhetz/gruvbox'          " Colorscheme
" }}}
" echodoc.vim {{{
Plug 'Shougo/echodoc.vim'                " echo function signature
let g:echodoc#enable_at_startup = 1
" }}}
" vim-gitgutter {{{
Plug 'airblade/vim-gitgutter'           " signs for git changes
let g:gitgutter_max_signs = 1000
" }}}
" pandoc {{{
Plug 'vim-pandoc/vim-pandoc'             " Pandoc helper. to remove.
Plug 'vim-pandoc/vim-pandoc-syntax'
let g:pandoc#folding#fdc = 0
" }}}
" fzf {{{
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

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

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

imap <C-x><C-f> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

" }}}
" parenmatch {{{
if has('patch-7.4.786')
	Plug 'itchyny/vim-parenmatch'          " faster default plugin for matching
endif
" }}}
" }}}
" Neovim {{{
if has('nvim')
	" deoplete.nvim {{{
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'}
	Plug 'Shougo/neco-syntax'
	Plug 'Shougo/neco-vim'
	Plug 'zchee/deoplete-jedi'
	let g:deoplete#enable_at_startup = 1
	let g:deoplete#sources#jedi#show_docstring = 1
	" }}}
	" vim-snippets {{{
	Plug 'matthsims/vim-snippets'
	" }}}
	" ultisnips {{{
	Plug 'SirVer/ultisnips'                  " snippets
	let g:UltiSnipsExpandTrigger            = "<Plug>(ultisnips_expand)"
	let g:UltiSnipsRemoveSelectModeMappings = 0
	" optional
	inoremap <silent> <c-u> <c-r>=cm#sources#ultisnips#trigger_or_popup("\<Plug>(ultisnips_expand)")<cr>
	" }}}
	" denite.nvim {{{
	Plug 'Shougo/denite.nvim'                " Fuzzyfind things
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
	Plug 'Shougo/neomru.vim'                 " most recently used files source
	Plug 'chemzqm/unite-location'            " quickfix and location list source
	" }}}
	" neomake {{{
	Plug 'neomake/neomake'                   " automatic linting
	set signcolumn=yes

	let g:neomake_python_enabled_makers = ['pycodestyle', 'pydocstyle', 'pyflakes']
	" }}}
	" vim-gutentags {{{
	Plug 'ludovicchabant/vim-gutentags'      " automatic ctags generation
	if executable('ctags')
		let g:gutentags_cache_dir = $DATADIR.'/tags'
		let g:gutentags_ctags_executable = $HOME.'/bin/ctags'  " probably unnecessary
	else
		let g:gutentags_enabled = 0
	endif
	" }}}
	" iron.nvim {{{
	Plug 'BurningEther/iron.nvim'            " nvim repl
	let g:iron_map_defaults = 0
	augroup vimrc_iron
		autocmd!
		autocmd Filetype python nmap <buffer> <localleader>t <Plug>(iron-send-motion)
		autocmd Filetype python vmap <buffer> <localleader>t <Plug>(iron-send-motion)
		autocmd Filetype python nmap <buffer> <localleader>l <Plug>(iron-repeat-cmd)
	augroup END
	" }}}
	" thesaurus_query.vim {{{
	Plug 'Ron89/thesaurus_query.vim'
	" }}}
endif
" }}}
call plug#end()


" Post plug#load settings
" Colorscheme {{{
if !empty(globpath(&rtp, 'colors/gruvbox.vim'))
	let g:gruvbox_italic = 1
	let g:gruvbox_number_column = 'bg0'
	set background=dark
	colorscheme gruvbox
endif
" }}}
if has('nvim')
	" denite.nvim {{{
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
	" }}}
	" neomake {{{
		call neomake#configure#automake({
					\ 'TextChanged': {},
					\ 'InsertLeave': {},
					\ 'BufWritePost': {'delay': 0},
					\ 'BufWinEnter': {},
					\ }, 100)
	" }}}
endif
" vim: set ts=2 sw=2 tw=80 noet :
