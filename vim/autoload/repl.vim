function! repl#send() abort
  if a:0 == 0
    call s:send_line_or_fold()
  endif
endfunction

function! s:send_line_or_fold() abort
  let l:fold_close = foldclosedend(line('.'))
  if l:fold_close != -1
    call s:send_lines(getline('.', l:fold_close))
  else
    call s:send_lines(getline('.', '.'))
  endif
endfunction

function! s:send_lines(lines) abort
  if g:repl_termid == -1
    throw 'g:repl_termid is default value, term might not be open'
  endif
  for l:line in a:lines
    " TODO: make this an option, trimming stuff
    let l:line = substitute(l:line, '^\s*\(.\{-}\)\s*$', '\1\n', '')
    call jobsend(g:repl_termid, l:line)
  endfor
endfunction

function! repl#opfunc(type) abort
  let [l:lnum_start, l:col_start] = getpos("'[")[1:2]
  let [l:lnum_end, l:col_end] = getpos("']")[1:2]
  let l:lines = getline(l:lnum_start, l:lnum_end)
  call s:send_lines(l:lines)
endfunction

" vim: set ts=2 sw=2 tw=99 et :
