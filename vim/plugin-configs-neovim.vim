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

" " LanguageClient: {{{
" " ---------------
" let g:LanguageClient_serverCommands = { 'python' : ['pyls', '-v'] }
" let g:LanguageClient_autoStart = 1
" let g:LanguageClient_diagnosticsEnable = 0  " managed by ale

" nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
" " TODO: :help LanguageClientFunctions
" " }}}

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
