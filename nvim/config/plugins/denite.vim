nnoremap <C-f> :Denite file_mru file_rec<CR>
nnoremap <C-p> :Denite -mode=normal grep<CR>
nnoremap <C-n> :Denite -mode=normal quickfix location_list<CR>

nnoremap <silent><LocalLeader>r :<C-u>Denite -resume<CR>
nnoremap <silent><LocalLeader>f :<C-u>Denite file_rec<CR>
nnoremap <silent><LocalLeader>b :<C-u>Denite buffer file_old -default-action=switch<CR>
nnoremap <silent><LocalLeader>d :<C-u>Denite directory_rec -default-action=cd<CR>
nnoremap <silent><LocalLeader>l :<C-u>Denite location_list -buffer-name=list<CR>
nnoremap <silent><LocalLeader>q :<C-u>Denite quickfix -buffer-name=list<CR>
nnoremap <silent><LocalLeader>g :<C-u>Denite grep<CR>
nnoremap <silent><LocalLeader>j :<C-u>Denite jump change file_point<CR>
nnoremap <silent><LocalLeader>o :<C-u>Denite outline<CR>
nnoremap <silent><LocalLeader>s :<C-u>Denite session<CR>
nnoremap <silent><LocalLeader>h :<C-u>Denite help<CR>
nnoremap <silent><LocalLeader>m :<C-u>Denite mpc -buffer-name=mpc<CR>
nnoremap <silent><LocalLeader>/ :<C-u>Denite line<CR>
nnoremap <silent><LocalLeader>* :<C-u>DeniteCursorWord line<CR>

" Open Denite with word under cursor or selection
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

" TODO: ripgrep

" Change mappings.
call denite#custom#map(
	\ 'insert',
	\ '<C-j>',
	\ '<denite:move_to_next_line>',
	\ 'noremap'
	\)

call denite#custom#map(
	\ 'insert',
	\ '<C-k>',
	\ '<denite:move_to_previous_line>',
	\ 'noremap'
	\)

call denite#custom#map(
	\ 'insert',
	\ '<C-a>',
	\ '<denite:move_caret_to_head>',
	\ 'noremap'
	\)

call denite#custom#map(
	\ 'normal',
	\ '<C-q>',
	\ '<denite:do_action:quickfix>',
	\ 'noremap'
	\)

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
	\  ['<Esc>', '<denite:enter_mode:normal>', 'noremap'],
	\  ['<C-N>', '<denite:assign_next_matched_text>', 'noremap'],
	\  ['<C-P>', '<denite:assign_previous_matched_text>', 'noremap'],
	\  ['<Up>', '<denite:assign_previous_text>', 'noremap'],
	\  ['<Down>', '<denite:assign_next_text>', 'noremap'],
	\  ['<C-Y>', '<denite:redraw>', 'noremap'],
	\ ]

let normal_mode_mappings = [
	\  ["'", '<denite:toggle_select_down>', 'noremap'],
	\  ['<C-n>', '<denite:jump_to_next_source>', 'noremap'],
	\  ['<C-p>', '<denite:jump_to_previous_source>', 'noremap'],
	\  ['gg', '<denite:move_to_first_line>', 'noremap'],
	\  ['st', '<denite:do_action:tabopen>', 'noremap'],
	\  ['sg', '<denite:do_action:vsplit>', 'noremap'],
	\  ['sv', '<denite:do_action:split>', 'noremap'],
	\  ['sc', '<denite:quit>', 'noremap'],
	\  ['r', '<denite:redraw>', 'noremap'],
	\ ]

for m in insert_mode_mappings
	call denite#custom#map('insert', m[0], m[1], m[2])
endfor
for m in normal_mode_mappings
	call denite#custom#map('normal', m[0], m[1], m[2])
endfor
