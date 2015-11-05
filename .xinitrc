#!/bin/sh

# $HOME/.xinitrc
#
# User xinitrc file, used by all X sessions started by xinit (startx)

# invoke global X session script
# . /etc/X11/Xsession

# xmonadのModキー変更を適用
#xmodmap $HOME/.Xmodmap
export PATH=$PATH:$HOME/.cabal/bin
