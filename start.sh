#!/bin/sh

# http://patorjk.com/software/taag/#p=display&f=Blocks&t=poppycompass, font: Blocks, Doh, Doom, Ogre, Slant, Larry 3D is good, now is Slant, 
/bin/echo -e "\e[36;1;7m
______                                                                                   ______
\ \ \ \     ____  ____  ____  ____  __  ___________  ____ ___  ____  ____ ___________   / / / /
 \ \ \ \   / __ \/ __ \/ __ \/ __ \/ / / / ___/ __ \/ __ \`__ \/ __ \/ __ \`/ ___/ ___/  / / / / 
 / / / /  / /_/ / /_/ / /_/ / /_/ / /_/ / /__/ /_/ / / / / / / /_/ / /_/ (__  |__  )   \ \ \ \ 
/_/_/_/  / .___/\____/ .___/ .___/\__, /\___/\____/_/ /_/ /_/ .___/\__,_/____/____/     \_\_\_\\
        /_/         /_/   /_/    /____/                    /_/                                 
\e[m\n\n"
cd $(dirname $0)

# for Ubuntu
if uname -a | grep Ubuntu >/dev/null && [ ! -d /bin/zsh ]; then
  sudo apt-get -y install software-properties-common # for neovim
  sudo apt-get -y install python-dev python-pip python3-dev python3-pip # for neovim
  sudo add-apt-repository -y ppa:neovim-ppa/unstable
  sudo apt-get -y update
  sudo apt-get -y install neovim vim gcc gdb
  sudo apt-get -y install zsh git
  if [ "$1" = "x" ]; then
    sudo apt-get -y install xmobar xmonad rxvt-unicode-256color
  fi
fi

# for Arch linux
if uname -a | grep ARCH >/dev/null && [ ! -d /bin/zsh ]; then
  sudo pacman -Sy
  sudo pacman -S git neovim zsh radare2 gdb
  if [ "$1" = "x" ]; then
    sudo pacman -S xmonad xmobar rxvt-unicode
  fi
fi

# for Mac
if uname -a | grep "Darwin Kernel" >/dev/null && [ ! -d /bin/zsh ]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install neovim/neovim/neovim
  brew install zsh git binutils gdb
fi

if [ ! -d ~/.vim/bundle/neobundle.vim ]; then
    echo "You don't have Neobundle. Install now..."
    mkdir -p ~/.vim/bundle
    git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
    echo "Install Neobundle done."
fi
if [ ! -d ~/.vim/dein ]; then
    echo "You don't have Dein. Install now..."
    git clone https://github.com/Shougo/dein.vim ~/.vim/dein/repos/github.com/Shougo/dein.vim
    echo "Install Dein done."
fi

if [ ! -d ~/.xmonad ]; then
    echo "preparing xmonad..."
    mkdir ~/.xmonad
    echo "done"
fi

if [ ! -d ~/Downloads/git/peda ]; then
  echo "install gdb peda..."
  mkdir ~/Downloads/git
  git clone https://github.com/longld/peda.git ~/Downloads/git/peda
  #echo "source ~/peda/peda.py" >> ~/.gdbinit
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
