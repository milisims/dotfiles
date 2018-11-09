
if has('python3')
  try
    python3 import citebib
  catch
    echoerr 'citebib could not be imported.'
    finish
  endtry
else
  echoerr 'Python3 unsupported for citebib.'
  finish
endif

if exists('g:loaded_citebib')
  finish
endif
let g:loaded_citebib = 1

function! citebib#reset() abort
  let s:bib = {}  " gitdir: {filename: [modtime, [bibitem... bibitem...]], ...}
  let s:bib_cache = {}  " gitdir: [concat bibitems]
  let s:update_cache = {}  " gitdir: 1 or 0
endfunction
call citebib#reset()

function! Doit(index, entry) abort
  return substitute(a:entry, 'ESCCODE', '', 'g')
endfunction

function! s:get_list(fname) abort
  silent execute 'python3 citebib.parse_bibtex("' . a:fname . '")'
  call map(l:return, function('Doit'))
  return l:return
endfunction

function! s:parse(fname) abort
  let s:update_cache[b:git_dir] = 1
  let s:bib[b:git_dir][a:fname] = [getftime(a:fname), s:get_list(a:fname)]
endfunction

function! s:find_bibfiles()
  redir => l:findout
  silent execute "!find -maxdepth 4 -iname '*.bib'"
  redir END
  for l:f in split(l:findout, '\n')
    if filereadable(l:f)
      let l:f = fnamemodify(l:f, ':p')
      if !has_key(s:bib[b:git_dir], l:f)
        let s:bib[b:git_dir][l:f] = [-1, []]
      endif
    endif
  endfor
endfunction

function! s:check_modtimes() abort
  for l:file in keys(s:bib[b:git_dir])
    if getftime(l:file) > s:bib[b:git_dir][l:file][0]
      call s:parse(l:file)
    endif
  endfor
endfunction

function! s:check_cache() abort
  if s:update_cache[b:git_dir]
    let s:bib_cache[b:git_dir] = []
    for l:bib_file in keys(s:bib[b:git_dir])
      call extend(s:bib_cache[b:git_dir], s:bib[b:git_dir][l:bib_file][1])
    endfor
    let s:update_cache[b:git_dir] = 0
  endif
endfunction

function! s:complete_sink(bibentry) abort
  let l:tmp_c = @c
  let @c = split(a:bibentry, ' ')[-1][1:-2]
  execute "normal! i[@\<C-r>c]"
  let @c = l:tmp_c
endfunction

function! s:complete_reducer(bibentry) abort
  let l:ret =[]
  for l:bib in a:bibentry
    let l:id = split(l:bib, ' ')[-1][1:-2]
    call add(l:ret, '[@' . l:id . ']')
  endfor
  return l:ret
endfunction

function! s:run_fzf() abort
      " \ 'reducer': { line -> s:complete_output(line) },
  let l:opts = { 'source': s:bib_cache[b:git_dir],
        \ 'reducer': { lines -> split(lines[0], ' ')[-1][1:-2] },
        \ 'options': ['--ansi', '--multi', '--prompt=Cite> ']
        \ }
  " call fzf#run(fzf#wrap('hello', l:opts))
  return fzf#vim#complete(fzf#wrap('hello', l:opts))
endfunction

function! citebib#fzf() abort
  if !exists('b:git_dir')
    echoerr 'No git dir found.'
    return
  endif
  if !has_key(s:bib, b:git_dir)
    let s:bib[b:git_dir] = {}
  endif
  call s:find_bibfiles()
  call s:check_modtimes()
  call s:check_cache()
  return s:run_fzf()
endfunction
