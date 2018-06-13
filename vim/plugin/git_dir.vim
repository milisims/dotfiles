set noautochdir

function! s:get_chdir() abort
  let l:gitroot = get(b:, 'git_dir', '')  " from vim-fugitive
  let l:gitroot = resolve(substitute(l:gitroot, '/\.git$', '', ''))
  if !empty(l:gitroot)
    return l:gitroot
  endif
  let l:filedir = resolve(expand('%:p:h'))
  if empty(l:filedir)
    let l:filedir = resolve(getcwd())
  endif
  return l:filedir
endfunction

function! s:goto_gitdir() abort
  if !&modifiable
    return
  endif

  let b:autochdir = get(b:, 'autochdir', s:get_chdir())
  execute 'lcd ' . b:autochdir
endfunction

augroup vimrc_gitchdir
  autocmd!
  if exists('##DirChanged')
    autocmd DirChanged * let b:autochdir = getcwd()
  endif
  autocmd BufEnter,WinEnter * call s:goto_gitdir()
augroup END
