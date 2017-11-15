" airline {{{
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep=''
let g:airline_right_sep = ''
" }}}

" auto-pairs {{{
let g:AutoPairsMapBS = 1
let g:AutoPairsMapCR = 0
let g:AutoPairsShortcutToggle = ''
" }}}

" colorscheme {{{
if !empty(globpath(&rtp, 'colors/lucius.vim'))
	colorscheme lucius
	LuciusDark
endif
" }}}

" commentary {{{
xmap gc  <Plug>Commentary
nmap gc  <Plug>Commentary
omap gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
nmap cgc <Plug>ChangeCommentary
nmap gcu <Plug>Commentary<Plug>Commentary
" }}}

" easy-align {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" hardtime {{{
let g:hardtime_default_on = 1
let g:hardtime_timeout = 200
let g:hardtime_allow_different_key = 1
let g:hardtime_maxcount = 2

let g:list_of_normal_keys = ["h", "j", "k", "l"]
let g:list_of_visual_keys = ["h", "j", "k", "l"]
" }}}

" polyglot {{{
let g:polyglot_disabled = ['python', 'vim']
" }}}

" sideways {{{
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

nnoremap <S-Left> :SidewaysLeft<CR>
nnoremap <S-Right> :SidewaysRight<CR>
" }}}

" sneak {{{
nmap f <plug>Sneak_f
nmap F <plug>Sneak_F
xmap f <plug>Sneak_f
xmap F <plug>Sneak_F
omap f <plug>Sneak_f
omap F <plug>Sneak_F

nmap t <plug>Sneak_t
nmap T <plug>Sneak_T
xmap t <plug>Sneak_t
xmap T <plug>Sneak_T
omap t <plug>Sneak_t
omap T <plug>Sneak_T

nmap ; <Plug>Sneak_;
xmap ; <Plug>Sneak_;
nmap , <Plug>Sneak_,
xmap , <Plug>Sneak_,
" }}}

" undotree {{{
let g:undotree_WindowLayout = 3
let g:undotree_ShortIndicators = 1

nnoremap <F5> :UndotreeToggle<cr>
" }}}
