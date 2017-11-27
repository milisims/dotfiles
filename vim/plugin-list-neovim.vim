if exists(':Plug')

	Plug 'Shougo/denite.nvim'            " makes a nice buffer to search through
	Plug 'Shougo/neomru.vim'             " most recently used files source
	Plug 'chemzqm/unite-location'        " quickfix and location list source

	Plug 'SirVer/ultisnips'              " snippets!
	Plug 'matthsims/vim-snippets'

	Plug 'roxma/nvim-completion-manager', { 'do': ':UpdateRemotePlugins' }
	Plug 'neomake/neomake'
	Plug '5long/pytest-vim-compiler'

	Plug 'airblade/vim-gitgutter'        " signs for git changes
	Plug 'ludovicchabant/vim-gutentags'  " automatic ctags generation

	Plug 'junegunn/fzf.vim'

	Plug 'vimwiki/vimwiki'               " self management
	Plug 'machakann/vim-highlightedyank'

endif
