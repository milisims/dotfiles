
set guifont=Monospace\ 10
if has("mac")
    set guifont=inconsolata:h16
    set linespace=4
elseif has("win32")
    set gfn=Courier_new:h8
endif

set guioptions-=t
set guioptions-=r
set guioptions-=L
set guioptions-=e

" for some reason, vim airline messes up with :gui.
" Restating the colorscheme fixes it.
colorscheme lucius 

