setlocal spell
setlocal expandtab
setlocal autoindent
setlocal textwidth=0
setlocal formatoptions=12crqnw
setlocal comments=n:>
setlocal wrap
setlocal breakindent
setlocal breakindentopt=min:50,shift:2
setlocal commentstring=<!--%s-->

let b:ncm2_look_enabled = 1

" wiki stuff:
nnoremap <silent> <buffer> gf :call wiki#follow(0)<CR>
nnoremap <silent> <buffer> yf :call wiki#follow(1)<CR>
nnoremap <silent> <buffer> yc :<C-u>set opfunc=wiki#create_link_opfunc<CR>g@
xnoremap <buffer> yc c[<C-r>"]()<Left>

" vim: set ts=2 sw=2 tw=99 et :
