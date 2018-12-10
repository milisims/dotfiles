#!/usr/bin/env bash
set -o errexit -o errtrace -o pipefail -o noclobber -o nounset
IFS=$'\n\t'

install_dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $install_dir
CONF_HOME=${XDG_CONFIG_HOME:-${HOME}/.config}
logfile=$(mktemp)
trap "cp -f $logfile $install_dir/install.log" ERR

function install_zsh_syntax_highlighting() {
  echo 'Installing zsh-syntax-highlighting... '
  local zsh_git_dir="$CONF_HOME/zsh/zsh-syntax-highlighting"
  local zsh_git_repo='https://github.com/zsh-users/zsh-syntax-highlighting.git'

  [ -d $zsh_git_dir ] && rm -rf $zsh_git_dir
  git clone --depth 1 $zsh_git_repo $zsh_git_dir 2>&1
  echo "########"
  echo
}

function install_yarn() {
  echo 'Installing yarn... '
  curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
  echo "########"
  echo
}

function install_node() {
  echo 'Installing node... '
  curl -Ls install-node.now.sh | sh -s -- --prefix=$HOME/local
  echo "########"
  echo
}

function install_coc() {
  install_yarn
  install_node
  nvim --noplugin +'packadd coc.nvim' +'call coc#util#install()' +qa
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
  ln -sf $fzf_git_dir/bin/* $HOME/local/bin/
  echo "########"
  echo
}

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
  echo "Installing vim and neovim settings... "
  rm_broken_links $CONF_HOME
  for d in backup swap undo view; do
    mkdir -p $HOME/.local/share/vim/tmp/$d
  done

  # vim plugins
  git submodule update --init --recursive 2>&1
  nvim +'doautocmd User DeferVimPack' +UpdateRemotePlugins +qa
  echo "Done"
}

function install_sh_settings() {
  # ZSH Settings
  echo "Linking dotfiles and setting up zsh... "
  rm_broken_links $HOME
  rm_broken_links $CONF_HOME
  for dotfile in alias profile bashrc gitconfig gvimrc vim pylintrc pythonrc scripts zshrc tmux.conf; do
    [ -e $HOME/.$dotfile ] && rm $HOME/.$dotfile
    ln -s $install_dir/dot/$dotfile $HOME/.$dotfile
  done

  for cfgfile in nvim kitty; do  # glob expands with config in front
    [ -e $CONF_HOME/$cfgfile ] && rm $CONF_HOME/$cfgfile
    ln -s $install_dir/config/$cfgfile $CONF_HOME/$cfgfile
  done

  mkdir -p $CONF_HOME/zsh
  rm_broken_links $CONF_HOME/zsh
  ln -sf $install_dir/zsh/* $CONF_HOME/zsh

  echo "Done"
}

function rm_broken_links {
  for f in $1/*; do
    find $f -prune -type l ! -exec test -e {} \; -exec rm {} +
  done
}

function print_status() {
  echo NYI
}

function print_help() {
  echo 'Usage:'
  echo '  install.sh [options]'
  echo
  echo 'Options:'
  echo '  -s   print installed software status'
  echo
  echo '  -a   install all'
  echo '  -c   install ctags'
  echo '  -f   install fzf'
  echo '  -n   install neovim'
  echo '  -t   install tmux'
  echo '  -z   install zsh'
}

function parse_args() {
  zsh_syn_hl=0 install_tmux=0 install_ctags=0 install_neovim=0 install_fzf=0
  local OPTIND
  while getopts hsztcnfa name; do
    case $name in
      h) print_help;  exit 0;;
      s) print_status;    exit 0;;
      z) zsh_syn_hl=1;;
      t) install_tmux=1;;
      c) install_ctags=1;;
      n) install_neovim=1;;
      f) install_fzf=1;;
      a) zsh_syn_hl=1 install_tmux=1 install_ctags=1 install_neovim=1 install_fzf=1;;
    esac
  done
}

function main() {
  parse_args $@

  install_sh_settings >> $logfile 2>&1
  install_vim_settings >> $logfile 2>&1
  [ $install_ctags -eq 1 ] && install_ctags >> $logfile 2>&1
  [ $install_fzf -eq 1 ] && install_fzf >> $logfile 2>&1
  [ $install_tmux -eq 1 ] && install_tmux >> $logfile 2>&1
  [ $zsh_syn_hl -eq 1 ] && install_zsh_syntax_highlighting >> $logfile 2>&1
}

main $@

rm -f $logfile
