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

SETUP_DIR="setup"
OS=`uname -s | perl -pe 's/\n//g'`
# os type
case ${OS} in
  "Linux" ) DIST=`cat /etc/os-release | grep "^ID=" | cut -d'=' -f2 | perl -pe 's/\n//g'` ;;
  "Darwin") DIST=${OS} ;;
  * ) echo "[-] Unknown OS type"; exit ;;
esac

# run setup script for the distribution
echo "[+] Your distribution is '${OS}/${DIST}'"
if [ ! -d /bin/zsh ]; then
  ${SETUP_DIR}/${DIST}.sh $1
  case `echo $?` in
    0 ) echo "[+] setup of '${DIST}' completed." ;;
    * ) echo "[-] setup script for '${DIST}' not found." ;;
  esac
fi

if [ ! -d ~/.xmonad ]; then
    echo "[+] preparing xmonad..."
    mkdir ~/.xmonad
    echo "[+] done"
fi

if [ ! -d ~/Downloads/git/peda ]; then
  echo "[+] install gdb peda..."
  mkdir ~/Downloads/git
  git clone https://github.com/longld/peda.git ~/Downloads/git/peda
  #echo "source ~/peda/peda.py" >> ~/.gdbinit
fi

cd ~/dotfiles
for file in .?*
do
    if [ $file != '..' ] && [ $file != '.git' ]; then
        echo "[+] create link to $HOME/$file"
        ln -sf $HOME/dotfiles/$file $HOME
    fi
done

if [ ! -d ~/.fzf ]; then
  echo "[+] install fzf..."
  git clone https://github.com/junegunn/fzf ~/.fzf
  echo "y\ny\nn\n" | ~/.fzf/install --all
fi

mkdir -p ~/.vim/bundle
mkdir -p ~/.config/coc/extensions
ln -sf ~/dotfiles/vim/after ~/.vim/
ln -sf ~/dotfiles/vim/colors ~/.vim/
ln -sf ~/dotfiles/vim/userautoload ~/.vim/
ln -sf ~/dotfiles/vim/snippets ~/.vim/
ln -sf ~/.vim ~/dotfiles/nvim
ln -sf ~/dotfiles/.vimrc ~/dotfiles/nvim/init.vim

mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/vim/after ~/.config/nvim
ln -sf ~/dotfiles/vim/colors ~/.config/nvim
ln -sf ~/dotfiles/vim/userautoload ~/.config/nvim
ln -sf ~/dotfiles/vim/snippets ~/.config/nvim

ln -sf ~/dotfiles/xmonad.hs ~/.xmonad/xmonad.hs
chsh -s /bin/zsh

echo "[+] mount /dev/brain! Here we go!"
