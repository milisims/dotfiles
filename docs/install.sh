#!/usr/bin/env bash
set -o pipefail -o noclobber -o nounset

CFG=${XDG_CONFIG_HOME:-"$HOME/.config"}
SRC=$HOME/.local/src
BIN=$HOME/.local/bin
GIT=git@github.com:milisims
PREFIX=${PREFIX:-${XDG_DATA_HOME:-"$HOME/.local/share"}/miniconda3}

function install_dotfiles(){

  # git clone --bare $GIT/dotfiles.git $HOME/.cfg
  git clone --bare $HOME/.config/dotfiles $HOME/.cfg

  function cfg { git --git-dir=$HOME/.cfg --work-tree=$HOME "$@"; }

  cfg sparse-checkout set .config .local
  cfg config status.showUntrackedFiles no
  cfg reset HEAD

  cfg config filter.ignore_lines.clean "sed '/^# >>> conda initialize >>>$/,/^# <<< conda initialize <<<$/{//!d}; /gitignore$/d'"
  cfg config filter.ignore_lines.smudge cat

  if ! git config --get alias.cfg 2>&1 > /dev/null; then
    git config --global alias.cfg '!git --git-dir=$HOME/.cfg --work-tree=$HOME'
  fi
}

function install_conda(){
  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
  # input prefix?
  bash ~/miniconda.sh -b -p $PREFIX
  source $PREFIX/bin/activate
  conda init bash fish zsh
  rm -f $HOME/.config/fish/conf.d/_conda_setup.fish
  fish -c ": && update-conda"

  conda config --add channels conda-forge
}

function install_vimfiles(){
  git clone $GIT/vimfiles.git $CFG/nvim
  ln -s $CFG/nvim $HOME/.vim
  # grep for mia packages I guess or something
  PLUG=$CFG/nvim/mia_plugins
  mkdir -p $PLUG
  for pl in $(grep "\(^\|\{\)\s*'milisims/" $CFG/nvim/lua/plugins/* | sed "s|.*milisims/\(.*\)'.*|\1|"); do
    if [ ! -d $PLUG/$pl ]; then
      git clone $GIT/${pl}.git $PLUG
    fi
  done

  # check for nvim-base
  if ! conda env list | grep -q '^nvim-base'; then
    conda create -y -n nvim-base python pip ipython pynvim
  fi
}

[ -d $HOME/.cfg ]        || install_dotfiles
# [ -d $PREFIX ]           || install_conda
# [ -d $SRC/nvim-runtime ] || bash $BIN/update-nvim
# [ -d $CFG/nvim ]         || install_vimfiles
