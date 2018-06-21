let s:pairs = {'(': ')', '[': ']', '{': '}', '"': '"', "'": "'"}
let s:end_pairs = {')': '(', ']': '[', '}': '{', '"': '"', "'": "'"}
let s:empty = '[ 	)\]}' . "'" . '"' . ']'

augroup vimrc_autopairs
  autocmd!
  autocmd InsertLeave,InsertEnter * let b:ends_inserted = ''
augroup END

function! s:nextchar() abort
  let l:pos = getcurpos()
  let l:line = getbufline(bufname('%'), l:pos[1])[0]
  if l:pos[2] <= strlen(l:line) 
    return l:line[l:pos[2]-1]
  endif
  return ''
endfunction

function! autopairs#backspace() abort
  if b:ends_inserted ==# s:nextchar()
    return "\<BS>\<Del>"
  endif
  return "\<BS>"
endfunction

function! autopairs#check_and_insert(char) abort
  let l:nextchar = s:nextchar()
  echo a:char l:nextchar
  if has_key(s:pairs, a:char) && (empty(l:nextchar) || l:nextchar =~? s:empty)
    let b:ends_inserted = s:pairs[a:char]
    return a:char . s:pairs[a:char] . "\<left>"
  elseif a:char ==# l:nextchar
    return "\<right>"
  endif

  return a:char
endfunction
