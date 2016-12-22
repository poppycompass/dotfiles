# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export PATH=$PATH:$HOME/.cabal/bin
export SDL_VIDEO_X11_DGAMOUSE=0
export VIDEO_FORMAT="NISC"
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export CTF=$HOME/Downloads/ctf
export LAB=$HOME/work/lab
export TEX=$HOME/work/template/tex
export TC=$HOME/work/templates/ctf
export XDG_CONFIG_HOME=$HOME/dotfiles
xmodmap $HOME/.Xmodmap
setxkbmap -option ctrl:nocaps

# If not running interactively, don't do anything
# export PATH=$PATH:$HOME/.cabal/bin
alias nautilus='nautilus --no-desktop --browser'
case $- in
    *i*) ;;
      *) return;;
esac

# cd && ls
function cd() {
    builtin cd $@ && ls --color=auto;
}
# ファイルにはless, ディレクトリにはlsを実行する
function l() {
   # if the argument is a single file or stdin is pipe
   if [[ ($# -eq 1 && -f "$1") || (-p /dev/stdin) ]]; then
      ${PAGER:-less} "$@"
   else
      ls -alF --color=auto "$@"
   fi
}

# プロセスリストをgrep する ex: p apache2
function p() {
   if [[ $# -gt 0 ]]; then
      ps aux | grep "$@"
   else
      ps aux
   fi
}

# コマンドヒストリをgrepする．
function h() {
   if [[ $# -gt 0 ]]; then
#      history | tac | sort -k2 -u | sort | grep "$@"
      history | grep "$@"
   else
      history
   fi
}
# 通常シェルが終了する時に更新される.bash_historyをコマンド実行後とに更新する 複数シェルを起動している状態で，他のシェルのヒストリを手元に反映させたいときはhisotry -n
if [[ -n "$PS1" ]]; then
   shopt -s histappend
   PROMPT_COMMAND='history -a'
fi

# plt一覧表示
function plt() {
    if [ $# -eq 1 ]; then
        objdump -M intel -d $@ | grep "@plt>:"
    else
        echo "Usage: plt ./bin"
    fi
}
# gotアドレスの表示
function got() {
    if [ $# -eq 1 ]; then
        objdump -M intel -d $@ | grep "@plt>:" -A1
    else
        echo "Usage: got ./bin"
    fi
}
# objdump -M intel -d ./bin | less
function ob() {
    if [ $# -eq 1 ]; then
        objdump -M intel -d $@ | less
    else
        echo "Usage: ob ./bin"
    fi
}
# C-;で直前のディレクトリに戻る やっていることはcd - と同じ
#if [[ -n "$PS1" ]]; then
#   bind '"\C-;":"\ercd -\n"'
#fi

# grep のようにfindする ex: f auth /var. 第一引数にキーワード，第二引数にディレクトリを指定　第二引数を省略した場合はカレントディレクトリが対象，第一引数も省略した場合は除外条件を除く，すべてのファイルが表示
# 除外条件：ディレクトリそのもの，隠しディレクトリ以下
# ex: ls -l $(f sh /bin)
if [[ -n "$PS1" ]]; then
   f() {
      find "${2:-.}" \! -type d \! -path "*/.*" -path "*$1*" |& grep -v -F ": Permission denied" | sort
   }
fi
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -Ah'
alias lr='ls -Rh'
#alias l='ls -CF'

alias 'vi'='vim'
alias 'v'='vim'
alias gh='ghci'

alias hd='hexdump -C'
alias d='cd'
alias f='file'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -ir'
alias mkdir='mkdir -p'
alias st='strings'
alias gdb='gdb -q'
alias ctf='cd $CTF'
alias lab='cd $HOME/work/lab/now'
alias proj='cd $LAB/project/2016'
alias bd="base64 -d"
alias ct="cd $HOME/work/test"
alias down="cd $HOME/Downloads"
alias cg="cd $HOME/Downloads/git"
alias r32="r2 -i $HOME/dotfiles/.radare2rc_32 -d"
alias r2="r2 -c 'aaa;s main;VV'"
alias py="python"
alias nautilus='nautilus --no-desktop --browser'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
