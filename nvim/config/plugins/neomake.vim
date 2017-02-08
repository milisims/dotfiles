autocmd! BufWritePost * Neomake

" NOTE: pep8 is aliased to pycodestyle!
let g:neomake_python_enabled_makers = ['pep8', 'pylint']
" let g:neomake_python_pylint_args = ['--disable=W']

