" Return to last edit position. On opening a file
" VERY useful.
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif


set clipboard^=unnamed,unnamedplus
