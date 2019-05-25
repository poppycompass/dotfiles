" .vimrc

" 全体的な設定
set all& " init all settings
set title
set nocompatible "vi との互換性を優先しない"
set ttyfast
set history=10000
set splitbelow
set splitright
syntax on "文字に色付け
set synmaxcol=400 "長い文字列のコピペで重くなるのは，色付けをデフォルト3000文字まで頑張っちゃおうとするのが原因．制限すれば軽くなる"
filetype on
filetype detect

"画面表示の設定"
set number "行番号の表示"
set cursorline "カーソル行の背景色を変える"
set list "不可視文字の可視化 現在無効化"
"set showmatch " () {} の対応を報告 nvimだと重い
set textwidth=0 " 入力中のテキスト最大幅．幅を越えると空白の後で改行される．値を0にすると無効化


"検索/置換の設定"
set ruler " 画面右下のカーソル位置表示" 
set hlsearch "検索文字列をハイライトする"
set ignorecase " 検索時に文字の大小を区別しない
set smartcase " 検索時に大文字を含んでいたら大小を区別する


"タブ/インデントの設定"
set tabstop=2 "画面上でタブ文字が占める幅"
set expandtab "タブ入力を複数の空白入力に置き換える"
set shiftwidth=2 "自動インデントでずれる幅"
set softtabstop=2 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅"
set autoindent "改行時に前の行のインデントを継続"
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する"
set cindent "改造が可能なインデント。詳しくはググれ"

" エンコード
" エラーが出たら順次次のエンコードを試していく．もし日本語で上手く表示できなければ以下を順次試してみること
" ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,cp932
" set fileencodings=utf-8, sjis,
" euc-jpと書くとエラーが出る．とにかく','の後にスペースを入れないこと．下手に綺麗に書こうとすると痛い目にあう
set fileencodings=utf-8,sjis,euc-jp

"カーソル移動関連設定"
set whichwrap=b,s,h,l,<,>,[,] "行頭行末の左右移動で行をまたぐ"
set scrolloff=8 "上下8行の視界を確保"
set sidescrolloff=16 "左右スクロール時の視界を確保"
set sidescroll=1 "左右スクロールは一文字づつ行う"
" 巨大整数などを扱ったときにスクロールが遅くなることを防ぐ・・・はず？
set lazyredraw
" ブロック指定モードで書いていないところも進める(=all)
set virtualedit+=block

"ファイル処理関連設定"
set confirm "保存されていないファイルがある時は終了前に保存確認"
set hidden  " ファイル変更中でも他のファイルを開けるようにする
set autoread "外部でファイルに変更があった場合は読み直す"
set autochdir "開いたファイルのディレクトリがカレントディレクトリになる
set noswapfile "ファイル編集中にスワップファイルを作らない"

" パス
set path+=/usr/local/include

"コマンドラインモードでのTABキーによるファイル名補完を有効にする"
set wildmenu wildmode=list:full "タブによるファイル名補完.マッチした候補を表示しつつ順番に候補を変えていく" 


" キーバインド
" 文字移動
noremap j gj
noremap k gk
" 改行
nmap <C-j> o<Esc>
" 押しやすいEsc
nnoremap <silent> <C-k> <Esc>:set nopaste buftype=<CR>
inoremap <silent> <C-k> <Esc>:set nopaste buftype=<CR>
cnoremap <silent> <C-k> <Esc>:set nopaste buftype=<CR>
vnoremap <silent> <C-k> <Esc>:set nopaste buftype=<CR>
" nohlsearch
nmap <silent> ,, :nohlsearch<CR>
" only
nmap <silent> ,o :only<CR>
" quit
nmap <silent> ,c :q<CR>
" quit all
nmap <silent> ,q :qa<CR>
" write
nmap <silent> ,w :w<CR>
" write and quit
nmap <silent> ,s :w<CR>:q<CR>
" ファイルタイプの設定
nmap ,f :set ft=
" エンコード設定(utf8, sjis...)
nmap ,E :e ++enc=
" tabnew
nmap <silent> ,t :tabnew<CR>:Explore<CR>
" tab移動
nmap <silent> <C-n> gt
nmap <silent> <C-p> gT
" ウィンドウ移動 <C-w> -> s
nnoremap <silent> sh <C-w>h
nnoremap <silent> sj <C-w>j
nnoremap <silent> sk <C-w>k
nnoremap <silent> sl <C-w>l
nnoremap <silent> sw <C-w>w
" ウィンドウの配置移動
nnoremap <silent> sH <C-w>H
nnoremap <silent> sJ <C-w>J
nnoremap <silent> sK <C-w>K
nnoremap <silent> sL <C-w>L
nnoremap <silent> sr <C-w>r
" ウィンドウの大きさ変更
" 縦横最大化
nnoremap <silent> so <C-w>_<C-w>|
" 大きさを揃える
nnoremap <silent> s= <C-w>=
" 幅の増減
nnoremap <silent> s> <C-w>>
nnoremap <silent> s< <C-w><
" 高さの増減
nnoremap <silent> s+ <C-w>+
nnoremap <silent> s- <C-w>-
" ウィンドウ分割
nnoremap <silent> sv <C-w>v
nnoremap <silent> sm :sp<CR>
" 分割してファイル選択
nmap <silent> ,h :Hexplore<CR>
nmap <silent> ,v :Vexplore<CR>
nmap <silent> ,e :Explore<CR>

" Quickrun
nmap <silent> ,r :w<CR>:QuickRun<CR>
" バイナリ編集, rで書き換え
nmap <silent> ,V :Vinarise<CR>

" ノーマルモードで';'と':'を入れ替え
nnoremap ; :
" .vimrcの反映
nmap <silent> .s :w<CR>:source ~/.vimrc<CR>:noh<CR>
" GNU Make
nmap <silent> ,d :w<CR>:copen<CR>:make<CR><CR>
" GNU Make test
nmap <silent> ,D :w<CR>:copen<CR>:make<CR><CR>:make test<CR><CR>
" 単語の小文字化
nmap ,u bguwA
" 単語の大文字化
nmap ,U bgUwA
" 畳み込み 現在畳み込まれている行で行うと一行追加できる. 
nmap ,z zfj
" C等の関数向け畳み込み
nmap ,{ zfa{
" <Tab>で現在行をインデント
nnoremap <Tab> >>
nnoremap <silent>> >>
nnoremap <silent>< <<
" Virsual modeで選択した部分を * で検索できる
vnoremap * "zy:let @/ = @z<CR>n
" ファイルテンプレートの挿入
nmap <silent> ,/ Go/* E.O.F. */<Esc>ggO/* <C-r>% */<CR>
nmap <silent> ,- Go-- E.O.F.<Esc>ggO-- <C-r>%<CR>
nmap <silent> ,# Go# E.O.F.<Esc>ggO#!/bin/sh<CR># <C-r>%<CR>
" path
"nmap <silent> <C-P> :set path?<CR>
" コピー時に挿入された文頭の空白を消す
nmap <silent> ,<SPACE> :%s/^ *//g<CR>:noh<CR>

nmap <silent> <C-m> :set nopaste<CR>:set buftype=<CR>

" ターミナル起動
nmap <silent> .t :tabnew<CR>:terminal<CR>

" For Arch Linux
" xlock
nmap <C-l> :!xlock<CR>

" 検索用
nmap m/ /\*\*\* 
" <Leader>をspaceに
let mapleader = "\<Space>"

if &term == "rxvt-unicode-256color" || &term == "nvim"
   colorscheme urxvt
else
   highlight CursorLine term=none cterm=none ctermfg=none ctermbg=black "カーソルがある行のハイライト表示.ctermbgはバックグラウンドの色を決定.端末の背景色が黒に近いため、設定の黒が結果的には白に見える.これを実現するには、デスクトップの背景画像が少し透けるくらいの暗さにしておく。設定は端末の編集で行う."
endif

augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.txt setlocal tabstop=2 softtabstop=2 shiftwidth=2 
  autocmd BufNewFile,BufRead *.tex setlocal tabstop=2 softtabstop=2 shiftwidth=2 
  autocmd BufNewFile,BufRead *.py  setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.rb  setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.go  setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.c   setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.h   setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.hpp setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END

" ファイルの自動更新, buftype 問題を解決
augroup vimrc-refresh
  autocmd!
  autocmd InsertEnter,WinEnter * checktime
  autocmd InsertEnter,WinEnter *.* set nopaste buftype=
  autocmd InsertEnter,WinEnter .* set nopaste buftype=
augroup END

" vimgrep and open cwindow
autocmd QuickFixCmdPost *grep* cwindow|nnoremap <buffer> <CR> <CR>
" quickfixでEnterを押すと該当エラーに跳ぶ
autocmd BufReadPost quickfix cwindow|nnoremap <buffer> <CR> <CR>

" nvim
if has('nvim')
  set clipboard=unnamed,unnamedplus
  set mouse=
  " builtin termialでの<Esc>
  tnoremap <C-k> <C-\><C-n>
  nnoremap <silent> .v :Hexplore<CR>:terminal<CR>
endif
" Open terminal on new buffer
autocmd VimEnter * if @% == '' && s:GetBufByte() == 0 | call Term()
function! s:GetBufByte()
  let byte = line2byte(line('$') + 1)
  if byte == -1
    return 0
  else
    return byte - 1
  endif
endfunction
function! Term()
  call termopen(&shell, {'on_exit': 'OnExit'})
endfunction

function! CloseLastTerm()
  if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    :q
  endif
endfunction
function! OnExit(job_id, code, event)
  if a:code == 0
    call CloseLastTerm()
  endif
endfunction

" 実行時に下のパスにある設定ファイルも読み込む
set runtimepath+=~/.vim/userautoload

" vimバージョン依存, TODO: vim8.0ではdeinが上手く動かない?
if v:version >= 704
  runtime! userautoload/basic/*.vim
  runtime! userautoload/dein/*.vim
  "runtime! userautoload/util/*.vim
elseif (v:version > 702) && (v:version < 704) " deinが使えないくらいの古さ
  runtime! userautoload/basic/*.vim
  runtime! userautoload/neobundle/*.vim
  runtime! userautoload/plugins/*.vim
  "runtime! userautoload/util/*.vim
else " 化石
  runtime! userautoload/basic/*.vim
endif
" E.O.F. "
