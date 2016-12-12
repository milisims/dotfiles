
" Set 7 lines to the curors - when moving vertical..
set so=8

set number
set relativenumber

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class
set wildmenu      " On by default in nvim
set cmdheight=2   " The commandbar height
set hidden        " hide buffers without unloading

set backspace=eol,start,indent    " set movement
set whichwrap+=<,>,h,l            " options

set ignorecase     " Ignore case when searching
set smartcase      " Ignore above if any uppercase
set hlsearch       " Highlight search things  - nvim on by default
set incsearch      " incremental search       - nvim on by default
set lazyredraw     " Don't redraw while executing macros
set magic          " Set vims regex to the same as greps
set showmatch      " Show matching bracets when text indicator is over them
set ttyfast        " Makes drawing nicer      - nvim on by default
set noerrorbells   " Self explanatory
set novisualbell   " The window doesn't flash when an error happens
set t_vb=          " Clears the visual bell thing
set tm=500         " Timeout for a command in ms
if v:version >= 704
    set colorcolumn=80 " writes a column at the 80th character
endif

let g:tex_conceal = ""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: netrw
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:netrw_liststyle = 3
" let g:netrw_banner = 0



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable     " Enable syntax highlighting
syntax on         " And turn it on..
set t_Co=256      " Bit of a force, might need to play on some systems.
set encoding=utf-8
set background=dark
