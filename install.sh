#!/bin/bash

install_dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $install_dir
cfgdir="$HOME/.config"

function rm_broken_links {
    find $1/* -prune -type l ! -exec test -e {} \; -exec rm {} +
}

# ZSH Settings
echo -n "Linking dotfiles and setting up zsh... "
rm_broken_links $HOME
for dotfile in $(ls dot); do
    rm $HOME/.$dotfile 2> /dev/null
    ln -s $install_dir/dot/$dotfile $HOME/.$dotfile
done
echo "Done"

mkdir -p $cfgdir/zsh
rm_broken_links $cfgdir/zsh
ln -sf $install_dir/zsh/* $cfgdir/zsh

echo -n 'Installing zsh-syntax-highlighting... '
zsh_git_dir="$cfgdir/zsh/zsh-syntax-highlighting"
zsh_git_repo='https://github.com/zsh-users/zsh-syntax-highlighting.git'

[ -d $zsh_git_dir ] && rm -rf $zsh_git_dir

git clone $zsh_git_repo $zsh_git_dir > /dev/null 2>&1
MSG="Done"
[ "$?" -ne 0 ] && MSG="FAILED "  # to install zsh-syntax-highlighting
echo $MSG
echo

# VIM Settings
echo -n "Installing vim and neovim settings... "
mkdir -p $cfgdir/nvim
rm_broken_links $cfgdir/nvim
ln -sf $install_dir/vim/init.vim $cfgdir/nvim

mkdir -p $cfgdir/vim
rm_broken_links $cfgdir/vim
ln -sf $install_dir/vim/* $cfgdir/vim
ln -sf $install_dir/vim/vimrc $HOME/.vimrc
mkdir -p $HOME/.local/share/vim/view
mkdir -p $HOME/.local/share/vim/swap

echo "Done"

vimaudir="$cfgdir/vim/autoload"
echo -n "Installing plug-vim to $vimaudir... "
plugurl='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

tmpout=$(mktemp)
curl -fLo $vimaudir/plug.vim --silent --create-dirs $plugurl
if [ "$?" -eq 0 ]; then
  echo "Done"
  echo -n "Installing and updating vim plugins..."
  vim +'PlugInstall --sync' +'PlugUpdate' +qa
  echo "Done"
  if command -v nvim > /dev/null 2>&1; then
    echo -n "Installing and updating nvim plugins..."
    nvim +'PlugInstall --sync' +'PlugUpdate' +qa
    echo "Done"
  fi
else
  echo "FAILED"  # to install plug-vim
fi
