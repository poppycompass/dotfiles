#!/bin/sh

cd $(dirname $0)
if [ ! -d ~/.vim/bundle/neobundle.vim ];then
    echo "You don't have Neobundle. Install now..."
    mkdir -p ~/.vim/bundle
    git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
    echo "Install Neobundle done."
fi
if [ ! -d ~/.cache/dein ];then
    echo "You don't have Dein. Install now..."
    mkdir ~/.cache
    git clone https://github.com/Shougo/dein.vim ~/.cache/dein/repos/github.com/Shougo/dein.vim
    echo "Install Dein done."
fi

if [ ! -d ~/.xmonad ];then
    echo "preparing xmonad..."
    mkdir ~/.xmonad
    echo "done"
fi

for file in .?*
do
    if [ $file != '..' ] && [ $file != '.Xmodmap' ] && [ $file != '.git' ]; then
        ln -sf $HOME/dotfiles/$file $HOME
    fi
done

ln -sf ~/dotfiles/colors ~/.vim/
ln -sf ~/dotfiles/userautoload ~/.vim/
ln -sf ~/.vim ~/dotfiles/nvim
ln -sf ~/dotfiles/.vimrc ~/dotfiles/nvim/init.vim
ln -sf ~/dotfiles/xmonad.hs ~/.xmonad/xmonad.hs
chsh -s /bin/zsh

echo "All done!"
