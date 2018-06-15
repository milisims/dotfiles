scriptencoding utf-8

let s:modes ={
      \ 'n'  : ['%#stlNormal#', '⋄'],
      \ 'i'  : ['%#stlInsert#', 'i'],
      \ 'v'  : ['%#stlVisual#', '␣'],
      \ 'V'  : ['%#stlVisual#', '☴'],
      \ '' : ['%#stlVisual#', '◧'],
      \ 'R'  : ['%#stlReplace#', '⎵'],
      \ 's'  : ['%#stlSelect#', '◻'],
      \ 'S'  : ['%#stlSelect#', '☵'],
      \ '' : ['%#stlSelect#', '⌧'],
      \ 'c'  : ['%#stlTerminal#', '⌘'],
      \ 't'  : ['%#stlTerminal#', '▣'],
      \ '-'  : ['%#stlNormal#', '-']}

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

