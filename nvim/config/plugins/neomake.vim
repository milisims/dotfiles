autocmd! BufWritePost * Neomake

let g:neomake_open_list = 0
let g:neomake_verbose = 1
let g:airline#extensions#neomake#enabled = 1

let g:neomake_python_enabled_makers = ['pycodestyle', 'pydocstyle', 'pylint']

" TODO: investigate automake!
