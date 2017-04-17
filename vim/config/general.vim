" Return to last edit position. On opening a file
" VERY useful.
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

set mouse=a             " enable mouse

set showcmd        " shows cmd mode keystrokes

set clipboard^=unnamed,unnamedplus
