" .vimrc
"
set title
set nocompatible "vi との互換性を優先しない"
filetype plugin indent on
filetype indent on

" nvim/vim固有の設定
if has('nvim') " nvim
    set clipboard=unnamed,unnamedplus
    set mouse=
    " builtin termialでの<Esc>
    tnoremap <C-k> <C-\><C-n>
    nnoremap <silent> .v :Hexplore<CR>:terminal<CR>

    " ----- dein settings -----
    " プラグインが実際にインストールされるディレクトリ
    let s:dein_dir = expand('~/.vim/dein')
    " dein.vim 本体
    let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')

    " 設定開始
    if dein#load_state(s:dein_dir)
        call dein#begin(s:dein_dir)

        " プラグインリストを収めた TOML ファイル
        " 予め TOML ファイル（後述）を用意しておく
        let g:rc_dir    = expand('~')
        let s:toml      = g:rc_dir . '/.dein.toml'
        let s:lazy_toml = g:rc_dir . '/.dein_lazy.toml'

        " TOML を読み込み、キャッシュしておく
        call dein#load_toml(s:toml,      {'lazy': 0})
        call dein#load_toml(s:lazy_toml, {'lazy': 1})

        " 設定終了
        call dein#end()
        call dein#save_state()
    endif
    " プラグインを追加・削除やtomlファイルを編集した後は
    " 適宜 call dein#update, call dein#clear_stateを呼ぶ
    if dein#check_install()
        call dein#install()
    endif
else " vim
    " nvimデフォルト有効/バックアップ(history)
    set ttyfast
    set history=10000
    " VimShell
    nnoremap <silent> .v :Hexplore<CR>:VimShell<CR>

    " ----- Neobundle Settings -----"
    let s:noplugin = 0
    let s:bundle_root = expand('~/.vim/bundle')
    let s:neobundle_root = s:bundle_root . '/neobundle.vim'
    if !isdirectory(s:neobundle_root) || v:version < 702
        " NeoBundleがない場合またはvimのバージョンが古い場合はNeoBundleを読み込まない "
        let s:noplugin = 1
    else
        " プラグイン管理のNeoBundle起動+bundle関係のディレクトリ指定"
        if has('vim_starting')
            set runtimepath+=~/.vim/bundle/neobundle.vim
            "execute "set runtimepath+=" . s:neobundle_root
        endif
        call neobundle#begin(expand('~/.vim/bundle/'))
        NeoBundleFetch 'Shougo/neobundle.vim'

        " vimで非同期操作を可能にする。NeoBundleと連携可能 "
        NeoBundle 'Shougo/vimproc', {
                    \ 'build': {
                    \     'windows': 'make -f make_mingw32.mak',
                    \      'cygwin' : 'make -f make_cygwin.mak',
                    \      'mac'    : 'make -f make_mac.mak',
                    \      'unix'   : 'make -fmake_unix.mak',
                    \ }}

        " 補完 "
        if has('lua') && ( (v:version >= 703 && has('patch885')) || v:version >= 704)
            " 鬱陶しいほどの自動補完
            "NeoBundle 'Shougo/neocomplete'
            "let g:neocomplete#enable_at_startup = 1
        else
            "NeoBundle 'Shougo/neocomplcache'
            "let g:neocomplcache_enable_at_startup = 1
        endif

        " 以下各種プラグイン "

        " haskell"
        " ghc-mod
        NeoBundleLazy "eagletmt/ghcmod-vim",         {"autoload" : { "filetypes" : ["haskell"] }}
        " Haskell補完
        NeoBundleLazy "ujihisa/neco-ghc",            {"autoload" : { "filetypes" : ["haskell"] }}
        " Unite でモジュールを挿入
        NeoBundleLazy "ujihisa/unite-haskellimport", {"autoload" : { "filetypes" : ["haskell"] }}
        " Vimのシンタックスハイライト設定　長い配列を取り扱ったりすると動作が極めて遅くなる原因
        NeoBundleLazy "dag/vim2hs",                  {"autoload" : { "filetypes" : ["haskell"] }}
        " 本来はHoogleドキュメントを閲覧するためのものらしいが，使い方が分からないため放置
        "    NeoBundleLazy "eagletmt/unite-haddock",      {"autoload" : { "filetypes" : ["haskell"] }}

        " Scheme(Gauche)なんだが，lisp_rainbowを使うためにLisp扱い
        " Vim 内でGoshを起動できる
        "NeoBundleLazy 'aharisu/vim_goshrepl',         {"autoload" : { "filetypes" : ["lisp"] }}
        "NeoBundleLazy 'aharisu/vim-gdev',             {"autoload" : { "filetypes" : ["lisp"] }}
        " ruby用
        NeoBundle "tpope/vim-rails",                  {"autoload" : { "filetypes" : ["ruby"] }}
        " neomru.vim
        NeoBundleLazy 'Shougo/neomru.vim'

        " quickrun "
        NeoBundle 'thinca/vim-quickrun'
        " Align "
        NeoBundle 'Align'
        " バイナリ編集 "
        NeoBundle 'Shougo/vinarise'
        " VimShell
        NeoBundle 'Shougo/vimshell'
        " Unite depends neomru
        NeoBundle 'Shougo/unite.vim'
        " colorfull statusbar
        NeoBundle 'itchyny/lightline.vim'
        " 囲むやつ
        "NeoBundle 'tpope/vim-surround.vim'

        " プラグインここまで "
        call neobundle#end()

        "filetype plugin indent on  "ファイル形式ごとのインデントを設定する。(あった場合のみ) NeoBundle起動に必要 "
        "filetype indent on
        " vim起動時に未インストールのNeoBundleがあればプロンプトを出す "
        NeoBundleCheck
    endif
    " ----- Neobundle Settings end -----"
endif

" lightline設定, 自動構文チェック(c/cpp)
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'separator': { 'left': "〉", 'right': "〈" },
      \ 'subseparator': { 'left': "〈", 'right': "〈" },
      \ 'component': {
      \   'readonly': '%{&readonly?"!RO!":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}'
      \ },
      \ 'active': {
      \   'right': [ [ 'syntastic', 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ }
      \ }
let g:syntastic_mode_map = { 'mode': 'passive' }
augroup AutoSyntastic
  autocmd!
  " 構文チェックのファイルタイプはここで指定．現在半無効化
  "autocmd BufWritePost *.c,*.cpp call s:syntastic()
  autocmd BufWritePost *.none call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

" ----- vim/nvim共通設定 -----
" quickrunで開く窓を水平分割にする
" quickrun横分割時は下へ，縦分割時は右に新しいウィンドウが開く
" 'c/gcc'などで設定した内容は :QuickRun c/gccで実行
" '_'は全部に対する設定
let g:quickrun_config={
            \ '_': {
            \    'split': '',
            \    'outputter/buffer/close_on_empty' : 1,
            \    'outputter' : 'quickfix',
            \    'runner' : 'vimproc',
            \    'runner/vimproc/updatetime' : 60,
            \},
            \}

set splitbelow
set splitright
syntax on "文字に色をつける"
set synmaxcol=400 "長い文字列のコピペで重くなるのは，色付けをデフォルト3000文字まで頑張っちゃおうとするのが原因．制限すれば軽くなる"

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
set tabstop=4 "画面上でタブ文字が占める幅"
set expandtab "タブ入力を複数の空白入力に置き換える"
set shiftwidth=4 "自動インデントでずれる幅"
set softtabstop=4 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅"
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
nnoremap <C-k> <Esc>
inoremap <C-k> <Esc>
cnoremap <C-k> <Esc>
vnoremap <C-k> <Esc>
" nohlsearch
nmap <silent> ,, :nohlsearch<CR>
" only
nmap <silent> ,o :only<CR>
" Quickrun
nmap <silent> ,r :w<CR>:QuickRun<CR>
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
" バイナリ編集, rで書き換え
nmap <silent> ,V :Vinarise<CR>
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
" 水平分割して下のウィンドウでブラウジング開始 -> Netrwの利用コマンド
nmap <silent> ,h :Hexplore<CR>
" 縦分割してExplore
nmap <silent> ,v :Vexplore<CR>
" Explore
nmap <silent> ,e :Explore<CR>
" Haskellの型推測
nmap <silent> \t :w<CR>:GhcModType<CR>
" 型推測によるハイライトを消す
nmap <silent> \n :GhcModTypeClear<CR>
" 現在のバッファで開いているHaskellのコードに対してコンパイルエラー・警告をquickfixウィンドウに表示
nmap <silent> \c :w<CR>:GhcModCheck<CR>
" hlintからのメッセージをquickfixウィンドウに表示する
nmap <silent> \h :w<CR>:GhcModLint<CR>
" <Tab>で現在行をインデント
nnoremap <Tab> >>
" Virsual modeで選択した部分を * で検索できる
vnoremap * "zy:let @/ = @z<CR>n
" バッファ移動
"nmap <silent> <C-o> :bp<CR>
" ファイルテンプレートの挿入
nmap <silent> ,/ Go/* E.O.F. */<Esc>ggO/* <C-r>% */<CR>
nmap <silent> ,- Go-- E.O.F.<Esc>ggO-- <C-r>%<CR>
nmap <silent> ,# Go# E.O.F.<Esc>ggO#!/bin/sh<CR># <C-r>%<CR>
" path
"nmap <silent> <C-P> :set path?<CR>
" コピー時に挿入された文頭の空白を消す
nmap <silent> ,<SPACE> :%s/^ *//g<CR>:noh<CR>

nmap <silent> <C-m> :set nopaste<CR>:set buftype=<CR>

" neovim ターミナル起動
nmap <silent> .t :tabnew<CR>:terminal<CR>

" global
"map <C-g> :Gtags
" 今開いているコードの関数一覧がQuickfix Listに表示
nmap <C-\><C-l> :Gtags -f %<CR>
" 定義先へ飛ぶ
nmap <C-s> :GtagsCursor<CR>
" カーソル以下の使用箇所を探す
nmap <C-\><C-k> :Gtags -r <C-r><C-w><CR>
" Quickfixでの移動
nmap [q :cn<CR>
nmap ]q :cp<CR>
nmap [Q :<C-u>cfirst<CR>
nmap ]Q :<C-u>clast<CR>

" For Arch Linux
" xlock
nmap <C-l> :!xlock<CR>

if &term == "rxvt-unicode-256color" || &term == "nvim"
   " ~/.vim/colors/urxvt.vim
   colorscheme urxvt
else
   highlight CursorLine term=none cterm=none ctermfg=none ctermbg=black "カーソルがある行のハイライト表示.ctermbgはバックグラウンドの色を決定.端末の背景色が黒に近いため、設定の黒が結果的には白に見える.これを実現するには、デスクトップの背景画像が少し透けるくらいの暗さにしておく。設定は端末の編集で行う."
endif

" ファイルタイプごとの設定．追加するときはaugroup内に追記していく
augroup fileTypeIndent
    autocmd!
    " LaTex用のタブ幅
    autocmd BufNewFile,BufRead *.tex setlocal tabstop=2 softtabstop=2 shiftwidth=2
    " Schemeの場合に()の色を付ける
    "let lisp_rainbow = 1
    "autocmd BufNewFile,BufRead *.scm set ft=lisp
augroup END

" ファイルの自動更新
augroup vimrc-vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

" vimgrep and open cwindow
autocmd QuickFixCmdPost *grep* cwindow|nnoremap <buffer> <CR> <CR>
" quickfixでEnterを押すと該当エラーに跳ぶ
autocmd BufReadPost quickfix cwindow|nnoremap <buffer> <CR> <CR>

" 実行時に下のパスにある設定ファイルも読み込む "
set runtimepath+=~/.vim/
runtime! userautoload/*.vim

" E.O.F. "
