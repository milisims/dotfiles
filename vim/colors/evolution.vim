" 'evolution.vim' -- Vim color scheme.
" Author:       Matt Simmons (mtszyk@gmail.com)
" Description:  Colors originally from gruvbox, layout from apprentice.
" Last Change:  2018-04-11

hi clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'evolution'

" highlight function and commmand {{{

" The point of this function is simply to allow variables in the ex command,
" it is entirely a hack, and is probably unsafe to do generally. Don't do it.
" In this case, I think it helps make the colorscheme more readable.

function! s:hi(group, ...) abort
  let l:cmd = 'highlight ' . a:group
  for l:arg in a:000
    let l:term = split(l:arg, '=')
    let l:key = l:term[0]
    if len(split(l:term[1], ':')) == 2
      execute 'let l:color = ' . l:term[1]
    else
      let l:color = l:term[1]
    endif
    let l:cmd .= ' ' . l:key . '=' . l:color
  endfor
  execute l:cmd
endfunction

command! -nargs=+ -complete=highlight Highlight call s:hi(<f-args>)

" }}}
" color definitions {{{

let s:dark0  = [234, '#1d2021']
let s:dark1  = [235, '#282828']
let s:dark2  = [237, '#3c3836']
let s:dark3  = [239, '#504945']
let s:dark4  = [241, '#665c54']

" let s:dark0  = [234, '#1d2021']
" let s:dark1  = [237, '#3c3836']
" let s:dark2  = [239, '#504945']
" let s:dark3  = [241, '#665c54']
" let s:dark4  = [243, '#7c6f64']

let s:light0 = [230, '#f9f5d7']
let s:light1 = [223, '#ebdbb2']
let s:light2 = [250, '#d5c4a1']
let s:light3 = [248, '#bdae93']
let s:light4 = [246, '#a89984']

" standard colors
let s:red    = [124, '#cc241d']
let s:grn    = [114, '#81db7d']
let s:yel    = [172, '#d79921']
let s:blu    = [66, '#458588']
let s:vio    = [132, '#b16286']
let s:aqua   = [72, '#689d6a']
let s:orn    = [166, '#d65d0e']


" 'focus' colors, that stand out al ittle more than the defaults
if &background ==# 'light'
  let s:fred  = [88,  '#9d0006']
  let s:fgrn  = [100, '#79740e']
  let s:fyel  = [136, '#b57614']
  let s:fblu  = [24,  '#076678']
  let s:fvio  = [96,  '#8f3f71']
  let s:faqua = [66,  '#427b58']
  let s:forn  = [130, '#af3a03']
  let s:gray1 = [244, '#928374']
  let s:gray2 = [243, '#7c6f64']
  set background=light
else
  let s:fred  = [167, '#fb4934']
  let s:fgrn  = [142, '#b8bb26']
  let s:fyel  = [214, '#fabd2f']
  let s:fblu  = [109, '#83a598']
  let s:fvio  = [175, '#d3869b']
  let s:faqua = [108, '#8ec07c']
  let s:forn  = [208, '#fe8019']
  let s:gray1 = [245, '#928374']
  let s:gray2 = [246, '#a89984']
  set background=dark
endif

if &background ==# 'light'
  let s:bg_0 = s:light0
  let s:bg_1 = s:light1
  let s:bg_2 = s:light2
  let s:bg_3 = s:light3
  let s:bg_4 = s:light4
  let s:fg_0 = s:dark0
  let s:fg_1 = s:dark1
  let s:fg_2 = s:dark2
  let s:fg_3 = s:dark3
  let s:fg_4 = s:dark4
else
  let s:bg_0 = s:dark0
  let s:bg_1 = s:dark1
  let s:bg_2 = s:dark2
  let s:bg_3 = s:dark3
  let s:bg_4 = s:dark4
  let s:fg_0 = s:light0
  let s:fg_1 = s:light1
  let s:fg_2 = s:light2
  let s:fg_3 = s:light3
  let s:fg_4 = s:light4
endif

map <F5> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" }}}
" primary highlights {{{
" {{{
if ($TERM =~# '256' || &t_Co >= 256) || has('gui_running')

  Highlight Normal           ctermbg=s:bg_0[0] ctermfg=s:fg_1[0]  guibg=s:bg_0[1] guifg=s:fg_1[1]  cterm=NONE      gui=NONE

  Highlight LineNr           ctermbg=NONE      ctermfg=s:bg_3[0]  guibg=NONE      guifg=s:bg_3[1]  cterm=NONE      gui=NONE
  Highlight signColumn       ctermbg=NONE      ctermfg=s:fg_1[0]  guibg=NONE      guifg=s:fg_1[1]  cterm=NONE      gui=NONE
  Highlight FoldColumn       ctermbg=s:bg_1[0] ctermfg=s:fg_2[0]  guibg=s:bg_1[1] guifg=s:fg_2[1]  cterm=NONE      gui=NONE
  Highlight Folded           ctermbg=s:bg_1[0] ctermfg=s:fg_3[0]  guibg=s:bg_1[1] guifg=s:fg_3[1]  cterm=NONE      gui=NONE
  Highlight MatchParen       ctermbg=s:bg_3[0] ctermfg=s:yel[0]   guibg=s:bg_1[1] guifg=s:yel[1]   cterm=underline gui=underline

  Highlight Comment          ctermbg=NONE      ctermfg=s:gray1[0]  guibg=NONE      guifg=s:gray1[1]  cterm=italic    gui=italic
  Highlight Constant         ctermbg=NONE      ctermfg=s:fvio[0]  guibg=NONE      guifg=s:fvio[1]  cterm=NONE      gui=NONE
  Highlight Identifier       ctermbg=NONE      ctermfg=s:fblu[0]  guibg=NONE      guifg=s:fblu[1]  cterm=NONE      gui=NONE
  Highlight Statement        ctermbg=NONE      ctermfg=s:fred[0]  guibg=NONE      guifg=s:fred[1]  cterm=NONE      gui=NONE
  Highlight PreProc          ctermbg=NONE      ctermfg=s:faqua[0] guibg=NONE      guifg=s:faqua[1] cterm=NONE      gui=NONE
  Highlight Type             ctermbg=NONE      ctermfg=s:yel[0]   guibg=NONE      guifg=s:yel[1]   cterm=NONE      gui=NONE
  Highlight Special          ctermbg=NONE      ctermfg=s:orn[0]   guibg=NONE      guifg=s:orn[1]   cterm=NONE      gui=NONE
  Highlight Underlined       ctermbg=NONE      ctermfg=s:fblu[0]  guibg=NONE      guifg=s:fblu[1]  cterm=underline gui=underline
  Highlight Ignore           ctermbg=NONE      ctermfg=NONE       guibg=NONE      guifg=NONE       cterm=NONE      gui=NONE

  Highlight Function         ctermbg=NONE      ctermfg=s:faqua[0] guibg=NONE      guifg=s:faqua[1] cterm=NONE      gui=NONE
  Highlight String           ctermbg=NONE      ctermfg=s:yel[0]  guibg=NONE      guifg=s:yel[1]  cterm=NONE      gui=NONE

  Highlight Conceal          ctermbg=NONE      ctermfg=s:fg_1[0]  guibg=NONE      guifg=s:fg_1[1]  cterm=NONE      gui=NONE
  Highlight Error            ctermbg=s:fred[0] ctermfg=s:bg_0[0]  guibg=s:fred[1] guifg=s:bg_0[1]  cterm=bold      gui=bold
  Highlight Todo             ctermbg=s:bg_0[0] ctermfg=NONE       guibg=s:bg_0[1] guifg=NONE       cterm=bold      gui=bold

  Highlight NonText          ctermbg=NONE      ctermfg=s:gray2[0]  guibg=NONE      guifg=s:gray2[1]  cterm=NONE      gui=NONE

  Highlight Pmenu            ctermbg=s:bg_3[0] ctermfg=s:fg_1[0]  guibg=s:bg_3[1] guifg=s:fg_1[1]  cterm=NONE      gui=NONE
  Highlight PmenuSbar        ctermbg=s:gray1[0] ctermfg=NONE       guibg=s:gray1[1] guifg=NONE       cterm=NONE      gui=NONE
  Highlight PmenuSel         ctermbg=s:aqua[0] ctermfg=s:bg_1[0]  guibg=s:aqua[1] guifg=s:bg_1[1]  cterm=NONE      gui=NONE
  Highlight PmenuThumb       ctermbg=s:aqua[0] ctermfg=s:aqua[0]  guibg=s:aqua[1] guifg=s:aqua[1]  cterm=NONE      gui=NONE

  Highlight ErrorMsg         ctermbg=s:red[0]  ctermfg=s:bg_1[0]  guibg=s:red[1]  guifg=s:bg_1[1]  cterm=NONE      gui=NONE
  Highlight ModeMsg          ctermbg=s:grn[0]  ctermfg=s:bg_1[0]  guibg=s:grn[1]  guifg=s:bg_1[1]  cterm=NONE      gui=NONE
  Highlight MoreMsg          ctermbg=NONE      ctermfg=s:aqua[0]  guibg=NONE      guifg=s:aqua[1]  cterm=NONE      gui=NONE
  Highlight Question         ctermbg=NONE      ctermfg=s:grn[0]   guibg=NONE      guifg=s:grn[1]   cterm=NONE      gui=NONE
  Highlight WarningMsg       ctermbg=NONE      ctermfg=s:red[0]   guibg=NONE      guifg=s:red[1]   cterm=NONE      gui=NONE

  Highlight TabLine          ctermbg=s:bg_2[0] ctermfg=s:fg_1[0]  guibg=s:bg_2[1] guifg=s:fg_1[1]  cterm=NONE      gui=NONE
  Highlight TabLineFill      ctermbg=s:bg_2[0] ctermfg=s:bg_2[0]  guibg=s:bg_2[1] guifg=s:bg_2[1]  cterm=NONE      gui=NONE
  Highlight TabLineSel       ctermbg=s:bg_3[0] ctermfg=s:orn[0]   guibg=s:bg_3[1] guifg=s:orn[1]   cterm=NONE      gui=NONE

  Highlight Cursor           ctermbg=s:fg_1[0] ctermfg=NONE       guibg=s:fg_1[1] guifg=NONE       cterm=NONE      gui=NONE
  Highlight CursorColumn     ctermbg=s:bg_1[0] ctermfg=NONE       guibg=s:bg_1[1] guifg=NONE       cterm=NONE      gui=NONE
  Highlight CursorLineNr     ctermbg=s:bg_0[0] ctermfg=s:aqua[0]  guibg=s:bg_0[1] guifg=s:aqua[1]  cterm=NONE      gui=NONE
  Highlight CursorLine       ctermbg=s:bg_1[0] ctermfg=NONE       guibg=s:bg_1[1] guifg=NONE       cterm=NONE      gui=NONE
  Highlight ColorColumn      ctermbg=s:bg_1[0] ctermfg=NONE       guibg=s:bg_1[1] guifg=NONE       cterm=NONE      gui=NONE

  Highlight helpLeadBlank    ctermbg=NONE      ctermfg=NONE       guibg=NONE      guifg=NONE       cterm=NONE      gui=NONE
  Highlight helpNormal       ctermbg=NONE      ctermfg=NONE       guibg=NONE      guifg=NONE       cterm=NONE      gui=NONE

  Highlight StatusLine       ctermbg=s:bg_1[0] ctermfg=s:fg_1[0]  guibg=s:bg_1[1] guifg=s:fg_1[1]  cterm=NONE      gui=NONE
  Highlight StatusLineNC     ctermbg=s:bg_2[0] ctermfg=s:fg_4[0]  guibg=s:bg_2[1] guifg=s:fg_4[1]  cterm=NONE      gui=NONE

  Highlight StatusLineTerm   ctermbg=s:orn[0]  ctermfg=s:bg_1[0]  guibg=s:orn[1]  guifg=s:bg_1[1]  cterm=NONE      gui=NONE
  Highlight StatusLineTermNC ctermbg=s:bg_2[0] ctermfg=s:yel[0]   guibg=s:bg_2[1] guifg=s:yel[1]   cterm=NONE      gui=NONE

  Highlight Visual           ctermbg=s:bg_1[0] ctermfg=s:fblu[0]  guibg=s:bg_1[1] guifg=s:fblu[1]  cterm=reverse   gui=reverse
  Highlight VisualNOS        ctermbg=NONE      ctermfg=NONE       guibg=NONE      guifg=NONE       cterm=underline gui=underline

  Highlight VertSplit        ctermbg=s:bg_0[0] ctermfg=s:bg_2[0]  guibg=s:bg_0[1] guifg=s:bg_2[1]  cterm=NONE      gui=NONE
  Highlight WildMenu         ctermbg=s:blu[0]  ctermfg=s:bg_1[0]  guibg=s:blu[1]  guifg=s:bg_1[1]  cterm=NONE      gui=NONE

  Highlight SpecialKey       ctermbg=NONE      ctermfg=s:gray2[0]  guibg=NONE      guifg=s:gray2[1]  cterm=NONE      gui=NONE
  Highlight Title            ctermbg=NONE      ctermfg=s:fg_0[0] guibg=NONE      guifg=s:fg_0:white[1] cterm=NONE      gui=NONE

  Highlight DiffAdd          ctermbg=s:bg_1[0] ctermfg=s:grn[0]   guibg=s:bg_1[1] guifg=s:grn[1]   cterm=reverse   gui=reverse
  Highlight DiffChange       ctermbg=s:bg_1[0] ctermfg=s:vio[0]   guibg=s:bg_1[1] guifg=s:vio[1]   cterm=reverse   gui=reverse
  Highlight DiffDelete       ctermbg=s:bg_1[0] ctermfg=s:red[0]   guibg=s:bg_1[1] guifg=s:red[1]   cterm=reverse   gui=reverse
  Highlight DiffText         ctermbg=s:bg_1[0] ctermfg=s:orn[0]   guibg=s:bg_1[1] guifg=s:orn[1]   cterm=reverse   gui=reverse

  Highlight IncSearch        ctermbg=s:orn[0]  ctermfg=s:bg_1[0]  guibg=s:orn[1]  guifg=s:bg_1[1]  cterm=NONE      gui=NONE
  Highlight Search           ctermbg=s:yel[0]  ctermfg=s:bg_1[0]  guibg=s:yel[1]  guifg=s:bg_1[1]  cterm=NONE      gui=NONE

  Highlight Directory        ctermbg=NONE      ctermfg=s:aqua[0]  guibg=NONE      guifg=s:aqua[1]  cterm=NONE      gui=NONE

  Highlight debugPC          ctermbg=s:blu[0]  guibg=s:blu[1]
  Highlight debugBreakpoint  ctermbg=s:red[0]  guibg=s:red[1]

  if has('gui_running')
    Highlight SpellBad   ctermbg=NONE ctermfg=s:red[0]  guibg=NONE guifg=NONE      cterm=undercurl gui=undercurl guisp=s:red[1]
    Highlight SpellCap   ctermbg=NONE ctermfg=s:aqua[0] guibg=NONE guifg=NONE      cterm=undercurl gui=undercurl guisp=s:aqua[1]
    Highlight SpellLocal ctermbg=NONE ctermfg=s:grn[0]  guibg=NONE guifg=NONE      cterm=undercurl gui=undercurl guisp=s:grn[1]
    Highlight SpellRare  ctermbg=NONE ctermfg=s:orn[0]  guibg=NONE guifg=NONE      cterm=undercurl gui=undercurl guisp=s:orn[1]
  else
    Highlight SpellBad   ctermbg=NONE ctermfg=s:red[0]  guibg=NONE guifg=s:red[1]  cterm=undercurl gui=undercurl guisp=NONE
    Highlight SpellCap   ctermbg=NONE ctermfg=s:aqua[0] guibg=NONE guifg=s:aqua[1] cterm=undercurl gui=undercurl guisp=NONE
    Highlight SpellLocal ctermbg=NONE ctermfg=s:grn[0]  guibg=NONE guifg=s:grn[1]  cterm=undercurl gui=undercurl guisp=NONE
    Highlight SpellRare  ctermbg=NONE ctermfg=s:orn[0]  guibg=NONE guifg=s:orn[1]  cterm=undercurl gui=undercurl guisp=NONE
  endif

  " }}}
  " {{{
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
" }}}
" linked groups {{{
hi link Boolean        Constant
hi link Character      Constant
hi link Number         Constant
hi link Float          Number

hi link Conditional    Statement
hi link Repeat         Statement
hi link Label          Statement
hi link Operator       Normal
hi link Exception      Statement
hi link Keyword        Statement

hi link Include        PreProc
hi link Define         PreProc
hi link Macro          PreProc
hi link PreCondit      PreProc

hi link Debug          Special
hi link Delimiter      Special
hi link SpecialChar    Special
hi link SpecialComment Special
hi link Tag            Special

hi link StorageClass   Special
hi link Structure      PreProc
hi link Typedef        Type

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

" hi link pythonBuiltin     Statement
" hi link pythonBuiltinObj  Statement
" hi link pythonBuiltinFunc Statement
" hi link pythonFunction    Function
" hi link pythonDecorator   Constant
" hi link pythonInclude     PreProc
" hi link pythonImport      PreProc
" hi link pythonRun         Todo
" hi link pythonCoding      Todo
" hi link pythonOperator    Operator
" hi link pythonException   Todo
" hi link pythonExceptions  Todo
" hi link pythonBoolean     Type
" hi link pythonDot         Todo
" hi link pythonConditional Todo
" hi link pythonRepeat      Todo
" hi link pythonDottedName  Todo
" hi link pythonDoctest  SpecialComment

" Cleanup
delcommand Highlight
