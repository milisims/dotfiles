" 'evolution.vim' -- Vim color scheme.
" Author:       Matt Simmons (mtszyk@gmail.com)
" Description:  Colors modified from nord:
"               https://github.com/arcticicestudio/nord
" Last Change:  2018-06-15

hi clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'evolution'

" highlight function and commmand {{{

" This function is just to allow fg=DICT for cterm and gui.
" I think it helps make the colorscheme more readable and easily edited.
" These work:
" Highlight Normal    bg=s:bg_0    fg=s:fg_1    attr=NONE
" Highlight Normal    ctermbg=s:bg_0[0]  guitermbg=s:bg_0[1]   fg=s:fg_1

function! s:hi(group, ...) abort
  let l:cmd = 'highlight ' . a:group
  for l:arg in a:000
    let l:term = split(l:arg, '=')
    let l:key = l:term[0]
    " If the key is fg or bg, map both cterm and gui colors
    if l:key ==# 'fg' || l:key ==# 'bg'
      if len(split(l:term[1], ':')) == 2
        execute 'let l:tcolor = ' . l:term[1] . '[0]'
        execute 'let l:gcolor = ' . l:term[1] . '[1]'
      else
        let l:tcolor = l:term[1]
        let l:gcolor = l:term[1]
      endif
      let l:cmd .= ' cterm' . l:key . '=' . l:tcolor
      let l:cmd .= ' gui' . l:key . '=' . l:gcolor
    elseif l:key ==# 'attr'
      if len(split(l:term[1], ':')) == 2
        execute 'let l:attr = ' . l:term[1]
      else
        let l:attr = l:term[1]
      endif
      let l:cmd .= ' cterm=' . l:attr . ' gui=' . l:attr
    else
      " otherwise, check if still needs to be evaluated
      if len(split(l:term[1], ':')) == 2
        execute 'let l:value = ' . l:term[1]
      else
        let l:value = l:term[1]
      endif
      let l:cmd .= ' ' . l:key . '=' . l:value
    endif
  endfor
  execute l:cmd
endfunction

command! -nargs=+ -complete=highlight Highlight call s:hi(<f-args>)

" }}}
" color definitions {{{
let s:dark0  = [236, '#2a303b']
let s:dark1  = [237, '#2f3642']
let s:dark2  = [238, '#373e4d']
let s:dark3  = [239, '#3c4554']

let s:light0 = [250, '#bac0cc']
let s:light1 = [146, '#abbdd6']
let s:light2 = [244, '#728096']
let s:light3 = [60 , '#64718c']

let s:aqua   = [109, '#8fbcbb']
let s:laqua  = [110, '#88c0d0']
let s:lblue  = [109, '#81a1c1']
let s:blue   = [67 , '#5e81ac']

let s:red    = [131, '#bf616a']
let s:orange = [173, '#d08770']
let s:yellow = [222, '#ebcb8b']
let s:green  = [144, '#a3be8c']
let s:violet = [139, '#b48ead']
" }}}
" True and 256 colors {{{
if ($TERM =~# '256' || &t_Co >= 256) || has('gui_running')

  Highlight Normal           fg=s:light0 bg=s:dark0  attr=NONE
  set background=dark

  Highlight LineNr           fg=s:dark3  bg=s:dark0  attr=NONE
  Highlight SignColumn       fg=s:dark1  bg=s:dark0  attr=NONE
  Highlight FoldColumn       fg=s:dark3  bg=s:dark0  attr=NONE
  Highlight MatchParen       fg=s:laqua  bg=s:dark3  attr=NONE

  Highlight Folded           fg=s:light2 bg=s:dark1  attr=bold
  Highlight Comment          fg=s:light3 bg=NONE     attr=italic
  Highlight Identifier       fg=s:light0 bg=NONE     attr=NONE
  Highlight Statement        fg=s:lblue  bg=NONE     attr=bold
  Highlight PreProc          fg=s:lblue  bg=NONE     attr=NONE
  Highlight Type             fg=s:lblue  bg=NONE     attr=NONE
  Highlight Special          fg=s:light0 bg=NONE     attr=NONE
  Highlight Function         fg=s:laqua  bg=NONE     attr=NONE
  Highlight String           fg=s:green  bg=NONE     attr=NONE
  Highlight Constant         fg=s:light0 bg=NONE     attr=NONE
  Highlight Error            fg=s:dark0  bg=s:red    attr=bold
  Highlight Todo             fg=s:yellow bg=NONE     attr=bold
  Highlight NonText          fg=s:dark2  bg=NONE     attr=NONE

  Highlight WildMenu         fg=s:laqua  bg=s:dark3  attr=NONE
  Highlight PMenu            fg=s:light0 bg=s:dark1  attr=NONE
  Highlight PmenuSbar        fg=s:light0 bg=s:dark1  attr=NONE
  Highlight PMenuSel         fg=s:laqua  bg=s:dark2  attr=NONE
  Highlight PmenuThumb       fg=s:light2 bg=s:dark2  attr=NONE

  Highlight ErrorMsg         fg=s:light0 bg=s:red    attr=NONE
  Highlight ModeMsg          fg=s:light0 bg=NONE     attr=NONE
  Highlight MoreMsg          fg=s:light0 bg=NONE     attr=NONE
  Highlight Question         fg=s:light0 bg=NONE     attr=NONE
  Highlight WarningMsg       fg=s:red    bg=s:dark0  attr=NONE
  Highlight TabLine          fg=s:light3 bg=s:dark1  attr=NONE
  Highlight TabLineFill      fg=s:light3 bg=s:dark1  attr=NONE
  Highlight TabLineSel       fg=s:light3 bg=s:dark3  attr=NONE
  Highlight Cursor           fg=s:dark0  bg=s:light0 attr=NONE
  Highlight CursorColumn     fg=NONE     bg=s:dark1  attr=NONE
  Highlight CursorLineNr     fg=s:aqua   bg=s:dark0  attr=NONE
  Highlight CursorLine       fg=NONE     bg=s:dark1  attr=NONE
  Highlight ColorColumn      fg=NONE     bg=s:dark1  attr=NONE
  Highlight StatusLine       fg=s:light1 bg=s:dark1  attr=NONE
  Highlight StatusLineNC     fg=s:light3 bg=s:dark2  attr=NONE
  Highlight StatusLineTerm   fg=s:laqua  bg=s:dark2  attr=NONE
  Highlight StatusLineTermNC fg=s:light0 bg=s:dark1  attr=NONE

  Highlight Visual           fg=NONE     bg=s:dark2  attr=NONE
  Highlight VisualNOS        fg=NONE     bg=s:dark2  attr=NONE
  Highlight VertSplit        fg=s:dark2  bg=s:dark0  attr=NONE
  Highlight SpecialKey       fg=s:dark3  bg=NONE     attr=NONE
  Highlight Title            fg=s:light0 bg=NONE     attr=NONE
  Highlight DiffAdd          fg=s:green  bg=s:dark1  attr=reverse
  Highlight DiffChange       fg=s:yellow bg=s:dark1  attr=reverse
  Highlight DiffDelete       fg=s:red    bg=s:dark1  attr=reverse
  Highlight DiffText         fg=s:lblue  bg=s:dark1  attr=reverse
  Highlight IncSearch        fg=s:dark1  bg=s:laqua  attr=NONE
  Highlight Search           fg=s:dark1  bg=s:laqua  attr=NONE
  Highlight Directory        fg=s:laqua  bg=NONE     attr=NONE
  Highlight SpecialChar      fg=s:yellow bg=NONE     attr=NONE
  Highlight SpecialComment   fg=s:laqua  bg=NONE     attr=italic
  Highlight Number           fg=s:violet bg=NONE     attr=NONE

  Highlight stlTypeInfo      fg=s:blue   bg=s:dark0  attr=NONE
  Highlight stlErrorInfo     fg=s:dark0  bg=s:orange attr=bold
  Highlight stlDirInfo       fg=s:aqua   bg=s:dark2  attr=NONE

  Highlight stlNormal        fg=s:yellow bg=s:dark3  attr=bold
  Highlight stlInsert        fg=s:dark0  bg=s:green  attr=bold
  Highlight stlVisual        fg=s:dark0  bg=s:orange attr=NONE
  Highlight stlReplace       fg=s:dark0  bg=s:blue   attr=NONE
  Highlight stlSelect        fg=s:dark0  bg=s:blue   attr=NONE
  Highlight stlTerminal      fg=s:violet bg=s:dark3  attr=NONE

  Highlight debugPC          bg=s:blue
  Highlight debugBreakpoint  bg=s:red

  if has('gui_running')
    Highlight SpellBad   ctermbg=NONE ctermfg=s:red[0]  guibg=NONE guifg=NONE      cterm=undercurl gui=undercurl guisp=s:red[1]
    Highlight SpellCap   ctermbg=NONE ctermfg=s:aqua[0] guibg=NONE guifg=NONE      cterm=undercurl gui=undercurl guisp=s:aqua[1]
    Highlight SpellLocal ctermbg=NONE ctermfg=s:green[0]  guibg=NONE guifg=NONE      cterm=undercurl gui=undercurl guisp=s:green[1]
    Highlight SpellRare  ctermbg=NONE ctermfg=s:orange[0]  guibg=NONE guifg=NONE      cterm=undercurl gui=undercurl guisp=s:orange[1]
  else
    Highlight SpellBad   ctermbg=NONE ctermfg=s:red[0]  guibg=NONE guifg=s:red[1]  cterm=undercurl gui=undercurl guisp=NONE
    Highlight SpellCap   ctermbg=NONE ctermfg=s:aqua[0] guibg=NONE guifg=s:aqua[1] cterm=undercurl gui=undercurl guisp=NONE
    Highlight SpellLocal ctermbg=NONE ctermfg=s:green[0]  guibg=NONE guifg=s:green[1]  cterm=undercurl gui=undercurl guisp=NONE
    Highlight SpellRare  ctermbg=NONE ctermfg=s:orange[0]  guibg=NONE guifg=s:orange[1]  cterm=undercurl gui=undercurl guisp=NONE
  endif

  " }}}
" term colors {{{
elseif &t_Co == 8 || $TERM !~# '^linux' || &t_Co == 16
  set t_Co=16

  highlight Normal           ctermbg=NONE       ctermfg=white       cterm=NONE
  set       background=dark

  highlight Comment          ctermbg=NONE       ctermfg=gray        cterm=NONE
  highlight Conceal          ctermbg=NONE       ctermfg=white       cterm=NONE
  highlight Constant         ctermbg=NONE       ctermfg=red         cterm=NONE
  highlight Function         ctermbg=NONE       ctermfg=yellow      cterm=NONE
  highlight Identifier       ctermbg=NONE       ctermfg=darkblue    cterm=NONE
  highlight PreProc          ctermbg=NONE       ctermfg=darkcyan    cterm=NONE
  highlight Special          ctermbg=NONE       ctermfg=darkgreen   cterm=NONE
  highlight Statement        ctermbg=NONE       ctermfg=blue        cterm=NONE
  highlight String           ctermbg=NONE       ctermfg=green       cterm=NONE
  highlight Todo             ctermbg=NONE       ctermfg=NONE        cterm=reverse
  highlight Type             ctermbg=NONE       ctermfg=magenta     cterm=NONE

  highlight Error            ctermbg=NONE       ctermfg=darkred     cterm=reverse
  highlight Ignore           ctermbg=NONE       ctermfg=NONE        cterm=NONE
  highlight Underlined       ctermbg=NONE       ctermfg=NONE        cterm=reverse

  highlight LineNr           ctermbg=black      ctermfg=gray        cterm=NONE
  highlight NonText          ctermbg=NONE       ctermfg=darkgray    cterm=NONE

  highlight Pmenu            ctermbg=darkgray   ctermfg=white       cterm=NONE
  highlight PmenuSbar        ctermbg=gray       ctermfg=NONE        cterm=NONE
  highlight PmenuSel         ctermbg=darkcyan   ctermfg=black       cterm=NONE
  highlight PmenuThumb       ctermbg=darkcyan   ctermfg=NONE        cterm=NONE

  highlight ErrorMsg         ctermbg=darkred    ctermfg=black       cterm=NONE
  highlight ModeMsg          ctermbg=darkgreen  ctermfg=black       cterm=NONE
  highlight MoreMsg          ctermbg=NONE       ctermfg=darkcyan    cterm=NONE
  highlight Question         ctermbg=NONE       ctermfg=green       cterm=NONE
  highlight WarningMsg       ctermbg=NONE       ctermfg=darkred     cterm=NONE

  highlight TabLine          ctermbg=darkgray   ctermfg=darkyellow  cterm=NONE
  highlight TabLineFill      ctermbg=darkgray   ctermfg=black       cterm=NONE
  highlight TabLineSel       ctermbg=darkyellow ctermfg=black       cterm=NONE

  highlight Cursor           ctermbg=NONE       ctermfg=NONE        cterm=NONE
  highlight CursorColumn     ctermbg=darkgray   ctermfg=NONE        cterm=NONE
  highlight CursorLineNr     ctermbg=black      ctermfg=cyan        cterm=NONE
  highlight CursorLine       ctermbg=darkgray   ctermfg=NONE        cterm=NONE

  highlight helpLeadBlank    ctermbg=NONE       ctermfg=NONE        cterm=NONE
  highlight helpNormal       ctermbg=NONE       ctermfg=NONE        cterm=NONE

  highlight StatusLine       ctermbg=darkyellow ctermfg=black       cterm=NONE
  highlight StatusLineNC     ctermbg=darkgray   ctermfg=darkyellow  cterm=NONE

  highlight StatusLineterm   ctermbg=darkyellow ctermfg=black       cterm=NONE
  highlight StatusLinetermNC ctermbg=darkgray   ctermfg=darkyellow  cterm=NONE

  highlight Visual           ctermbg=black      ctermfg=blue        cterm=reverse
  highlight VisualNOS        ctermbg=black      ctermfg=white       cterm=reverse

  highlight FoldColumn       ctermbg=black      ctermfg=darkgray    cterm=NONE
  highlight Folded           ctermbg=black      ctermfg=darkgray    cterm=NONE

  highlight VertSplit        ctermbg=darkgray   ctermfg=darkgray    cterm=NONE
  highlight WildMenu         ctermbg=blue       ctermfg=black       cterm=NONE

  highlight SpecialKey       ctermbg=NONE       ctermfg=darkgray    cterm=NONE
  highlight Title            ctermbg=NONE       ctermfg=white       cterm=NONE

  highlight DiffAdd          ctermbg=black      ctermfg=green       cterm=reverse
  highlight DiffChange       ctermbg=black      ctermfg=magenta     cterm=reverse
  highlight DiffDelete       ctermbg=black      ctermfg=darkred     cterm=reverse
  highlight DiffText         ctermbg=black      ctermfg=red         cterm=reverse

  highlight IncSearch        ctermbg=darkred    ctermfg=black       cterm=NONE
  highlight Search           ctermbg=yellow     ctermfg=black       cterm=NONE

  highlight Directory        ctermbg=NONE       ctermfg=cyan        cterm=NONE
  highlight MatchParen       ctermbg=black      ctermfg=yellow      cterm=NONE

  highlight SpellBad         ctermbg=NONE       ctermfg=darkred     cterm=undercurl
  highlight SpellCap         ctermbg=NONE       ctermfg=darkyellow  cterm=undercurl
  highlight SpellLocal       ctermbg=NONE       ctermfg=darkgreen   cterm=undercurl
  highlight SpellRare        ctermbg=NONE       ctermfg=darkmagenta cterm=undercurl

  highlight ColorColumn      ctermbg=black      ctermfg=NONE        cterm=NONE
  highlight SignColumn       ctermbg=black      ctermfg=darkgray    cterm=NONE

  highlight debugPC          ctermbg=blue
  highlight debugBreakpoint  ctermbg=red
endif
" }}}
" linked groups {{{
hi link Boolean        PreProc
hi link Character      String
hi link Float          Number

hi link Conditional    PreProc
hi link Repeat         PreProc
hi link Label          PreProc
hi link Operator       PreProc
hi link Exception      PreProc
hi link Keyword        PreProc

hi link Include        PreProc
hi link Define         PreProc
hi link Macro          PreProc
hi link PreCondit      PreProc

hi link Debug          Special
hi link Delimiter      Special
hi link Tag            Special

hi link StorageClass   PreProc
hi link Structure      PreProc
hi link Typedef        PreProc

" plugins
hi link pythonDocstring SpecialKey

hi link BufTabLineActive   TabLineSel
hi link BufTabLineCurrent  PmenuSel
hi link BufTabLineHidden   TabLine
hi link BufTabLineFill     TabLineFill

hi link User1 TabLine
hi link User2 IncSearch
hi link User3 StatusLineTermNC
hi link User4 PmenuSel
hi link User5 IncSearch
hi link User6 WildMenu
hi link User7 DiffAdd
hi link User8 StatusLineTerm
hi link User9 StatusLineTerm

" }}}

" Cleanup
delcommand Highlight
