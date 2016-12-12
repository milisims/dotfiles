" Change file_rec command.  this breaks it for some reason
" call denite#custom#var('file_rec', 'command',
" \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
" " For ripgrep
" " Note: It is slower than ag
" call denite#custom#var('file_rec', 'command',
" \ ['rg', '--files', '--glob', '!.git'])

nnoremap <C-p> :Denite line<CR>

" Change mappings.
call denite#custom#map(
      \ 'insert',
      \ '<C-j>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-k>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)

call denite#custom#map(
    \ 'insert',
    \ '<C-a>',
    \ '<denite:move_caret_to_head>',
    \ 'noremap' )

" Change matchers.
call denite#custom#source(
\ 'file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])
call denite#custom#source(
\ 'file_rec', 'matchers', ['matcher_cpsm'])

" Change sorters.
call denite#custom#source(
\ 'file_rec', 'sorters', ['sorter_sublime'])

" Add custom menus
let s:menus = {}

let s:menus.zsh = {
    \ 'description': 'Edit your import zsh configuration'
    \ }
let s:menus.zsh.file_candidates = [
    \ ['zshrc', '~/.config/zsh/.zshrc'],
    \ ['zshenv', '~/.zshenv'],
    \ ]

let s:menus.my_commands = {
    \ 'description': 'Example commands'
    \ }
let s:menus.my_commands.command_candidates = [
    \ ['Split the window', 'vnew'],
    \ ['Open zsh menu', 'Denite menu:zsh'],
    \ ]

call denite#custom#var('menu', 'menus', s:menus)

" Ack command on grep source
call denite#custom#var('grep', 'command', ['ack'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#var('grep', 'separator', [])
call denite#custom#var('grep', 'default_opts',
        \ ['--ackrc', $HOME.'/.ackrc', '-H',
        \ '--nopager', '--nocolor', '--nogroup', '--column'])
" Ripgrep command on grep source
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'default_opts',
        \ ['--vimgrep', '--no-heading'])

call denite#custom#source('file_mru', 'converters',
      \ ['converter_relative_word'])

" Define alias
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
      \ ['git', 'ls-files', '-co', '--exclude-standard'])

" Change default prompt
call denite#custom#option('default', 'prompt', '>')

" Change ignore_globs
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/',
      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])
