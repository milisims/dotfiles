let g:deoplete#enable_at_startup = 1

" for detailed config, see :
" https://github.com/rafi/vim-config/blob/master/config/plugins/deoplete.vim

set completeopt=menu

" Use smartcase.
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  " return deoplete#close_popup() .
  return deoplete#close_popup() . "\<CR>"
endfunction

let g:deoplete#sources#jedi#statement_length = 200
let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#sources#jedi#short_types = 1
let g:deoplete#sources#jedi#enable_cache = 1


let g:deoplete#disable_auto_complete = 1
let g:deoplete#auto_complete_delay=10
let g:deoplete#auto_refresh_delay=50

inoremap <expr><C-g> deoplete#undo_completion()

inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

inoremap <expr><C-d> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
inoremap <expr><C-u> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

" <Tab> completion:
" 1. If popup menu is visible, select and insert next item
" 3. Otherwise, if preceding chars are whitespace, insert tab char
" 4. Otherwise, start manual autocomplete
""" 2. Otherwise, if within a snippet, jump to next input (neosnippet: NYI)
inoremap <silent><expr><Tab> pumvisible() ? "\<C-n>"
    \ : (<SID>is_whitespace() ? "\<Tab>"
    \ : deoplete#manual_complete())
    " \ : (neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)"

snoremap <silent><expr><Tab> pumvisible() ? "\<C-n>"
    \ : (<SID>is_whitespace() ? "\<Tab>"
    \ : deoplete#manual_complete())
    " \ : (neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)"

inoremap <expr><S-Tab>  pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:is_whitespace()
    let col = col('.') - 1
    return ! col || getline('.')[col - 1] =~? '\s'
endfunction

