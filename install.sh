#!/bin/bash

install_dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $install_dir
[ -z "$XDG_CONFIG_HOME" ] && XDG_CONFIG_HOME="${HOME}/.config"

function install_zsh_syntax_highlighting() {
  echo 'Installing zsh-syntax-highlighting... '
  local zsh_git_dir="$XDG_CONFIG_HOME/zsh/zsh-syntax-highlighting"
  local zsh_git_repo='https://github.com/zsh-users/zsh-syntax-highlighting.git'

  [ -d $zsh_git_dir ] && rm -rf $zsh_git_dir
  git clone --depth 1 $zsh_git_repo $zsh_git_dir > /dev/null 2>&1
  echo "########"
  echo
}

function install_fzf() {
  echo 'Installing fzf... '
  local fzf_git_dir="$HOME/local/src/fzf"
  local fzf_git_repo='https://github.com/junegunn/fzf.git'

  if [ -d $fzf_git_dir ]; then
    cd $fzf_git_dir
    git pull --update-shallow
    cd $install_dir
  else
    git clone --depth 1 $fzf_git_repo $fzf_git_dir
  fi
  $fzf_git_dir/install --bin
  mkdir -p $HOME/local/bin/
  ln -s $fzf_git_dir/bin/* $HOME/local/bin/
  echo "########"
  echo
}

# TODO: execute and log to file, remove if exit 0, quit and report if nonzero
function install_tmux() {
  echo 'Installing tmux... '
  local tmux_src_dir="$HOME/local/src"
  local tmux_libs_dir="$HOME/local/src/tmux-libs"
  mkdir -p $tmux_libs_dir

  if [[ ! -f $HOME/local/lib/libevent.a ]]; then
    cd $tmux_libs_dir
    local libevent_file='libevent-2.1.8-stable.tar.gz'
    local libevent_url='https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz'

    if [[ ! -f $libevent_file ]]; then
      wget -O $libevent_file $libevent_url
    fi
    tar xvzf $libevent_file
    cd libevent-2.1.8-stable
    ./configure --prefix=$HOME/local --disable-shared
    make
    make install
    cd $install_dir
  fi

  if [[ ! -f $HOME/local/lib/libncurses.a ]]; then
    cd $tmux_libs_dir
    local ncurses_file='ncurses-6.1.tar.gz'
    local ncurses_url='ftp://ftp.gnu.org/gnu/ncurses/ncurses-6.1.tar.gz'
    if [[ ! -f "$ncurses_file" ]]; then
      wget -O $ncurses_file $ncurses_url
    fi
    tar xvzf $ncurses_file
    cd ncurses-6.1
    ./configure --prefix=$HOME/local CPPFLAGS="-P"
    make
    make install
    cd $install_dir
  fi

  cd $tmux_src_dir
  local tmux_file='tmux-2.7.tar.gz'
  local tmux_url='https://github.com/tmux/tmux/releases/download/2.7/tmux-2.7.tar.gz'
  if [[ ! -f "$tmux_file" ]]; then
    wget -O $tmux_file $tmux_url
  fi
  tar xvzf $tmux_file
  cd tmux-2.7
  ./configure CFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-L$HOME/local/lib -L$HOME/local/include/ncurses -L$HOME/local/include"
  CPPFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-static -L$HOME/local/include -L$HOME/local/include/ncurses -L$HOME/local/lib" make
  make
  # make install
  mkdir -p $HOME/local/bin/
  cp tmux $HOME/local/bin
  cd $install_dir

  echo "########"
  echo
}

function install_ctags() {
  echo 'Installing ctags... '
  local ctags_git_dir="$HOME/local/src/ctags"
  local ctags_git_repo='https://github.com/universal-ctags/ctags.git'


  if [ -d $ctags_git_dir ]; then
    cd $ctags_git_dir
    git pull --update-shallow
  else
    git clone --depth 1 $ctags_git_repo $ctags_git_dir
    cd $ctags_git_dir
  fi

  ./autogen.sh
  ./configure --prefix="$HOME/local"
  make
  make install
  echo "########"
  echo
}

function install_vim_settings() {
  rm_broken_links $XDG_CONFIG_HOME
  [ -L $HOME/.vim ] && rm $HOME/.vim
  ln -sf $install_dir/vim $HOME/.vim
  [ -L $XDG_CONFIG_HOME/nvim ] && rm $XDG_CONFIG_HOME/nvim
  ln -sf $install_dir/vim $XDG_CONFIG_HOME/nvim
  for d in backup swap undo view; do
    mkdir -p $HOME/.local/share/vim/tmp/$d
  done
}

function rm_broken_links {
  find $1/* -prune -type l ! -exec test -e {} \; -exec rm {} +
}

function main() {
  # ZSH Settings
  echo "Linking dotfiles and setting up zsh... "
  rm_broken_links $HOME
  rm_broken_links $XDG_CONFIG_HOME
  for dotfile in alias bashrc gitconfig gvimrc pylintrc pythonrc scripts zshrc tmux.conf; do
    rm $HOME/.$dotfile 2> /dev/null
    ln -s $install_dir/dot/$dotfile $HOME/.$dotfile
  done


  mkdir -p $XDG_CONFIG_HOME/zsh
  rm_broken_links $XDG_CONFIG_HOME/zsh
  ln -sf $install_dir/zsh/* $XDG_CONFIG_HOME/zsh

  echo "Done"

  install_zsh_syntax_highlighting
  [ ! -f $HOME/local/bin/fzf ] && install_fzf
  [ ! -f $HOME/local/bin/tmux ] && install_tmux
  [ ! -f $HOME/local/bin/ctags ] && install_ctags

  echo "Installing vim and neovim settings... "
  install_vim_settings
  echo "Done"

  # vim plugins
  git submodule update --init --recursive > /dev/null 2>&1
  nvim +'doautocmd User DeferVimPack' +UpdateRemotePlugins +qa
}

main
