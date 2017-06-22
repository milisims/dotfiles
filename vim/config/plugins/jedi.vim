let g:jedi#force_py_version = 3

let g:jedi#auto_initialization = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#use_splits_not_buffers = 'right'


" augroup MyAutoCmd
" 	au FileType python nnoremap <buffer><localleader>d :call jedi#goto()<CR>
" 	au FileType python nnoremap <buffer><silent><localleader>r :call jedi#rename()<CR>
" 	au FileType python nnoremap <buffer><silent>K :call jedi#show_documentation()<CR>
" 	" au FileType rst nnoremap <buffer><silent>q :bd<CR>
" 	au FileType rst nnoremap <buffer>q :bd<CR>
" augroup END

