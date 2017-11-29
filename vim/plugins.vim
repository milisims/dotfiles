call plug#begin('~/.config/vim/plugged')
" Vim: {{{
if exists(':Plug')

	Plug 'tpope/vim-surround'                " surrounding text object
	Plug 'tpope/vim-commentary'              " easier comments (gc)
	Plug 'tpope/vim-unimpaired'              " mapping for common pairs of actions
	Plug 'tpope/vim-repeat'                  " allows more plugin . usage
	Plug 'tpope/vim-eunuch'                  " vim sugar for unix shell cmds
	Plug 'justinmk/vim-sneak'                " move around more easily!
	Plug 'jiangmiao/auto-pairs'              " autocomplete ()s, etc
	Plug 'sheerun/vim-polyglot'              " vim language pack
	Plug 'raimon49/requirements.txt.vim'
	Plug 'junegunn/vim-easy-align'           " align comments, etc
	Plug 'AndrewRadev/sideways.vim'          " function parameter text obj (a)
	Plug 'AndrewRadev/splitjoin.vim'         " gJ, gS to split or join statements
	Plug 'mbbill/undotree'                   " provides undotree visualization

	Plug 'bling/vim-airline'                 " pretty statusbars
	Plug 'jonathanfilip/vim-lucius'					 " Colorscheme
	Plug 'itchyny/vim-cursorword'            " highlight same word under cursor

	Plug 'vim-jp/syntax-vim-ex'
	Plug 'Vimjas/vim-python-pep8-indent'
	Plug 'vim-scripts/python_match.vim'
	Plug 'andreshazard/vim-logreview'

	if has('patch-7.4.786')
		Plug 'itchyny/vim-parenmatch'          " faster default plugin for matching
	endif

endif
" }}}
" Neovim: {{{
if exists(':Plug') && has('nvim')

	Plug 'Shougo/denite.nvim'            " makes a nice buffer to search through
	Plug 'Shougo/neomru.vim'             " most recently used files source
	Plug 'chemzqm/unite-location'        " quickfix and location list source
	Plug 'SirVer/ultisnips'              " snippets!
	Plug 'matthsims/vim-snippets'
	Plug 'roxma/nvim-completion-manager', { 'do': ':UpdateRemotePlugins' }
	Plug 'neomake/neomake'
	Plug '5long/pytest-vim-compiler'
	Plug 'airblade/vim-gitgutter'        " signs for git changes
	Plug 'ludovicchabant/vim-gutentags'  " automatic ctags generation
	Plug 'junegunn/fzf.vim'
	Plug 'vimwiki/vimwiki'               " self management
	Plug 'machakann/vim-highlightedyank'

endif
" }}}
call plug#end()

" airline {{{
let g:airline#extensions#tabline#enabled = 1
" let g:airline_left_sep='|'
" let g:airline_right_sep = '|'
" }}}
" auto-pairs {{{
let g:AutoPairsMapBS = 1
let g:AutoPairsMapCR = 0
let g:AutoPairsShortcutToggle = ''
" }}}
" colorscheme {{{
if !empty(globpath(&rtp, 'colors/lucius.vim'))
	colorscheme lucius
	LuciusDark
endif
" }}}
" commentary {{{
xmap gc  <Plug>Commentary
nmap gc  <Plug>Commentary
omap gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
nmap cgc <Plug>ChangeCommentary
nmap gcu <Plug>Commentary<Plug>Commentary
" }}}
" easy-align {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}
" hardtime {{{
let g:hardtime_default_on = 1
let g:hardtime_timeout = 200
let g:hardtime_allow_different_key = 1
let g:hardtime_maxcount = 2

let g:list_of_normal_keys = ["h", "j", "k", "l"]
let g:list_of_visual_keys = ["h", "j", "k", "l"]
" }}}
" polyglot {{{
let g:polyglot_disabled = ['python', 'vim']
" }}}
" sideways {{{
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

nnoremap <S-Left> :SidewaysLeft<CR>
nnoremap <S-Right> :SidewaysRight<CR>
" }}}
" sneak {{{
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
" }}}
" undotree {{{
let g:undotree_WindowLayout = 3
let g:undotree_ShortIndicators = 1

nnoremap <F5> :UndotreeToggle<cr>
" }}}

if has('nvim')
" denite: {{{
" -------
" Keybinds: {{{
" ---------
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

function! s:get_selection(cmdtype) "{{{
	let temp = @s
	normal! gv"sy
	let @/ = substitute(escape(@s, '\'.a:cmdtype), '\n', '\\n', 'g')
	let @s = temp
endfunction "}}}

" }}}
" Interface: {{{
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
" Commands: {{{
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
" Denite-mode mappings: {{{
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
" echodoc: {{{
" --------
let g:echodoc#enable_at_startup = 1
" }}}
" gitgutter {{{
let g:gitgutter_max_signs = 1000
" }}}
" gutentags: {{{
" ----------
let g:gutentags_cache_dir = $VARPATH.'/tags'
let g:gutentags_ctags_executable = $HOME.'/bin/ctags'
" }}}
" nvim-completion-manager: {{{
imap <expr> <CR>  (pumvisible() ?  "\<c-y>\<Plug>(expand)" : "\<CR>")
" imap <expr> <Plug>(expand) (cm#completed_is_snippet() ? "\<c-y>\<C-U>" : "")
imap <expr> <Plug>(expand) (cm#completed_is_snippet() ? "\<Plug>(ultisnips_expand)" : "")

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" }}}
" Vimwiki: {{{
augroup vimrc_vimwiki
	autocmd!
	autocmd FileType vimwiki setlocal expandtab
augroup END
" }}}
" Ultisnips: {{{
let g:UltiSnipsExpandTrigger            = "<Plug>(ultisnips_expand)"
let g:UltiSnipsRemoveSelectModeMappings = 0
" optional
inoremap <silent> <c-u> <c-r>=cm#sources#ultisnips#trigger_or_popup("\<Plug>(ultisnips_expand)")<cr>
" }}}
" Neomake: {{{
set signcolumn=yes
let g:neomake_verbose = 1
let g:airline#extensions#neomake#enabled = 1

let g:neomake_python_enabled_makers = ['pycodestyle', 'pydocstyle', 'pyflakes']

call neomake#configure#automake({
	\ 'TextChanged': {},
	\ 'InsertLeave': {},
	\ 'BufWritePost': {'delay': 0},
	\ 'BufWinEnter': {},
	\ }, 100)
" }}}
endif
