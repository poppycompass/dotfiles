#!/bin/sh

echo -en "\e[36m
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! p ppp    oooo   p ppp   p ppp   y    y                  !
! pp   p  o    o  pp   p  pp   p  y    y                  !
! p    p  o    o  p    p  p    p  y    y                  !
! pp   p  o    o  pp   p  pp   p  y   yy                  !
! p ppp   o    o  p ppp   p ppp    yyy y                  !
! p        oooo   p       p            y                  !
! p               p       p       y    y                  !
! p               p       p        yyyy                   !
!  cccc    oooo   m m mm   p ppp    aaaa    ssss    ssss  !
! c    c  o    o  mm m  m  pp   p       a  s    s  s    s !
! c       o    o  m  m  m  p    p   aaaaa   ss      ss    !
! c       o    o  m  m  m  pp   p  a    a     ss      ss  !
! c    c  o    o  m  m  m  p ppp   a   aa  s    s  s    s !
!  cccc    oooo   m  m  m  p        aaa a   ssss    ssss  !
!                          p                              !
!                          p                              !
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
\e[m"
cd $(dirname $0)

# for Ubuntu
if [ `uname -a | grep ubuntu` ] && [ ! -d /bin/zsh ]; then
  sudo apt-get install software-properties-common # for neovim
  sudo apt-get install python-dev python-pip python3-dev python3-pip # for neovim
  sudo add-apt-repository ppa:neovim-ppa/unstable
  sudo apt update
  sudo apt install neovim vim gcc gdb
  sudo apt install zsh git
  if [ $1 == "x" ]; then
    sudo apt install xmobar xmonad
  fi
fi

# for Arch linux
if [ `uname -a | grep arch` ] && [ ! -d /bin/zsh ]; then
  sudo pacman -Sy
  sudo pacman -S git neovim zsh radare2 gdb
  if [ $1 == "x" ]; then
    sudo pacman -S xmonad xmobar
  fi
fi

if [ ! -d ~/.vim/bundle/neobundle.vim ];then
    echo "You don't have Neobundle. Install now..."
    mkdir -p ~/.vim/bundle
    git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
    echo "Install Neobundle done."
fi
if [ ! -d ~/.vim/dein ];then
    echo "You don't have Dein. Install now..."
    git clone https://github.com/Shougo/dein.vim ~/.vim/dein/repos/github.com/Shougo/dein.vim
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

echo "mount /dev/brain! Here we go!"
