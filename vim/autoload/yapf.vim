function! yapf#yapfify(start, end) abort
  let l:cursor = getpos('.')
  silent execute '0,$! ' . 'yapf --lines=' . a:start . '-' . a:end
  if v:shell_error  " restore buffer and put error into a new buffer
    let l:error = getline(1, '$')
    silent undo
    silent vertical new
    silent call append(0, l:error)
    " setlocal readonly
    setlocal nomodifiable
    buffer bufnr('$')
  endif
  call setpos('.', l:cursor)
endfunction

" vim: set ts=2 sw=2 tw=99 et :
