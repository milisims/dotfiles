if exists(':Plug')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'zchee/deoplete-jedi'           " Jedi (python) completion
	Plug 'Shougo/neco-vim'               " vim completion
	" try roxma/nvim-completion-manager someday

	Plug 'Shougo/denite.nvim'            " makes a nice buffer to search through
	Plug 'Shougo/neomru.vim'             " most recently used files source
	Plug 'Shougo/neoinclude.vim'         " include files source
	Plug 'chemzqm/unite-location'        " quickfix and location list source
	Plug 'neoclide/denite-git'           " gitlog, status, change source
	Plug 'Shougo/neosnippet.vim'         " snippets!
	Plug 'Shougo/neosnippet-snippets'
	Plug 'Shougo/neco-syntax'            " syntax source

	Plug 'neomake/neomake'               " linting
	Plug 'ludovicchabant/vim-gutentags'  " automatic ctags generation
	Plug 'airblade/vim-gitgutter'        " signs for git changes

	Plug 'vimwiki/vimwiki'               " self management
	Plug 'thaerkh/vim-workspace'         " session management

endif

