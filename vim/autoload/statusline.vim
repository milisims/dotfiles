scriptencoding utf-8

let s:modes ={
      \ 'n'  : ['%#stlNormal#', '⊳'],
      \ 'i'  : ['%#stlInsert#', 'i'],
      \ 'v'  : ['%#stlVisual#', 'v'],
      \ 'V'  : ['%#stlVisual#', '☴'],
      \ '' : ['%#stlVisual#', '◧'],
      \ 'R'  : ['%#stlReplace#', 'R'],
      \ 's'  : ['%#stlSelect#', 's'],
      \ 'S'  : ['%#stlSelect#', 'S'],
      \ '' : ['%#stlSelect#', 'S'],
      \ 'c'  : ['%#stlTerminal#', '⌘'],
      \ 't'  : ['%#stlTerminal#', '▣'],
      \ '-'  : ['%#stlNormal#', '-']}

function! statusline#modecolor() abort
  return get(s:modes, mode(), '%*')[0]
endfunction

function! statusline#mode() abort
  return ' ' . get(s:modes, mode(), '-')[1] . ' '
endfunction

function! statusline#errors() abort
  " Trailing whitespace
  " quickfix, location-list
  " mixed indentation
  return ''
endfunction

" vim: set ts=2 sw=2 tw=99 et :
