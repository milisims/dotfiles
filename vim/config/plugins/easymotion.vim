
""""""""""""""""""""""""""""""
" => EasyMotion
""""""""""""""""""""""""""""""
let g:EasyMotion_keys='asdfjkl;'      " only use home row keys
let g:EasyMotion_do_shade=1           " Shade text
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
nmap <leader>f <Plug>(easymotion-s)

