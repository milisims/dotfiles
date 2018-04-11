highlight default link User1 TabLine
highlight default link User2 IncSearch
highlight default link User3 StatusLineTermNC
highlight default link User4 PmenuSel
highlight default link User5 IncSearch
highlight default link User6 WildMenu
highlight default link User7 DiffAdd
highlight default link User8 StatusLineTerm
highlight default link User9 StatusLineTerm

function! my#statusline#git_branch() abort
  if ! exists('b:my#gitdir')
    let b:my#gitdir = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  endif
  return b:my#gitdir
endfunction

let s:modes ={
      \ 'n'  : ['%3*', 'NORMAL'],
      \ 'i'  : ['%4*', 'INSERT'],
      \ 'v'  : ['%5*', 'VISUAL'],
      \ 'V'  : ['%5*', 'V-LINE'],
      \ '' : ['%5*', 'V-BLOCK'],
      \ 'R'  : ['%6*', 'REPLACE'],
      \ 's'  : ['%7*', 'SELECT'],
      \ 'S'  : ['%7*', 'S-LINE'],
      \ '' : ['%7*', 'S-BLOCK'],
      \ 'c'  : ['%8*', 'COMMAND'],
      \ 't'  : ['%9*', 'TERMINAL'],
      \ '-'  : ['%3*', '-------']}

function! my#statusline#modecolor() abort
  return get(s:modes, mode(), '%*')[0]
endfunction

function! my#statusline#mode() abort
  return '  ' . get(s:modes, mode(), '-')[1] . '  '
endfunction

function! my#statusline#errors() abort
  " Trailing whitespace
  " quickfix, location-list
  " mixed indentation
  return ''
endfunction

