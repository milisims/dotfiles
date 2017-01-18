" autocmd InsertChange,TextChanged * update | Neomake
autocmd! BufWritePost * Neomake

" Don't need to edit for now
" NOTE: pep8 is aliased to pycodestyle.
let g:neomake_python_enabled_makers = ['pep8', 'pylint']
let g:neomake_python_pylint_args = ['--disable=W']
let g:neomake_autolint_sign_column_always = 1

let g:neomake_autolint_enabled = 0

" reduce frequency of linting during
let g:neomake_autolint_events = {
  \ 'BufWinEnter': {"delay": 0},
  \ 'TextChanged': {},
  \ 'TextChangedI': {"delay": 3000}
  \ }
