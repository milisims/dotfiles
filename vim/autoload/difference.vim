function! difference#orig() abort
  let l:filetype = &filetype
  vert new
  set buftype=nofile
  set modifiable
  read ++edit # | 0d_
  let &filetype = l:filetype
  set nomodifiable
  nnoremap <buffer> q :diffoff!<CR>:bd<CR>
  diffthis
  set noscrollbind
  wincmd p
  diffthis
  set foldlevel=1
endfunction

function! difference#undobuf() abort
  let l:filetype = &filetype
  let l:undofile = undofile(expand('%:p'))
  let l:text = getline(1, '$')
  vert new
  set buftype=nofile
  set modifiable
  put =l:text | 0d_
  let &filetype = l:filetype
  nnoremap <buffer> q :diffoff!<CR>:bd<CR>
  nnoremap <buffer> u u:diffupdate<CR>
  nnoremap <buffer> <C-r> <C-r>:diffupdate<CR>
  execute 'rundo ' . fnameescape(l:undofile)
  set noscrollbind
  set foldlevel=1
  diffthis | wincmd p | diffthis | wincmd p
  set foldlevel=1
endfunction

" vim: set ts=2 sw=2 tw=99 et :
