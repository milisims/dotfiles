# for conda
SHELL=/bin/bash

# Variables
GIT := git@github.com:milisims
SSH := $(HOME)/.ssh
CFG := $(HOME)/.config
SRC := $(HOME)/.local/src
BIN := $(HOME)/.local/bin
SHARE := $(HOME)/.local/share
CONDA := $(SHARE)/miniconda3
CONDA_INSTALLER := $(SHARE)/miniconda3.sh
DOTCFG := $(HOME)/.cfg
LOCAL := $(BIN)/update-nvim  # sentinel for checked out right

CRED=\033[0;31m
CGRN=\033[0;32m
CYLW=\033[0;33m
CGREY=\033[1;30m
CEND=\033[0m\n

# Targets
all: dot conda nvim

dot: | $(LOCAL) $(SSH)
config: | $(LOCAL) $(SHARE)/fonts/SymbolsNerdFontMono-Regular.ttf
conda: | $(CONDA) $(CFG)/fish/conf.d/_conda_setup.fish
nvim: | $(BIN)/nvim $(SRC)/nvim-runtime $(CONDA)/envs/nvim-base vimfiles
vimfiles: | $(CFG)/nvim $(SHARE)/nvim/lazy

.PHONY: all dot config conda nvim vimfiles

# Rules
$(SSH): | $(SSH)/id_rsa.pub
  # todo?

$(SSH)/id_rsa.pub:
	@echo -e "$(CYLW)"
	ssh-keygen -t rsa -q -N "" -f $(HOME)/.ssh/id_rsa

$(DOTCFG):
	@echo -e "$(CYLW)> Cloning config$(CGREY)"
	git clone --bare $(GIT)/dotfiles.git $(DOTCFG)
	git config --global alias.cfg '!git --git-dir=$$HOME/.cfg --work-tree=$$HOME'
	@echo -e "$(CGRN)== Cloned config$(CEND)"

$(LOCAL): | $(DOTCFG)
	@echo -e "$(CYLW)> Installing dotfiles$(CGREY)"
	git cfg sparse-checkout set --cone .config .local
	git cfg config status.showUntrackedFiles no
	@git cfg reset -q HEAD
	@git cfg restore .
	fish -c 'set_my_colors'
	git cfg status
	git cfg config filter.ignore_lines.clean "sed '/^# >>> conda initialize >>>$$/,/^# <<< conda initialize <<<$$/{//!d}; /gitignore$$/d'"
	git cfg config filter.ignore_lines.smudge cat
	@echo -e "$(CGRN)== Installed dotfiles$(CEND)"

$(SHARE)/fonts/SymbolsNerdFontMono-Regular.ttf:
	@echo -e "$(CYLW)> Installing font symbols$(CGREY)"
	mkdir -p $(SHARE)/fonts
	wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.tar.xz -O $(SHARE)/fonts/NerdFontsSymbolsOnly.tar.xz
	tar -C $(SHARE)/fonts -xvJf $(SHARE)/fonts/NerdFontsSymbolsOnly.tar.xz --wildcards '*.ttf'
	rm $(SHARE)/fonts/NerdFontsSymbolsOnly.tar.xz
	@echo -e "$(CGRN)== Installed font symbols$(CEND)"

$(CONDA): | $(CONDA_INSTALLER)
	@echo -e "$(CYLW)> Installing conda$(CGREY)"
	bash $(CONDA_INSTALLER) -b -p $(CONDA)
	source $(CONDA)/bin/activate && \
	conda init bash fish zsh && \
	conda config --add channels conda-forge
	@echo -e "$(CGRN)== Installed conda$(CEND)"

$(CONDA_INSTALLER):
	@echo -e "$(CYLW)> Fetching miniconda$(CGREY)"
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $@

$(CFG)/fish/conf.d/_conda_setup.fish: | $(CONDA)
	@echo -e "$(CYLW)> Setting up conda in fish$(CGREY)"
	source $(CONDA)/bin/activate
	fish -c ":"  # updates the conda setup
	sleep 1
	@echo -e "$(CGRN)== Set up fish conda$(CEND)"

$(BIN)/nvim: | $(SRC)/nvim-runtime
	@echo -e "$(CYLW)"
	ln -s $(SRC)/nvim-runtime/bin/AppRun $@

$(CFG)/nvim: | $(DOTGIT)
	@echo -e "$(CYLW)> Cloning vimfiles$(CGREY)"
	git clone $(GIT)/vimfiles.git $@
	@echo -e "$(CGRN)== Cloned vimfiles$(CEND)"

$(SRC)/nvim-runtime: | $(DOTGIT) $(LOCAL)
	@echo -e "$(CYLW)> Installing neovim$(CGREY)"
	$(BIN)/update-nvim
	@echo -e "$(CGRN)== Installed nvim$(CEND)"

$(SHARE)/nvim/lazy: | $(BIN)/nvim $(CFG)/nvim
	@echo -e "$(CYLW)> Installing nvim plugins$(CGREY)"
	$(BIN)/nvim --headless '+Lazy! sync' +qa
	@echo -e "$(CGRN)== Installed nvim plugins$(CEND)"

$(HOME)/.vim: | $(CFG)/nvim
	@echo -e "$(CYLW)"
	ln -s $(CFG)/nvim $@

$(CONDA)/envs/nvim-base: | $(CONDA)
	@echo -e "$(CYLW)> Setting up nvim-base conda environment$(CGREY)"
	source $(CONDA)/bin/activate && \
	conda create -y -n nvim-base python pip ipython pynvim
	@echo -e "$(CGRN)== Set up nvim-base environment$(CEND)"

# Cleaning
clean-install:
	@echo -e "$(CRED)"
	rm -f $(HOME)/makefile $(CONDA_INSTALLER)

# not install
clean-all: clean-cfg clean-conda clean-vimfiles clean-fonts

clean-cfg:
	@echo -e "$(CRED)"
	git cfg stash -q
	git cfg sparse-checkout set --no-cone
	echo '!*' > $(DOTCFG)/info/sparse-checkout
	git cfg sparse-checkout reapply

clean-conda:
	@echo -e "$(CRED)"
	rm -rf $(CONDA)
	rm -rf $(HOME)/.conda{rc,}

clean-vimfiles:
	@echo -e "$(CRED)"
	rm -rf $(CFG)/nvim $(SHARE)/nvim

clean-fonts:
	@echo -e "$(CRED)"
	rm -f $(SHARE)/fonts/SymbolsNerdFont-Regular.ttf
	rm -f $(SHARE)/fonts/SymbolsNerdFontMono-Regular.ttf

.PHONY: clean-install clean-all clean-cfg clean-conda clean-vimfiles clean-fonts
