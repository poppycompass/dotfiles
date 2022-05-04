# setup script for ubuntu/debian

VERSION=`cat /etc/os-release | grep "^VERSION_ID=" | cut -d'=' -f2 | perl -pe 's/\n//g'`
BASIC="zsh git vim gcc gdb ctags libncurses5-dev libboost-all-dev cmake wget"
NEOVIM="neovim python-dev python-pip python3-dev python3-pip software-properties-common"
XMONAD="xmobar xmonad rxvt-unicode-256color gmrun suckless-tools chromium-browser"

echo "[+] OS version is ${VERSION}"
case ${VERSION} in
  *12.04* ) sudo apt-get update && \
            sudo apt-get install ${NEOVIM} ${BASIC} ;;
  *14.04* | \
  *16.04* ) sudo add-apt-repository -y ppa:neovim-ppa/unstable && \
            sudo apt update && \
            sudo apt install ${NEOVIM} ${BASIC} && \
            sudo pip3 install neovim neovim-remote ;;
  *18.04* ) sudo apt update && \
            sudo apt install ${NEOVIM} ${BASIC} && \
            sudo pip3 install neovim neovim-remote ;;
  * ) echo "[-] WTF?! OS version not found." ;;
esac

if [ "$1" = "x" ]; then
  sudo apt install ${XMONAD} ;
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
