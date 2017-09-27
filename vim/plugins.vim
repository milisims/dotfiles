" List of plugins for vim and nvim.
" Want to keep the primary functionality of the way I use
" vim available to as low a version as possible, which is
" determined here by vim-airline, something like vim-7.4
"
" NOTE: to install without exiting, select the new lines, yank, execute :@"
"       then :PlugInstall
if exists(':Plug')

	Plug 'tpope/vim-surround'                " surrounding text object
	Plug 'tpope/vim-commentary'              " easier comments (gc)
	Plug 'justinmk/vim-sneak'                " move around more easily!
	Plug 'bling/vim-airline'                 " pretty statusbars
	Plug 'jeffkreeftmeijer/vim-numbertoggle' " F2 for numbers vs relanus
	Plug 'rafi/awesome-vim-colorschemes'     " current: LuciusDark
	Plug 'itchyny/vim-cursorword'            " highlight same word under cursor
	Plug 'jiangmiao/auto-pairs'              " autocomplete ()s, etc
	Plug 'itchyny/vim-parenmatch'            " faster default plugin for matching
	Plug 'sheerun/vim-polyglot'              " vim language pack
	Plug 'junegunn/vim-easy-align'           " align comments, etc
	Plug 'AndrewRadev/sideways.vim'          " function parameter text obj (a)
	Plug 'AndrewRadev/splitjoin.vim'         " gJ, gS to split or join statements

	Plug 'tpope/vim-unimpaired'              " mapping for common pairs of actions
	Plug 'tpope/vim-repeat'                  " allows more plugin . usage
	Plug 'tpope/vim-eunuch'                  " vim sugar for unix shell cmds
	" Plug 'Konfekt/FastFold'                  " sparsely recalculate vim fodls
	Plug 'mbbill/undotree'                   " provides undotree visualization

	" christoomey/tmux-navigator
	" tmux-plugins/vim-tmux

	" Configuration checks for loaded plugins via exists('g:loaded_<pl>')
	" so just skip the lazy loading. Loading all plugins adds < 1 ms load time
	" Plug 'python-mode/python-mode'           " , { 'for': 'python' }
	Plug 'vim-python/python-syntax'          " , { 'for': 'python' }
	Plug 'Vimjas/vim-python-pep8-indent'     " , { 'for': 'python' }
	Plug 'vim-scripts/python_match.vim'      " , { 'for': 'python' }
	Plug 'tmhedberg/SimpylFold'              " , { 'for': 'python' }
	Plug 'raimon49/requirements.txt.vim'     " , { 'for': 'python' }

	Plug 'vim-jp/syntax-vim-ex'              " , { 'for': 'vim' }

	Plug 'andreshazard/vim-logreview'

endif

