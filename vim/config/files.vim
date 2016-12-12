set nobackup         " Auto backup
set nowritebackup    " Backup overwrite
set noswapfile       " Nerp
set ffs=unix,dos,mac " Default file types

" Delete trailing white space on each line
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWS()

au BufWinLeave ?* mkview            " Save fold
au BufWinEnter ?* silent! loadview   " load fold

" What do these do?
" let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self
