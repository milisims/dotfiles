# Variables
CFG := $(HOME)/.config
SRC := $(HOME)/.local/src
BIN := $(HOME)/.local/bin
GIT := git@github.com:milisims
SHARE := $(HOME)/.local/share
CONDA := $(SHARE)/miniconda3
CONDA_INSTALLER := $(SHARE)/miniconda3.sh
DOTGIT := $(HOME)/.cfg

# Rules
all: dot conda nvim

dot: $(DOTGIT)
conda: $(CONDA) $(CFG)/fish/conf.d/_conda_setup.fish
nvim: $(BIN)/nvim $(SRC)/nvim-runtime $(CONDA)/envs/nvim-base vimfiles
vimfiles: $(CFG)/nvim $(SHARE)/nvim/lazy

.PHONY: all dot conda nvim vimfiles clean

$(DOTGIT):
	git clone --bare $(GIT)/dotfiles.git $(DOTGIT)
	git config --git-dir=$(DOTGIT) --work-tree=$(HOME) sparse-checkout set .config .local
	git config --git-dir=$(DOTGIT) --work-tree=$(HOME) config status.showUntrackedFiles no
	git config --git-dir=$(DOTGIT) --work-tree=$(HOME) reset HEAD
	git config --git-dir=$(DOTGIT) --work-tree=$(HOME) config filter.ignore_lines.clean "sed '/^# >>> conda initialize >>>$/,/^# <<< conda initialize <<<$/{//!d}; /gitignore$/d'"
	git config --git-dir=$(DOTGIT) --work-tree=$(HOME) config filter.ignore_lines.smudge cat
	if ! git config --get alias.cfg 2>&1 > /dev/null; then \
		git config --global alias.cfg '!git --git-dir=$$HOME/.cfg --work-tree=$$HOME'; \
	fi

$(CONDA): | $(CONDA_INSTALLER)
	bash $(CONDA_INSTALLER) -b -p $(CONDA)
	source $(CONDA)/bin/activate
	conda init bash fish zsh
	conda config --add channels conda-forge

$(CONDA_INSTALLER):
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $@

$(CFG)/fish/conf.d/_conda_setup.fish: | $(CONDA)
	source $(CONDA)/bin/activate
	fish -c ":"  # see conf.d/conda.fish.
	sleep 1

$(BIN)/nvim: | $(SRC)/nvim-runtime
	ln -s $(SRC)/nvim-runtime/bin/AppRun $@

$(CFG)/nvim: | $(DOTGIT)
	git clone $(GIT)/vimfiles.git $@

$(SRC)/nvim-runtime: | $(DOTGIT) $(BIN)/update-nvim
	$(BIN)/update-nvim

$(SHARE)/nvim/lazy: | $(BIN)/nvim $(CFG)/nvim
	$(BIN)/nvim --headless '+Lazy! sync' +qa

$(HOME)/.vim: | $(CFG)/nvim
	ln -s $(CFG)/nvim $@

$(CONDA)/envs/nvim-base: | $(CONDA)
	source $(CONDA)/bin/activate
	conda create -y -n nvim-base python pip ipython pynvim

clean:
	rm -f $(CONDA_INSTALLER)
