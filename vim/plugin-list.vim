" NOTE: to install without exiting, select the new lines, yank, execute :@"
"       then :PlugInstall
if exists(':Plug')

	Plug 'tpope/vim-surround'                " surrounding text object
	Plug 'tpope/vim-commentary'              " easier comments (gc)
	Plug 'justinmk/vim-sneak'                " move around more easily!
	Plug 'bling/vim-airline'                 " pretty statusbars
	Plug 'jeffkreeftmeijer/vim-numbertoggle' " automatic relanums
	Plug 'rafi/awesome-vim-colorschemes'     " current: LuciusDark
	Plug 'itchyny/vim-cursorword'            " highlight same word under cursor
	Plug 'jiangmiao/auto-pairs'              " autocomplete ()s, etc
	Plug 'sheerun/vim-polyglot'              " vim language pack
	Plug 'raimon49/requirements.txt.vim'
	Plug 'junegunn/vim-easy-align'           " align comments, etc
	Plug 'AndrewRadev/sideways.vim'          " function parameter text obj (a)
	Plug 'AndrewRadev/splitjoin.vim'         " gJ, gS to split or join statements
	Plug 'takac/vim-hardtime'								 " stop repeating hjkl!

  if has('patch-7.4.786')
		Plug 'itchyny/vim-parenmatch'          " faster default plugin for matching
	endif

	Plug 'tpope/vim-unimpaired'              " mapping for common pairs of actions
	Plug 'tpope/vim-repeat'                  " allows more plugin . usage
	Plug 'tpope/vim-eunuch'                  " vim sugar for unix shell cmds
	Plug 'mbbill/undotree'                   " provides undotree visualization

	Plug 'Vimjas/vim-python-pep8-indent'
	Plug 'vim-scripts/python_match.vim'
	Plug 'vim-jp/syntax-vim-ex'
	Plug 'andreshazard/vim-logreview'

endif

