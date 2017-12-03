# setup script for ubuntu/debian
sudo apt-get -y install software-properties-common # for neovim
sudo apt-get -y install python-dev python-pip python3-dev python3-pip # for neovim
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt-get -y update
sudo apt-get -y install neovim vim gcc gdb ctags
sudo pip3 install neovim
sudo apt-get -y install zsh git
if [ "$1" = "x" ]; then
  sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
  sudo apt-get update
  sudo apt-get install -y google-chrome-stable
  sudo apt-get -y install xmobar xmonad rxvt-unicode-256color gmrun suckless-tools
fi
ln -sf ~/dotfiles/.Xmodmap ~/.Xmodmap

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
