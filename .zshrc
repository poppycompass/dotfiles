# common settings
source ~/dotfiles/.shrc

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

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# 出力結果をクリップボードにコピー
# $ pwd | cl
alias cl="xclip -in -sel clip"

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

alias '| l'='| less -N'
alias '../'='cd ../'

# OS依存なもの, exportの後に実行すること(共通設定に上書き)
case ${OS} in
  "Linux" )
    source ~/dotfiles/shell/zshrc.linux
    ;;
  "Darwin" )
    source ~/dotfiles/shell/zshrc.osx
    ;;
  * ) echo "[-] Unknown OS type"; exit ;;
esac

# fzf
if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
  export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
  export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
  # fbr - checkout git branch
  fbr() {
    local branches branch
    branches=$(git branch -vv) &&
    branch=$(echo "$branches" | fzf +m) &&
    git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
  }
  #fbrm - checkout git branch (including remote branches)
  fbrm() {
    local branches branch
    branches=$(git branch --all | grep -v HEAD) &&
    branch=$(echo "$branches" |
             fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
  }
  # fshow - git commit browser
  fshow() {
    git log --graph --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
        --bind "ctrl-m:execute:
                  (grep -o '[a-f0-9]\{7\}' | head -1 |
                  xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                  {}
  FZF-EOF"
  }
  # fcd - cd to selected directory
  fcd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune \
                    -o -type d -print 2> /dev/null | fzf +m) &&
    cd "$dir"
  }
  # worktree移動
  function cdworktree() {
    # カレントディレクトリがGitリポジトリ上かどうか
    git rev-parse &>/dev/null
    if [ $? -ne 0 ]; then
        echo fatal: Not a git repository.
        return
    fi

    local selectedWorkTreeDir=`git worktree list | fzf | awk '{print $1}'`

    if [ "$selectedWorkTreeDir" = "" ]; then
        # Ctrl-C.
        return
    fi

    cd ${selectedWorkTreeDir}
  }
  fadd() {
    local out q n addfiles
    while out=$(
        git status --short |
        awk '{if (substr($0,2,1) !~ / /) print $2}' |
        fzf-tmux --multi --exit-0 --expect=ctrl-d); do
      q=$(head -1 <<< "$out")
      n=$[$(wc -l <<< "$out") - 1]
      addfiles=(`echo $(tail "-$n" <<< "$out")`)
      [[ -z "$addfiles" ]] && continue
      if [ "$q" = ctrl-d ]; then
        git diff --color=always $addfiles | less -R
      else
        git add $addfiles
      fi
    done
  }
  # fkill - kill process
  fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

    if [ "x$pid" != "x" ]; then
      echo $pid | xargs kill -${1:-9}
    fi
  }
fi
