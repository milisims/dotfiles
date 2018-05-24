scriptencoding utf-8

if !has('packages')
  finish
endif

" Deferring: {{{
" TODO: List of 'files' to call in order
let s:defer_list = ['DeferVimPack']

function! s:idledefer() abort
  autocmd! IdleCmd
  for l:deferfile in s:defer_list
    execute 'doautocmd User ' . l:deferfile
    execute 'autocmd! User ' . l:deferfile
  endfor
endfunction

augroup IdleCmd
  if has('vim_starting')
    autocmd CursorHold,InsertEnter,TextChanged * call s:idledefer()
  endif
augroup END

function! s:defer(file, evalable) abort
  if index(s:defer_list, a:file) < 0
    call add(s:defer_list, a:file)
  endif
  execute 'autocmd User ' . a:file . ' '  . a:evalable
endfunction

if has('nvim')
  call s:defer('DeferVimUpdateRemote', 'silent UpdateRemotePlugins')
endif

command -nargs=1 Dpackadd call s:defer('DeferVimPack', 'packadd ' . <f-args>)
command -nargs=1 Defer call s:defer('DeferVimCall', 'call ' . <f-args>)
call s:defer('DeferVimFinal', 'set updatetime=' . &updatetime)
set updatetime=20
" }}}

" vim-repeat {{{
packadd! vim-repeat
" }}}
" vim-sneak {{{
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F

nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

nmap ; <Plug>Sneak_;
xmap ; <Plug>Sneak_;
nmap , <Plug>Sneak_,
xmap , <Plug>Sneak_,

nmap \ <Plug>Sneak_s
nmap <leader>\ <Plug>Sneak_S
nmap <leader>s <Plug>Sneak_s
nmap <leader>S <Plug>Sneak_S
packadd! vim-sneak
" }}}
" vim-cursorword {{{
packadd! vim-cursorword
" }}}
" vim-highlightedyank {{{
packadd! vim-highlightedyank
if !exists('##TextYankPost')
  nmap y <Plug>(highlightedyank)
  xmap y <Plug>(highlightedyank)
endif
" }}}
" echodoc.vim {{{
packadd! echodoc.vim
let g:echodoc#enable_at_startup = 1
" }}}
" fzf.vim {{{
if executable('fzf')
  set runtimepath+=~/.fzf
  source ~/.fzf/plugin/fzf.vim
  packadd! fzf.vim

  let $FZF_DEFAULT_COMMAND = 'ag -g ""'
  nnoremap <silent> <leader>af  :Files<CR>
  nnoremap <silent> <leader>f   :GFiles<CR>
  nnoremap <silent> <leader>gst :GFiles?<CR>
  nnoremap <silent> <leader>b   :Buffers<CR>
  nnoremap <silent> <leader>l   :Lines<CR>
  nnoremap <silent> <leader>L   :BLines<CR>
  nnoremap <expr> <silent> <leader>O   ':Tags<CR>\'' . expand('<cword>')
  nnoremap <silent> <leader>mr  :History<CR>
  nnoremap <silent> <leader>/   :execute 'Ag ' . input('Ag/')<CR>
  nnoremap <silent> <leader>A   :Ag<CR>
  nnoremap <silent> <leader>ht  :Helptags<CR>

  " TODO: :h K and :h 'keywordprg'
  nnoremap <expr> <silent> K ':Ag<CR>' . get(b:, 'fzf_defprefix', '') . "'" . expand('<cword>') . ' '
  nnoremap <expr> <silent> <F5> ':Ag<CR>' . "'" . expand('<cword>') . get(b:, 'fzf_fsuffix', '')
  " vnoremap <expr> <silent> K ':yank | Ag<CR><C-r>"'
  nnoremap <silent> <leader>gal :Commits<CR>
  nnoremap <silent> <leader>gl :BCommits<CR>

  imap <c-x><c-k> <Plug>(fzf-complete-word)
  imap <c-x><c-f> <Plug>(fzf-complete-path)
  imap <c-x><c-j> <Plug>(fzf-complete-file-ag)
  imap <c-x><c-l> <Plug>(fzf-complete-line)

  imap <C-x><C-f> <Plug>(fzf-complete-file-ag)
  imap <C-x><C-l> <Plug>(fzf-complete-line)

  augroup vimrc_term_fzf
    autocmd!
    autocmd FileType python let b:fzf_defprefix = "'def | 'class "
    autocmd FileType python let b:fzf_fsuffix = '('

    if has('nvim')
      " see augroup vimrc_term
      autocmd TermOpen *#FZF tunmap <buffer> <Esc>
      autocmd TermOpen *#FZF tunmap <buffer> <C-h>
      autocmd TermOpen *#FZF tunmap <buffer> <C-j>
      autocmd TermOpen *#FZF tunmap <buffer> <C-k>
      autocmd TermOpen *#FZF tunmap <buffer> <C-l>
    endif
  augroup END

endif
" }}}
" vim-easy-align {{{
packadd! vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" }}}
" targets {{{
let g:targets_aiAI = 'aIAi'
packadd! targets.vim
" }}}
packadd! vim-buftabline

" ft specific
" vim-python-pep8-indent {{{
packadd! vim-python-pep8-indent
" }}}
" python_match.vim {{{
packadd! python_match.vim
" }}}
" vim-pandoc {{{
" packadd vim-pandoc
" packadd vim-pandoc-syntax
let g:pandoc#folding#fdc = 0
" }}}


" Deferred:
" vim-surround {{{
Dpackadd vim-surround
" }}}
" vim-unimpaired {{{
Dpackadd vim-unimpaired
" }}}
" vim-eunuch {{{
Dpackadd vim-eunuch
" }}}
" vim-fugitive {{{
Dpackadd vim-fugitive
" }}}
" vim-commentary {{{
Dpackadd vim-commentary
xmap gc  <Plug>Commentary
nmap gc  <Plug>Commentary
omap gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
nmap cgc <Plug>ChangeCommentary
nmap gcu <Plug>Commentary<Plug>Commentary
" }}}
" vim-exchange {{{
Dpackadd vim-exchange
" }}}
" syntax-vim-ex {{{
Dpackadd syntax-vim-ex
" }}}
" vim-gitgutter {{{
Dpackadd vim-gitgutter
Defer gitgutter#all(1)
let g:gitgutter_max_signs = 1000
" }}}

if has('nvim')
  " ultisnips {{{
  Dpackadd vim-snippets
  Dpackadd ultisnips
  let g:UltiSnipsExpandTrigger = '<Tab>'
  let g:UltiSnipsJumpForwardTrigger = '<Tab>'
  let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
  let g:UltiSnipsRemoveSelectModeMappings = 0
  " }}}
  " nvim-completion-manager {{{
  " Better if loaded after ultisnips (ncm checks for it)
  Dpackadd nvim-completion-manager
  Dpackadd neco-vim

  inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
  inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

  " }}}
  " ale {{{
  Dpackadd ale
  set signcolumn=yes
  let g:ale_sign_error = '✖'  " U-2716
  let g:ale_sign_warning = '⚠'  " U-26A0
  let g:ale_sign_style_error = '➤'  " U-27A4
  hi! link ALEErrorSign WarningMsg
  hi! link ALEWarningSign Constant

  augroup vimrc_ale
    autocmd!
    autocmd Filetype python let b:ale_linters = ['pycodestyle', 'pydocstyle', 'pyflakes']
  augroup END

  " }}}
  " vim-gutentags {{{
  if executable('ctags')
    Dpackadd vim-gutentags
    Defer gutentags#setup_gutentags()
    let g:gutentags_cache_dir = $DATADIR.'/tags'
    let g:gutentags_ctags_executable = $HOME.'/bin/ctags'  " probably unnecessary
  else
    let g:gutentags_enabled = 0
  endif
  " }}}
  " iron.nvim {{{
  Dpackadd iron.nvim
  let g:iron_map_defaults = 0

  augroup vimrc_iron
    autocmd!
    autocmd Filetype python nmap <buffer> <leader>e     <Plug>(iron-send-motion)
    autocmd Filetype python xmap <buffer> <leader>e     <Plug>(iron-send-motion)
    autocmd Filetype python nmap <buffer> <leader>el   V<Plug>(iron-send-motion)
    autocmd Filetype python nmap <buffer> <leader>eh    <Nop>
    autocmd Filetype python nmap <buffer> <leader>e<cr> <Plug>(iron-cr)
    autocmd Filetype python nmap <buffer> <leader>er    <Plug>(iron-repeat-cmd)
  augroup END

  " }}}
  " thesaurus_query.vim {{{
  Dpackadd thesaurus_query.vim
  let g:tq_map_keys = 0
  let g:tq_use_vim_autocomplete = 0
  " }}}
endif

delcommand Dpackadd
delcommand Defer
