autocmd! BufWritePost * Neomake

let g:neomake_open_list = 0
let g:neomake_verbose = 1
let g:airline#extensions#neomake#enabled = 1

" NOTE: pep8 is aliased to pycodestyle!
" let g:neomake_python_enabled_makers = ['pep8', 'pylint']
let g:neomake_python_enabled_makers = ['pycodestyle', 'pylint']
" let g:neomake_python_pylint_args = ['--disable=W']

