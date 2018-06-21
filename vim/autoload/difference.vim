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

" vim: set ts=2 sw=2 tw=99 et :
