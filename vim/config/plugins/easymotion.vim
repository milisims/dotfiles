
" why is it not loaded_easymotion?
let g:EasyMotion_keys='asdfjkl;'      " only use home row keys
let g:EasyMotion_do_shade=1           " Shade text
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion

nmap <leader>ss <Plug>(easymotion-s2)
nmap <leader>sd <Plug>(easymotion-s)
nmap <leader>sf <Plug>(easymotion-overwin-f)

map  <leader>sh <Plug>(easymotion-linebackward)

map  <leader>sl <Plug>(easymotion-lineforward)
" map  sj <Plug>(easymotion-j)
" map  sk <Plug>(easymotion-k)
map  <leader>s/ <Plug>(easymotion-sn)
omap <leader>s/ <Plug>(easymotion-tn)
map  <leader>sn <Plug>(easymotion-next)
map  <leader>sp <Plug>(easymotion-prev)
