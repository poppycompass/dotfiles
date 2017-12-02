# setup script for ubuntu/debian
sudo apt-get -y install software-properties-common # for neovim
sudo apt-get -y install python-dev python-pip python3-dev python3-pip # for neovim
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt-get -y update
sudo apt-get -y install neovim vim gcc gdb
sudo apt-get -y install zsh git
if [ "$1" = "x" ]; then
  sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
  sudo apt-get update
  sudo apt-get install -y google-chrome-stable
  sudo apt-get -y install xmobar xmonad rxvt-unicode-256color gmrun suckless-tools
fi
