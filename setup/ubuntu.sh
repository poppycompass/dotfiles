# setup script for ubuntu/debian

VER=`lsb_release -a | grep Release | cut -d: -f2 | sed -e's/\t//g'`
BASIC="zsh git vim gcc gdb ctags libncurses5-dev libboost-all-dev cmake"
NEOVIM="neovim python-dev python-pip python3-dev python3-pip software-properties-common"
XMONAD="xmobar xmonad rxvt-unicode-256color gmrun suckless-tools"

echo "[+] OS version is ${VER}"
case ${VER} in
  "12.04") sudo apt-get update && \
           sudo apt-get install ${NEOVIM} ${BASIC} ;;
  "14.04") sudo add-apt-repository -y ppa:neovim-ppa/unstable ;;
  "16.04") sudo apt install ${NEOVIM} ${BASIC} ;;
  "18.04") sudo apt update && \
           sudo apt install ${NEOVIM} ${BASIC} && \
           sudo pip3 install neovim ;;
  * ) echo "[-] WTF?! OS version not found." ;;
esac

if [ "$1" = "x" ]; then
  sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
  case ${VER} in
    "12.04") sudo apt-add-repository ppa:neovim-ppa/stable && \
             sudo apt-get update && \
             sudo apt-get install ${XMONAD} "google-chrome-stable" ;;
    "14.04") sudo apt update && \
             sudo apt install ${XMONAD} "google-chrome-stable" ;;
    "16.04") sudo apt update && \
             sudo apt install ${XMONAD} "google-chrome-stable" ;;
    "18.04") sudo apt install ${XMONAD} "chromium-browser" ;;
    * ) echo "[-] WTF?! OS version not found." ;;
  esac
fi
# install global
if [ ! -d /usr/local/global ]; then
  global="global-6.5.7"
  ext=".tar.gz"
  cd /usr/local/src
  sudo wget http://tamacom.com/global/${global}${ext}
  sudo tar xvf ${global}${ext}
  cd ${global}
  sudo ./configure --prefix=/usr/local/global
  sudo make
  sudo make install
  sudo ln -s /usr/local/global/bin/gtags /usr/bin/gtags
  sudo ln -s /usr/local/global/bin/global /usr/bin/global
  sudo ln -s /usr/local/global/bin/htags /usr/bin/htags
  sudo ln -s /usr/local/global/bin/htags-server /usr/bin/htags-server
fi

ln -sf ~/dotfiles/.Xmodmap ~/.Xmodmap
