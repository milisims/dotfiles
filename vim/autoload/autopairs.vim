let s:pairs = {'(': ')', '[': ']', '{': '}', '"': '"', "'": "'"}
let s:end_pairs = {')': '(', ']': '[', '}': '{', '"': '"', "'": "'"}
let s:empty = '[ 	)\]}''"]'

augroup aupairs
  autocmd!
  autocmd InsertCharPre * call s:update_last()
augroup END

function! s:update_last() abort
  if !has_key(s:pairs, v:char) && !has_key(s:end_pairs, v:char)
    let s:last_inserted = v:char
  endif
endfunction

function! s:nextchar() abort
  return strpart(getline('.'), col('.')-1, 1)
endfunction

function! s:prevchar() abort
  return strpart(getline('.'), col('.')-2, 1)
endfunction

function! autopairs#backspace() abort
  let l:prev = s:prevchar()
  if has_key(s:pairs, l:prev) && s:pairs[l:prev] ==# s:nextchar()
    return "\<BS>\<DEL>"
  endif
  return "\<BS>"
endfunction

function! autopairs#check_and_insert(char) abort
  let l:nextchar = s:nextchar()
  if has_key(s:end_pairs, a:char) && a:char ==# l:nextchar && a:char !=# get(s:, 'last_inserted', '')
    return "\<C-g>U\<right>"
  elseif has_key(s:pairs, a:char) && (empty(l:nextchar) || l:nextchar =~? s:empty)
    let s:last_inserted = a:char
    return a:char . s:pairs[a:char] . "\<C-g>U\<left>"
  endif
  return a:char
endfunction

" vim: set ts=2 sw=2 tw=99 et :
