scriptencoding utf-8

highlight default link User1 TabLine
highlight default link User2 IncSearch
highlight default link User3 StatusLineTermNC
highlight default link User4 PmenuSel
highlight default link User5 IncSearch
highlight default link User6 WildMenu
highlight default link User7 DiffAdd
highlight default link User8 StatusLineTerm
highlight default link User9 StatusLineTerm

let s:modes ={
      \ 'n'  : ['%3*', '⋄'],
      \ 'i'  : ['%4*', 'i'],
      \ 'v'  : ['%5*', '␣'],
      \ 'V'  : ['%5*', '☴'],
      \ '' : ['%5*', '◧'],
      \ 'R'  : ['%6*', '⎵'],
      \ 's'  : ['%7*', '◻'],
      \ 'S'  : ['%7*', '☵'],
      \ '' : ['%7*', '⌧'],
      \ 'c'  : ['%8*', '⌘'],
      \ 't'  : ['%8*', '▣'],
      \ '-'  : ['%3*', '-']}

function! my#statusline#modecolor() abort
  return get(s:modes, mode(), '%*')[0]
endfunction

function! my#statusline#mode() abort
  return ' ' . get(s:modes, mode(), '-')[1] . ' '
endfunction

function! my#statusline#errors() abort
  " Trailing whitespace
  " quickfix, location-list
  " mixed indentation
  return ''
endfunction

