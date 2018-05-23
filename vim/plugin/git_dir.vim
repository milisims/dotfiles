set noautochdir

function! s:get_gitdir() abort
  let l:filedir = resolve(expand('%:p:h'))
  if empty(l:filedir)
    let l:filedir = resolve(getcwd())
  endif

  let l:gitroot = system('cd ' . expand('%:p:h') . ' && git rev-parse --git-dir')
  if v:shell_error > 0
    return l:filedir
  endif

  let l:gitroot = substitute(l:gitroot, '\%x00', '', '')
  let l:gitroot = resolve(substitute(l:gitroot, '\C\.git$', '', ''))
  if !empty(l:gitroot)
    return l:gitroot
  endif
  return l:filedir
endfunction

function! s:goto_gitdir() abort
  let b:git_autochdir = get(b:, 'git_autochdir', s:get_gitdir())
  execute 'lcd ' . b:git_autochdir
endfunction

augroup vimrc_gitchdir
  autocmd!
  if exists('##DirChanged')
    autocmd DirChanged * let b:git_autochdir = getcwd()
  endif
  autocmd BufEnter,WinEnter * call s:goto_gitdir()
augroup END
