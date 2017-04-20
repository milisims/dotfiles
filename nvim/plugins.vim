if exists(':Plug')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'zchee/deoplete-jedi'           " Jedi (python) completion
    Plug 'Shougo/neco-vim'               " vim completion

    Plug 'Shougo/denite.nvim'            " makes a nice buffer to search through
    Plug 'Shougo/neomru.vim'             " most recently used files source
    Plug 'Shougo/neoinclude.vim'         " include files source
    Plug 'chemzqm/unite-location'        " quickfix and location list source

    Plug 'Konfekt/FastFold'              " updates only when necessary

    " for linting and automatic execution of linting
    Plug 'neomake/neomake'
endif

