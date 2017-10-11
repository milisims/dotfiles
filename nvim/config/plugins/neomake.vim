" let g:neomake_open_list = 0  " will open quickfix
let g:neomake_verbose = 1
let g:airline#extensions#neomake#enabled = 1

let g:neomake_python_enabled_makers = ['pycodestyle', 'pydocstyle', 'pyflakes']

call neomake#configure#automake({
  \ 'TextChanged': {},
  \ 'InsertLeave': {},
  \ 'BufWritePost': {'delay': 0},
  \ 'BufWinEnter': {},
  \ }, 500)

" TODO: investigate automake!
