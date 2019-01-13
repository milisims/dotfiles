#!/usr/bin/env bash
set -o errexit -o errtrace -o pipefail -o noclobber -o nounset
IFS=$'\n\t'

install_dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $install_dir
CONF_HOME=${XDG_CONFIG_HOME:-${HOME}/.config}
logfile=$install_dir/install.log

bindir=$HOME/local/bin
srcdir=$HOME/local/src

function install_zsh_syntax_highlighting() {
  local zsh_git_dir="$CONF_HOME/zsh/zsh-syntax-highlighting"
  [ -d $zsh_git_dir ] && rm -rf $zsh_git_dir
  if [ $op_uninstall -eq 1 ]; then
    echo Uninstalled zsh_syntax_highlighting
    return 0
  fi

  echo 'Installing zsh-syntax-highlighting... '
  local zsh_git_repo='https://github.com/zsh-users/zsh-syntax-highlighting.git'

  git clone --depth 1 $zsh_git_repo $zsh_git_dir 2>&1
  echo "########"
  echo
}

function install_coc() {
  if [ $op_uninstall -eq 1 ]; then
    rm -rf $HOME/.yarn
    rm -rf $HOME/local/{lib/node{,/.npm,_modules},bin,share/man}/npm*
    echo Uninstalled yarn and node
    return 0
  fi

  # Yarn is stupid and modifies my zshrc/bashrc.
  if [ ! -d $HOME/.yarn ]; then
    echo 'Installing yarn... '
    cp $install_dir/dot/zshrc $install_dir/dot/zshrc.bak
    cp $install_dir/dot/bashrc $install_dir/dot/bashrc.bak
    curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
    mv -f $install_dir/dot/zshrc.bak $install_dir/dot/zshrc
    mv -f $install_dir/dot/bashrc.bak $install_dir/dot/bashrc
    echo "########"
    echo
  fi
  if [ ! command -v npm > /dev/null 2>&1 ]; then
    echo 'Installing node... '
    curl -Ls install-node.now.sh | sh -s -- --prefix=$HOME/local
    echo "########"
    echo
  fi
  nvim --noplugin +'packadd coc.nvim' +'call coc#util#install()' +qa
}

function install_neovim() {
  # Cleanup previous install
  [ -f $bindir/nvim ] && rm $bindir/nvim
  [ -f $bindir/nvim.appimage ] && rm $bindir/nvim.appimage
  [ -f $srcdir/squashfs-root-nvim ] && rm -r $srcdir/squashfs-root-nvim
  [ $op_uninstall -eq 1 ] && echo 'Uninstalled neovim'
  [ $op_uninstall -eq 1 ] && return 0

  echo 'Installing neovim... '
  # get exe, test if appimage can open, otherwise extract.
  nvim_file='nvim.appimage'
  nvim_url='https://github.com/neovim/neovim/releases/download/v0.3.3/nvim.appimage'
  wget -O $nvim_file $nvim_url
  chmod 755 $nvim_file
  # if it doesn't execute, extract the file
  mkdir -p $bindir
  if ! ./$nvim_file --noplugin -u NONE +q > /dev/null 2>&1; then
    [ -f squashfs-root ] && rm -rfI squashfs-root
    ./$nvim_file --appimage-extract
    mv squashfs-root $srcdir/squashfs-root-nvim
    ln -s $srcdir/squashfs-root-nvim/usr/bin/nvim $bindir/nvim
  else  # if it does, just plop it in the bin dir
    mv $nvim_file $bindir/$nvim_file
    ln -s $bindir/$nvim_file $bindir/nvim
  fi

}

function install_python_via_conda() {
  local ext=$(lscpu | grep 'CPU op-mode' | grep -q 64-bit && echo '_64.sh' || echo '.sh')
  local url=https://repo.anaconda.com/miniconda/Miniconda3-4.5.12-Linux-x86$ext
  local fname=Miniconda3-4.5.12-Linux-x86$ext
  wget $url -O $fname
  bash $fname
  source deactivate
  conda install python pip
  pip install --upgrade pip
  pip install --upgrade pynvim
  rm $fname
}

function install_fzf() {
  local fzf_git_dir="$srcdir/fzf"
  if [ $op_uninstall -eq 1 ]; then
    [ command -v fzf > /dev/null 2>&1 ] || return 0
    for f in $fzf_git_dir/bin/*; do
      rm $bindir/$(basename $f) $f
    done
    rm -rf $fzf_git_dir
    echo Uninstalled fzf
    return 0
  fi

  echo 'Installing fzf... '
  local fzf_git_dir="$srcdir/fzf"
  local fzf_git_repo='https://github.com/junegunn/fzf.git'

  if [ -d $fzf_git_dir ]; then
    cd $fzf_git_dir
    git pull --update-shallow
    cd $install_dir
  else
    git clone --depth 1 $fzf_git_repo $fzf_git_dir
  fi
  $fzf_git_dir/install --bin
  mkdir -p $bindir
  ln -sf $fzf_git_dir/bin/* $bindir
  echo "########"
  echo
}

function install_tmux() {
  local tmux_src_dir="$srcdir"
  local tmux_libs_dir="$srcdir/tmux-libs"
  if [ $op_uninstall -eq 1 ]; then
    rm -rf $tmux_src_dir $tmux_libs_dir $bindir/tmux
    echo Uninstalled tmux
    return 0
  fi

  echo 'Installing tmux... '
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
  mkdir -p $bindir
  cp tmux $bindir
  cd $install_dir

  echo "########"
  echo
}

function install_ctags() {
  local ctags_git_dir="$srcdir/ctags"
  if [ $op_uninstall -eq 1 ]; then
    echo Uninstalled ctags
    [ -f $bindir/ctags ] && rm $bindir/ctags
    [ ! -d $ctags_git_dir ] && return 0
    cd $ctags_git_dir
    make uninstall
    cd $install_dir
    return 0
  fi

  echo 'Installing ctags... '
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
  cd $install_dir
  echo "########"
  echo
}

function install_vim_settings() {
  [ -e $HOME/.vim ] && rm $HOME/.vim
  if [ $op_uninstall -eq 1 ]; then
    for d in backup swap undo view; do
      rm -rf $HOME/.local/share/vim/tmp/$d
    done
    install_coc
    # rm -r $install_dir/vim
    echo Uninstalled vim settings
    return 0
  fi

  echo "Installing vim and neovim settings... "
  rm_broken_links $CONF_HOME
  for d in backup swap undo view; do
    mkdir -p $HOME/.local/share/vim/tmp/$d
  done

  # install minpac, tell it to update plugins
  local vimdir=$install_dir/vim
  if [ -d $vimdir ]; then
    cd $vimdir
    git pull
    cd $install_dir
  else
    git clone git@github.com:matthsims/vimfiles.git $vimdir
  fi
  ln -sf $vimdir $HOME/.vim
  local minpac_dir="$HOME/.vim/pack/minpac/opt/minpac"
  local minpac_url="https://github.com/k-takata/minpac.git"
  if [ ! -d $minpac_dir/.git ]; then
    mkdir -p $minpac_dir
    rm -rI $minpac_dir
    git clone $minpac_url $minpac_dir
  fi
  [ command -v nvim > /dev/null 2>&1 ] && nvim +'PackUpdate' +UpdateRemotePlugins
  install_coc
  echo "Done"
}

function install_sh_settings() {
  files=(alias profile bashrc gitconfig pylintrc pythonrc scripts zshrc tmux.conf)
  rm_broken_links $HOME
  rm_broken_links $CONF_HOME
  if [ $op_uninstall -eq 1 ]; then
    for dotfile in ${files[@]}; do
      [ -e $HOME/.$dotfile ] && rm $HOME/.$dotfile
    done
    for cfgfile in nvim kitty; do
      [ -e $CONF_HOME/$cfgfile ] && rm $CONF_HOME/$cfgfile
    done
    echo Uninstalled shell settings
    return 0
  fi

  # ZSH Settings
  echo "Linking dotfiles and setting up zsh... "
  for dotfile in ${files[@]}; do
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

function rm_broken_links() {
  for f in $1/*; do
    find $f -prune -type l ! -exec test -e {} \; -exec rm {} +
  done
}

function print_status() {
  command -v nvim
  command -v tmux
  command -v ctags
  ls -dl $HOME/.vim
  ls -dl $HOME/.bashrc
  ls -dl $CONF_HOME/zsh/zsh-syntax-highlighting
}

function print_help() {
  echo 'Usage:'
  echo '  install.sh [options]'
  echo
  echo 'Options:'
  echo '  -s   print installed software status'
  echo '  -u   uninstall flag -- before any other options'
  echo
  echo '(Un)install:'
  echo '  -a   all'
  echo '  -c   ctags'
  echo '  -f   fzf'
  echo '  -n   neovim'
  echo '  -p   python'
  echo '  -t   tmux'
  echo '  -z   zsh syntax highlighting'
  echo '  -e   sh and vim settings (default)'
  echo '  Note: any install option other than -ane will skip sh/vim settings.'
}

function parse_args() {
  op_uninstall=0
  op_zsh_syn_hl=0
  op_fzf=0
  op_tmux=0
  op_ctags=0
  op_neovim=0
  op_python=0
  op_settings=1
  # local OPTIND
  while getopts hsuztcnpfea name; do
    case $name in
      h) print_help;     exit 0;;
      s) print_status;   exit 0;;
      u) op_uninstall=1;    op_settings=0;;
      z) op_zsh_syn_hl=1;   op_settings=0;;
      f) op_fzf=1;          op_settings=0;;
      t) op_tmux=1;         op_settings=0;;
      c) op_ctags=1;        op_settings=0;;
      n) op_neovim=1;       op_settings=0;;
      n) op_python=1;       op_settings=0;;
      e) op_settings=1;;
      a) op_zsh_syn_hl=1 op_fzf=1 op_tmux=1 op_ctags=1 op_neovim=1 op_python=1 op_settings=1;;
    esac
  done
}

function main() {
  parse_args $@

  [ $op_neovim -eq 1 ]     && install_neovim                  | tee $logfile
  [ $op_settings -eq 1 ]   && install_sh_settings             | tee $logfile
  if [ $op_settings -eq 1 ] || [ $op_neovim -eq 1 ]; then
    install_vim_settings                                      | tee $logfile
  fi
  [ $op_fzf -eq 1 ]        && install_fzf                     | tee $logfile
  [ $op_tmux -eq 1 ]       && install_tmux                    | tee $logfile
  [ $op_ctags -eq 1 ]      && install_ctags                   | tee $logfile
  [ $op_python -eq 1 ]     && install_python_via_conda        | tee $logfile
  [ $op_zsh_syn_hl -eq 1 ] && install_zsh_syntax_highlighting | tee $logfile
}

main $@
rm -f $logfile
