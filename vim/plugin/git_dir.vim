set noautochdir

augroup vimrc_gitchdir
  autocmd!
  if exists('##DirChanged')
    autocmd DirChanged * let b:autochdir = getcwd()
  endif
  autocmd BufEnter,WinEnter * call git_dir#gotodir()
augroup END

" vim: set ts=2 sw=2 tw=99 et :
