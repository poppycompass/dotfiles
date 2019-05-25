# setup script for OSX Darwin
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install neovim/neovim/neovim
brew install zsh git binutils gdb fzf
$(brew --prefix)/opt/fzf/install
pip3 install neovim-remote
