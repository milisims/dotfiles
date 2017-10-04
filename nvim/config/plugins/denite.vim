" nnoremap <C-f> :Denite file_mru file_rec<CR>
" nnoremap <C-p> :Denite -mode=normal grep<CR>
" nnoremap <C-n> :Denite -mode=normal quickfix location_list<CR>

nnoremap <silent> <Leader>dr :<C-u>Denite -resume<CR>
nnoremap <silent> <Leader>df :<C-u>Denite file_rec file_mru <CR>
nnoremap <silent> <Leader>db :<C-u>Denite buffer -default-action=switch<CR>
nnoremap <silent> <Leader>dl :<C-u>Denite location_list -mode=normal -buffer-name=list<CR>
nnoremap <silent> <Leader>dq :<C-u>Denite quickfix -mode=normal -buffer-name=list<CR>
nnoremap <silent> <Leader>dg :<C-u>Denite -mode=normal grep<CR>
nnoremap <silent> <Leader>dj :<C-u>Denite jump change file_point<CR>
nnoremap <silent> <Leader>do :<C-u>Denite outline<CR>
nnoremap <silent> <Leader>ds :<C-u>Denite session<CR>
nnoremap <silent> <Leader>dh :<C-u>Denite help<CR>
nnoremap <silent> <Leader>d/ :<C-u>Denite line<CR>
nnoremap <silent> <Leader>d* :<C-u>DeniteCursorWord -mode=normal line<CR>
nnoremap <silent> <Leader>gf :DeniteCursorWord file_rec<CR>
nnoremap <silent> <Leader>gg :DeniteCursorWord grep<CR>
vnoremap <silent> <Leader>gg
	\ :<C-u>call <SID>get_selection('/')<CR>
	\ :execute 'Denite grep:::'.@/<CR><CR>

function! s:get_selection(cmdtype) "{{{
	let temp = @s
	normal! gv"sy
	let @/ = substitute(escape(@s, '\'.a:cmdtype), '\n', '\\n', 'g')
	let @s = temp
endfunction "}}}

" Change default prompt
" call denite#custom#option('default', 'prompt', '>')

" Change ignore_globs
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
	\ [ '.git/', '.ropeproject/', '__pycache__/',
	\   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])


" denite.nvim
" -----------

" INTERFACE
call denite#custom#option('_', {
	\ 'prompt': 'λ:',
	\ 'empty': 0,
	\ 'short_source_names': 1,
	\ 'vertical_preview': 1,
	\ 'auto_highlight': 0,
	\ })

call denite#custom#option('list', {
	\ 'mode': 'normal',
	\ 'winheight': 12,
	\ })

call denite#custom#option('mpc', {
	\ 'quit': 0,
	\ 'mode': 'normal',
	\ 'winheight': 12,
	\ })

" " MATCHERS
" " Default is 'matcher_fuzzy'
" if &runtimepath =~# '\/cpsm'
" 	call denite#custom#source(
" 		\ 'buffer,file_mru,file_old,file_rec,grep,mpc,line',
" 		\ 'matchers', ['matcher_cpsm', 'matcher_fuzzy'])
" endif

" use ag for grep and file_rec
call denite#custom#var(
	\ 'file_rec', 'command',
	\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',
		\ ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" SORTERS
" Default is 'sorter_rank'

" CONVERTERS
" Default is none
call denite#custom#source(
	\ 'buffer,file_mru,file_old',
	\ 'converters', ['converter_relative_word'])

" KEY MAPPINGS
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
