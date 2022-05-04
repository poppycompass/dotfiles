# setup script for Arch linux
sudo pacman -Sy
sudo pacman -S git neovim zsh radare2 gdb python-neovim ctags
if [ "$1" = "x" ]; then
  sudo pacman -S xmonad xmobar rxvt-unicode gmrun dmenu thunderbird firefox
  yaourt -S google-chrome
fi
