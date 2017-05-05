if exists(':Plug')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'zchee/deoplete-jedi'           " Jedi (python) completion
    Plug 'Shougo/neco-vim'               " vim completion
    " davidhalter/jedi-vim (necessary with deoplete-jedi?)

    Plug 'Shougo/denite.nvim'            " makes a nice buffer to search through
    Plug 'Shougo/neomru.vim'             " most recently used files source
    Plug 'Shougo/neoinclude.vim'         " include files source
    Plug 'chemzqm/unite-location'        " quickfix and location list source
    Plug 'Shougo/neosnippet.vim'         " snippets!
    Plug 'Shougo/neosnippet-snippets'
    " Plug 'nixprime/cpsm'              " for denite matching.. doesn't work?

    " for linting and automatic execution of linting
    Plug 'neomake/neomake'

    " Plug 'python-mode/python-mode'
endif

