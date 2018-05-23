set laststatus=2

function! s:fileinfo() abort
  let l:statuslinetext = ' %f'
  let l:statuslinetext .= ' %m'
  let l:statuslinetext .= '%='
  let l:statuslinetext .= '%y '
  return l:statuslinetext
endfunction

function! s:typeinfo() abort
  let l:statuslinetext =' %{&fileencoding?&fileencoding:&encoding}'
  let l:statuslinetext .= '[%{&fileformat}] '
  return l:statuslinetext
endfunction

function! s:bufinfo() abort
  let l:statuslinetext = '  %p%% ☰  '  " U+2630
  let l:statuslinetext .= '%l/%L ln : %c '
  return l:statuslinetext
endfunction

function! Statusline_active() abort
  " TODO: special file information (help, etc)
  " TODO: show the ascii/unicode of current character in stl.
  " set statusline=%<%f%h%m%r%=%b\ 0x%B\ \ %l,%c%V\ %P

  let l:statuslinetext  = ' %11.11('.my#statusline#modecolor().my#statusline#mode().'%)'
  let l:statuslinetext .= '%*'
  let l:statuslinetext .= s:fileinfo()
  let l:statuslinetext .= '%1*'
  let l:statuslinetext .= s:typeinfo()
  let l:statuslinetext .= my#statusline#modecolor()
  let l:statuslinetext .= s:bufinfo()
  let l:statuslinetext .= '%2*'
  " let l:statuslinetext .= my#statusline#errors()  " TODO
  return l:statuslinetext
endfunction

function! Statusline_inactive() abort
  let l:statuslinetext  = '%12.12( %)'
  let l:statuslinetext .= s:fileinfo()
  let l:statuslinetext .= s:typeinfo()
  let l:statuslinetext .= s:bufinfo()
  return l:statuslinetext
endfunction

set statusline=%!Statusline_inactive()
augroup vimrc_statusline
  autocmd!
  autocmd WinEnter,BufEnter * setlocal statusline=%!Statusline_active()
  autocmd WinLeave * setlocal statusline=%!Statusline_inactive()
augroup END
