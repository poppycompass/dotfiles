# setup script for Arch linux
sudo pacman -Sy
sudo pacman -S git neovim zsh radare2 gdb python-neovim ctags
if [ "$1" = "x" ]; then
  sudo pacman -S xmonad xmobar rxvt-unicode gmrun dmenu thunderbird firefox
  yaourt -S google-chrome
fi

ln -sf ~/dotfiles/.Xmodmap.arch ~/.Xmodmap

# install global
if [ ! -d /usr/local/global ]; then
  cd /usr/local/src
  sudo wget http://tamacom.com/global/global-6.5.7.tar.gz
  sudo tar xvf global-6.5.7.tar.gz
  sudo ./configure --prefix=/usr/local/global
  sudo make
  sudo make instll
  sudo ln -s /usr/local/global/bin/gtags /usr/bin/gtags
  sudo ln -s /usr/local/global/bin/global /usr/bin/global
  sudo ln -s /usr/local/global/bin/htags /usr/bin/htags
  sudo ln -s /usr/local/global/bin/htags-server /usr/bin/htags-server
fi
