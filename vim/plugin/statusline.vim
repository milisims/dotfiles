scriptencoding utf-8
set laststatus=2

function! s:gitinfo() abort
  let l:statuslinetext = ' '
  if exists('g:loaded_fugitive') && &modifiable
    let l:statuslinetext .= '(' . fugitive#head() . ')'
  endif
  return l:statuslinetext !=# ' ()' ? l:statuslinetext : ' '
endfunction

function! s:dirinfo() abort
  let l:statuslinetext = expand('%:h')
  if l:statuslinetext !=# '.'
    let l:statuslinetext .= '/'
  else
    let l:statuslinetext = ''
  endif
  return s:gitinfo() . l:statuslinetext . ' '
endfunction

function! s:fileinfo() abort
  " TODO: modified changes color. choose %#HLname# based on &modified
  let l:statuslinetext = ' %t'
  let l:statuslinetext .= ' %m'
  let l:statuslinetext .= '%='
  let l:statuslinetext .= '%y '
  return l:statuslinetext
endfunction

function! s:typeinfo() abort
  let l:statuslinetext = ' %{&fileencoding?&fileencoding:&encoding}'
  let l:statuslinetext .= '[%{&fileformat}] '
  return l:statuslinetext
endfunction

function! s:bufinfo() abort
  let l:statuslinetext = ' %p%% ☰ '  " U+2630
  let l:statuslinetext .= '%l/%L : %c '
  return l:statuslinetext
endfunction

function! Statusline_active() abort
  let l:statuslinetext  = ' %3.3('.my#statusline#modecolor().my#statusline#mode().'%)'
  let l:statuslinetext .= '%#stlDirInfo#'
  let l:statuslinetext .= s:dirinfo()
  let l:statuslinetext .= '%*'
  let l:statuslinetext .= s:fileinfo()
  let l:statuslinetext .= '%#stlTypeInfo#'
  if exists('b:stl_file_info')
    let l:statuslinetext .= s:typeinfo()
  endif
  let l:statuslinetext .= my#statusline#modecolor()
  let l:statuslinetext .= s:bufinfo()
  let l:statuslinetext .= '%#stlErrorInfo#'
  " let l:statuslinetext .= my#statusline#errors()  " TODO
  return l:statuslinetext
endfunction

function! Statusline_inactive() abort
  let l:statuslinetext  = '%#SignColumn# %*%3.3( %)'
  let l:statuslinetext .= s:gitinfo()
  let l:statuslinetext .= s:fileinfo()
  let l:statuslinetext .= s:typeinfo()
  return l:statuslinetext
endfunction

set statusline=%!Statusline_inactive()
augroup vimrc_statusline
  autocmd!
  autocmd WinEnter,BufEnter * setlocal statusline=%!Statusline_active()
  autocmd WinLeave * setlocal statusline=%!Statusline_inactive()
augroup END
