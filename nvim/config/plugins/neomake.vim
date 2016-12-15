" autocmd InsertChange,TextChanged * update | Neomake
autocmd! BufWritePost * Neomake

" Don't need to edit for now
let g:neomake_python_enabled_makers = ['pep8', 'pylint']
let g:neomake_autolint_sign_column_always = 1

let g:neomake_autolint_enabled = 0
