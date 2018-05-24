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
rm_broken_links $cfgdir
for dotfile in alias bashrc gitconfig gvimrc pylintrc pythonrc scripts zshrc; do
  rm $HOME/.$dotfile 2> /dev/null
  ln -s $install_dir/dot/$dotfile $HOME/.$dotfile
done


[ -z "$XDG_CONFIG_HOME" ] && XDG_CONFIG_HOME="${HOME}/.config"
[ -f "${XDG_CONFIG_HOME}/nvim/init.vim" ] && rm "${XDG_CONFIG_HOME}/nvim/init.vim"
[ -f "${HOME}/.vimrc" ] && rm "${HOME}/.vimrc"

mkdir -p ${cfgdir}/nvim
sed "s|MYCFGDIR|${install_dir}/vim|" templates/vimrc > ${HOME}/.vimrc
sed "s|MYCFGDIR|${install_dir}/vim|" templates/init.vim > ${XDG_CONFIG_HOME}/nvim/init.vim

mkdir -p $cfgdir/zsh
rm_broken_links $cfgdir/zsh
ln -sf $install_dir/zsh/* $cfgdir/zsh

echo "Done"

# zsh-syntax-highlighting install
echo -n 'Installing zsh-syntax-highlighting... '
zsh_git_dir="$cfgdir/zsh/zsh-syntax-highlighting"
zsh_git_repo='https://github.com/zsh-users/zsh-syntax-highlighting.git'

[ -d $zsh_git_dir ] && rm -rf $zsh_git_dir
git clone --depth 1 $zsh_git_repo $zsh_git_dir > /dev/null 2>&1
MSG="Done"
[ "$?" -ne 0 ] && MSG="FAILED "  # to install zsh-syntax-highlighting
echo $MSG
echo

# fzf install
echo -n 'Installing fzf... '
fzf_git_dir="$HOME/.fzf"
fzf_git_repo='https://github.com/junegunn/fzf.git'

[ -d $fzf_git_dir ] && rm -rf $fzf_git_dir
git clone --depth 1 $fzf_git_repo $fzf_git_dir > /dev/null 2>&1
$fzf_git_dir/install --key-bindings --completion --no-update-rc > /dev/null 2>&1
MSG="Done"
[ "$?" -ne 0 ] && MSG="FAILED "  # to install fzf
echo $MSG
echo

# VIM Settings
echo -n "Installing vim and neovim settings... "

rm_broken_links $cfgdir
[ -L $cfgdir/vim ] && rm $cfgdir/vim
[ -L $cfgdir/nvim ] && rm $cfgdir/nvim
ln -sf $install_dir/vim $cfgdir
ln -sf $install_dir/vim $cfgdir/nvim
# ln -sf $install_dir/vim/vimrc $HOME/.vimrc
for d in backup swap undo view; do
  mkdir -p $HOME/.local/share/vim/tmp/$d
done
echo "Done"

# vim plugins
git submodule update --init --recursive > /dev/null 2>&1
nvim +'doautocmd User DeferVimPack' +UpdateRemotePlugins +qa
