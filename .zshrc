# 基本設定
# ----------------------------

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
#setxkbmap -option ctrl:nocaps

# cd && ls
function cd() {
  builtin cd $@ && ls --color=auto -h;
}
# mkdir && cd
function mc() {
  if [[ $# -gt 0 ]]; then
    mkdir $1 && cd $1
  else
    echo "mc <dir_name>"
  fi
}
# ファイルにはless, ディレクトリにはlsを実行する
function l() {
  # if the argument is a single file or stdin is pipe
  if [[ ($# -eq 1 && -f "$1") || (-p /dev/stdin) ]]; then
    ${PAGER:-less} "$@"
  else
    ls -alFh --color=auto "$@"
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

# findで見つけたファイルを表示し，lessする
function fl() {
  if [[ $# -gt 0 ]]; then
    list=`find -type f -name $1 2>/dev/null`
    if [[ $list = "" ]]; then
      line="0"
    else
      line=`echo $list | wc -l`
    fi
    case "$line" in
      "0") echo "No file" ;;
      "1") less $list ;;
      *)   echo -en $list | nl
           arr=(`echo $list | tr -s '\n', ' '`)
           echo -en "file: "
           read num
           less $arr[$num] 2>/dev/null ;;
    esac
  else
    echo "fn \"<file_name>\""
  fi
}

# cut | uniq | sortを簡略化
function cus() {
  if [[ $# -eq 2 ]]; then
    cut -d"$1" -f$2 | uniq | sort
  else
    cut -d":" -f1 | uniq | sort
  fi
}

# grep のようにfindする ex: f auth /var. 第一引数にキーワード，第二引数にディレクトリを指定　第二引数を省略した場合はカレントディレクトリが対象，第一引数も省略した場合は除外条件を除く，すべてのファイルが表示
# 除外条件：ディレクトリそのもの，隠しディレクトリ以下
# ex: ls -l $(f sh /bin)
if [[ -n "$PS1" ]]; then
  f() {
    find "${2:-.}" \! -type d \! -path "*/.*" -path "*$1*" |& grep -v -F ": Permission denied" | sort
  }
fi

# ctf
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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

# 言語設定
export LANG=en_US.UTF-8

# エディタはvim
export EDITOR=vim

# PCRE 互換の正規表現を使う
setopt re_match_pcre

# ビープ音を消す
setopt nolistbeep

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# '#' 以降をコメントとして扱う
setopt interactive_comments

# もしかして機能
setopt correct

# Ctrl + a とかやりたい
bindkey -e

# Ctrl + r で履歴さかのぼり
bindkey "^R" history-incremental-search-backward

# 補完機能
# ----------------------------
# 補完機能をON
autoload -U compinit; compinit

# Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
bindkey "^[[Z" reverse-menu-complete

# 補完候補を省スペースに
setopt list_packed

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# 補完候補が複数あるときに自動的に一覧表示する
setopt auto_menu

# 高機能なワイルドカード展開を使用する
setopt extended_glob

# ディレクトリ名だけでcdする
setopt auto_cd

# cdの履歴を記録
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# タイポを訂正
setopt correct

# スペースから始まるコマンドをヒストリに残さない
setopt hist_reduce_blanks

# 履歴関連
# ----------------------------
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
HIST_STAMPS="mm/dd/yyyy"

# 重複する履歴は無視
setopt hist_ignore_dups

# 履歴を共有
setopt share_history

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space



# 色の設定
# ----------------------------
# 色の定義
DEFAULT=$"%{\e[0;0m%}"
RESET="%{${reset_color}%}"
GREEN="%{${fg[green]}%}"
BLUE="%{${fg[blue]}%}"
RED="%{${fg[red]}%}"
CYAN="%{${fg[cyan]}%}"
YELLOW="%{${fg[yellow]}%}"
MAGENTA="%{${fg[magenta]}%}"
WHITE="%{${fg[white]}%}"

autoload -Uz colors; colors
export LSCOLORS=Exfxcxdxbxegedabagacad

# 補完時の色の設定, lsの出力にも影響する
#export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'

# ZLS_COLORS?
export ZLS_COLORS=$LS_COLORS

# lsコマンド時、自動で色がつく
export CLICOLOR=true

# ls color
alias ls='ls --color=auto -h'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -Ah'
alias lr='ls -Rh'

alias 'vim'='nvim'
alias 'vi'='nvim'
alias 'v'='nvim'
alias 'emacs'='nvim'
alias 'gh'='ghci'

alias 'hd'='hexdump -C'
alias 'd'='cd'
alias 'f'='file'
alias 'rm'='rm -i'
alias 'mv'='mv -i'
alias 'cp'='cp -ir'
alias 'mkdir'='mkdir -p'
alias '| l'='| less'
alias '../'='cd ../'
alias 'st'='strings'
alias 'gdb'='gdb -q'
alias 'ctf'='cd $CTF'
alias 'lab'='cd $HOME/work/lab/now'
alias 'proj'='cd $LAB/project/2017'
alias 'bd'="base64 -d"
alias 'ct'="cd $HOME/work/test"
alias 'down'="cd $HOME/Downloads"
alias 'cg'="cd $HOME/Downloads/git"
alias 'r32'="r2 -i $HOME/dotfiles/.radare2rc_32 -d"
alias 'r2'="r2 -c 'aaa;s main;VV'"
alias 'py'="python"
alias 'c'="cat"
alias 'gits'="git status"
alias 'gitc'="git commit"
alias 'gita'="git add -A"
alias 'gitac'="git add -A; git commit"
alias 'gitb'="git branch"
alias 'gitl'="git log --graph -10 --branches --remotes --tags  --format=format:'%Cgreen%h %Creset• %<(75,trunc)%s (%cN, %cr) %Cred%d' --date-order"
alias 'gitam'="git status | sed -e 's/#.*modified://g | xargs git add"
alias 'gitp'="git push"
alias 'gr'="grep -R"
alias 'mm'="less ~/work/doc/memo.txt"
alias 'wifi'='nmcli dev wifi'
alias 'mu'='alsamixer'

# for arch
alias 'pac'='pacman'

# Xmonad for GNOME
alias nautilus='nautilus --no-desktop --browser'
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

# who am i
alias pc="echo poppycompass"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# プロンプトの設定
# ----------------------------
# Gitの情報とか
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '[%s: %b]'
zstyle ':vcs_info:*' actionformats '[%s: %b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

autoload -Uz is-at-least
if is-at-least 4.3.10; then
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"
  zstyle ':vcs_info:git:*' unstagedstr "-"
  zstyle ':vcs_info:git:*' formats '[%s: %b] %c%u'
  zstyle ':vcs_info:git:*' actionformats '[%s: %b|%a] %c%u'
fi

function _update_vcs_info_msg() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg

# コマンドを実行するときに右プロンプトを消す
setopt transient_rprompt

# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

# プロンプトの表示
PROMPT="%F{yellow}%U%n%f%u[%F{blue}%B%~%f%b]$ % "

# プロンプト指定(コマンドの続き)
PROMPT2='[%F{yellow}%n%f]> '

# もしかして時のプロンプト指定
SPROMPT="%{$fg[green]%}%{$suggest%}possible : %B%r%b %{$fg[green]%}? [y,n,a,e]:${reset_color} "

RPROMPT="%1(v|%F{green}%1v%f|)"
