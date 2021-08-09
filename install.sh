#!/usr/bin/env bash
set -o errexit -o pipefail -o noclobber -o nounset

git clone --bare git@github.com:milisims/dotfiles.git ~/.cfg
function config {
  git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

echo '/*
!LICENSE.txt
!README.md
!install.sh
!windows' > ~/.cfg/info/sparse-checkout

config config core.sparseCheckout true
config config status.showUntrackedFiles no
config read-tree -mu HEAD # This might need to be moved

set +o errexit
config checkout

if [ $? = 0 ]; then
  echo "Checked out config."
else
  echo "Backing up pre-existing dot files."
  for f in $(config checkout 2>&1 | egrep "\s+\." | awk {'print $1'}); do
    mkdir -p .config-backup/$(dirname $f)
    mv $f .config-backup/$f
  done
  config checkout
  echo "Checked out config."
fi

git clone git@github.com:milisims/vimfiles.git ~/.vim
git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
echo 'Execute "nvim +PackUpdate" to update vim packages if nvim is installed.'
