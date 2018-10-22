function! s:get_file() abort
  let l:link_url_regex = '\%<'.(col('.')+1).'c'.'\[[^]]*\](\zs[^)]\+\ze)'.'\%>'.col('.').'c'
  let l:link = matchstr(getline('.'), l:link_url_regex)
  return l:link
endfunction

function! wiki#follow(force) abort
  " TODO: add search for # to go to a section
  " TODO: open external if non-text file
  let l:link = s:get_file()
  if filereadable(l:link) || a:force == 1
    execute 'edit ' . l:link
  elseif empty(l:link)
    echoerr 'Link not found'
  else
    echoerr 'File ' . l:link . ' does not exist or cannot be read.'
  endif
endfunction

function! wiki#create_link_opfunc(type) abort
  exe "normal! `[v`]c[\<C-r>\"]()"
  startinsert
endfunction

" TODO: rename link
" table of contents generation
" vim: set ts=2 sw=2 tw=99 et :
