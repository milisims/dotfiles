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

  delcommand Dpackadd
  delcommand Defer
endfunction

augroup IdleCmd
  if has('vim_starting')
    autocmd CursorHold,InsertEnter,TextChanged * call s:idledefer()
    " autocmd InsertEnter,TextChanged * call s:idledefer()
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
set updatetime=100  " windows needs

" }}}

" start:
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

nmap s <Plug>Sneak_s
nmap S <Plug>Sneak_S

" }}}
" vim-highlightedyank {{{
if !exists('##TextYankPost')
  nmap y <Plug>(highlightedyank)
  xmap y <Plug>(highlightedyank)
endif
" }}}
" vim-easy-align {{{
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" }}}
" targets {{{
let g:targets_aiAI = 'aIAi'
" }}}
" vim-filebeagle {{{
let g:filebeagle_suppress_keymaps = 1
nmap <silent> <leader>- <Plug>FileBeagleOpenCurrentBufferDir
let g:loaded_netrwPlugin = 'v9999'
" }}}
" vim-commentary {{{
xmap gc  <Plug>Commentary
nmap gc  <Plug>Commentary
omap gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
nmap cgc <Plug>ChangeCommentary
nmap gcu <Plug>Commentary<Plug>Commentary
" }}}
" vim-fugitive {{{
nnoremap <silent> <leader>dgl :call difference#gitlog()<cr>
" }}}
" vim-signify {{{
highlight link SignifyLineAdd             String
highlight link SignifyLineChange          Todo
highlight link SignifyLineDelete          Error
highlight link SignifyLineChangeDelete    SignifyLineChange
highlight link SignifyLineDeleteFirstLine SignifyLineDelete

highlight link SignifySignAdd             String
highlight link SignifySignChange          Todo
highlight link SignifySignDelete          Error
highlight link SignifySignChangeDelete    SignifyLineChange
highlight link SignifySignDeleteFirstLine SignifyLineDelete
let g:signify_vcs_list = ['git']
let g:signify_sign_delete = '-'
let g:signify_sign_change = '~'
let g:signify_skip_filetype = { 'markdown': 1 }
" }}}
" end start

packadd! vim-python-pep8-indent
packadd! python_match.vim
packadd! vim-pythonsense
" vim-pandoc {{{
" packadd! vim-pandoc
" packadd! vim-pandoc-syntax
let g:pandoc#folding#fdc = 0
" }}}
" fzf.vim {{{
if executable('fzf')
  " TODO: command history: https://goo.gl/aGkUbx
  set runtimepath+=~/.fzf
  source ~/local/src/fzf/plugin/fzf.vim
  packadd! fzf.vim

  let $FZF_DEFAULT_COMMAND = 'ag -g ""'
  nnoremap <silent> <leader>af  :Files<CR>
  nnoremap <silent> <leader>f   :GFiles<CR>
  nnoremap <silent> <leader>gst :GFiles?<CR>
  nnoremap <silent> <leader>b   :Buffers<CR>
  nnoremap <silent> <leader>l   :Lines<CR>
  nnoremap <silent> <leader>/   :BLines<CR>
  nnoremap <expr> <silent> <leader>O    ':Tags<CR>' . "'" . expand('<cword>') . ' '
  nnoremap <silent> <leader>mr  :History<CR>
  nnoremap <silent> <leader>A   :Ag<CR>
  nnoremap <silent> <leader>ht  :Helptags<CR>
  nnoremap <silent> <leader>gal :Commits<CR>
  nnoremap <silent> <leader>gl :BCommits<CR>

  " TODO: :h K and :h 'keywordprg'
  nnoremap <expr> <silent> <F3> ':Ag<CR>' . get(b:, 'fzf_defprefix', '') . "'" . expand('<cword>') . ' '
  xnoremap <expr> <silent> <F3> ':y a<CR>:Ag<CR>' . get(b:, 'fzf_defprefix', '') . "'" . @a . ' '
  nnoremap <expr> <silent> <F5> ':Ag<CR>' . "'" . expand('<cword>') . get(b:, 'fzf_fsuffix', '')

  function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
  endfunction

  let g:fzf_action = {
        \ 'ctrl-q': function('s:build_quickfix_list'),
        \ 'ctrl-s': 'split',
        \ 'ctrl-v': 'vsplit' }

  augroup vimrc_term_fzf
    autocmd!
    autocmd FileType python let b:fzf_defprefix = "'def | 'class "
    autocmd FileType python let b:fzf_fsuffix = '('

    if has('nvim')
      autocmd FileType fzf tunmap <buffer> <Esc>
      autocmd FileType fzf tunmap <buffer> <C-h>
      autocmd FileType fzf tunmap <buffer> <C-j>
      autocmd FileType fzf tunmap <buffer> <C-k>
      autocmd FileType fzf tunmap <buffer> <C-l>
    endif
  augroup END

endif
" }}}

" Deferred:
" syntax-vim-ex {{{
Dpackadd syntax-vim-ex
" }}}

if has('nvim')
  " ultisnips {{{
  Dpackadd ultisnips
  let g:UltiSnipsSnippetDirectories = [$CFGDIR . '/snips', 'UltiSnips']
  let g:UltiSnipsExpandTrigger = '<Tab>'
  let g:UltiSnipsJumpForwardTrigger = '<Tab>'
  let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
  let g:UltiSnipsRemoveSelectModeMappings = 0
  " }}}
  " ncm2 {{{
  " Better if loaded after ultisnips (ncm checks for it)
  packadd! ncm2
  packadd! ncm2-bufword
  packadd! ncm2-highprio-pop
  packadd! ncm2-jedi
  packadd! ncm2-look.vim
  packadd! ncm2-markdown-subscope
  packadd! ncm2-path
  packadd! ncm2-syntax
  packadd! ncm2-tagprefix
  packadd! ncm2-tmux
  packadd! ncm2-ultisnips
  packadd! neco-syntax
  packadd! nvim-yarp

  function! s:setup_ncm2() abort
    if has('win32')
      return
    endif
    call ncm2#enable_for_buffer()
    augroup vimrc_ncm2
      autocmd BufEnter * call ncm2#enable_for_buffer()
    augroup END
  endfunction

  Defer s:setup_ncm2()

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
  if executable($HOME.'/local/bin/ctags')
    Dpackadd vim-gutentags
    Defer gutentags#setup_gutentags()
    let g:gutentags_cache_dir = $DATADIR.'/tags'
    let g:gutentags_ctags_executable = $HOME.'/local/bin/ctags'
  else
    let g:gutentags_enabled = 0
  endif
  " }}}
  " thesaurus_query.vim {{{
  Dpackadd thesaurus_query.vim
  let g:tq_map_keys = 0
  let g:tq_use_vim_autocomplete = 0
  " }}}
endif

" Windows
if has('win32')
  " fonts {{{
  function! s:setup_guifont() abort
    Guifont! DejaVu Sans Mono:h9
  endfunction
  Defer s:setup_guifont()
  " }}}
endif

" Temporary fix for slow git loading
Defer git_dir#gotodir()

" vim: set ts=2 sw=2 tw=99 et :
