#!/usr/bin/env bash
repo="git@github.com:LeafJay/DripFiles.git"
git clone --bare "$repo"
$HOME/.dotfiles

# define config alias locally since the dotfiles
# aren't installed on the system yet
function dotfiles {
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

mkdir -p .dotfiles-backup
dotfiles checkout
if [ $? = 0 ]; then
    echo "Checked out dotfiles from git@github.com:mrjones2014/dotfiles.git";
else
    echo "Moving existing dotfiles to ~/.dotfiles-backup";
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi
dotfiles checkout
dotfiles config status.showUntrackedFiles no
