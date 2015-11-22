set title
" .vimrc
set nocompatible "vi との互換性を優先しない"
filetype off

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
"      NeoBundle 'Shougo/neocomplete'
"      let g:neocomplete#enable_at_startup = 1
   else
"      NeoBundle 'Shougo/neocomplcache'
"      let g:neocomplcache_enable_at_startup = 1
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

   " quickrun "
   NeoBundle 'thinca/vim-quickrun'
   " Align "
   NeoBundle 'Align'
   " バイナリ編集 "
   NeoBundle 'Shougo/vinarise'

   " プラグインここまで "
   call neobundle#end()

   filetype plugin indent on  "ファイル形式ごとのインデントを設定する。(あった場合のみ) NeoBundle起動に必要 "
   filetype indent on
   " vim起動時に未インストールのNeoBundleがあればプロンプトを出す "
   NeoBundleCheck
endif

" ----- Neobundle Settings end -----"

" quickrunで開く窓を水平分割にする
let g:quickrun_config={'*': {'split': ''}}
" quickrun横分割時は下へ，縦分割時は右に新しいウィンドウが開く
set splitbelow
set splitright

syntax on "文字に色をつける"

"画面表示の設定"
set number "行番号の表示"
set cursorline "カーソル行の背景色を変える"
set list "不可視文字の可視化 現在無効化"
set showmatch " () {} の対応を報告"
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

" バックアップ
set history=1000

"カーソル移動関連設定"
set whichwrap=b,s,h,l,<,>,[,] "行頭行末の左右移動で行をまたぐ"
set scrolloff=8 "上下8行の視界を確保"
set sidescrolloff=16 "左右スクロール時の視界を確保"
set sidescroll=1 "左右スクロールは一文字づつ行う"
" 巨大整数などを扱ったときにスクロールが遅くなることを防ぐ・・・はず？
set lazyredraw
set ttyfast


"ファイル処理関連設定"
set confirm "保存されていないファイルがある時は終了前に保存確認"
set hidden  " ファイル変更中でも他のファイルを開けるようにする
set autoread "外部でファイルに変更があった場合は読み直す"
set noswapfile "ファイル編集中にスワップファイルを作らない"


"コマンドラインモードでのTABキーによるファイル名補完を有効にする"
set wildmenu wildmode=list:full "タブによるファイル名補完.マッチした候補を表示しつつ順番に候補を変えていく" 

" 開いたファイルのディレクトリがカレントディレクトリになる
au BufEnter * execute ":lcd" . expand("%:p:h")

" キーバインド
" 文字移動
noremap j gj
noremap k gk
" 改行
nmap <CR> o<Esc>
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
nmap ,e :e ++enc=
" バイナリ編集, rで書き換え
nmap <silent> ,V :Vinarise<CR>
" tabnew
nmap <silent> ,t :tabnew<CR>:Explore<CR>
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
" 水平分割してしたのウィンドウでブラウジング開始 -> Netrwの利用コマンド
nmap <silent> ,h :Hexplore<CR>
" Explore
nmap <silent> ,E :Explore<CR>
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

" For Arch Linux
" xlock
nmap <C-l> :!xlock<CR>

if &term == "rxvt-unicode-256color"
   " ~/.vim/colors/urxvt.vim
   colorscheme urxvt
else
   highlight CursorLine term=none cterm=none ctermfg=none ctermbg=black "カーソルがある行のハイライト表示.ctermbgはバックグラウンドの色を決定.端末の背景色が黒に近いため、設定の黒が結果的には白に見える.これを実現するには、デスクトップの背景画像が少し透けるくらいの暗さにしておく。設定は端末の編集で行う."
endif

" Schemeの場合に()の色を付ける
"let lisp_rainbow = 1
"au BufNewFile,BufRead *.scm set ft=lisp

"バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin ファイルを開くと発動します）"
"テキスト表示に戻したいときは　:autocmd! BinaryXXD と入力。これでaugroupが無効化.新しく開いたファイルはテキストファイルとして表示される, 
"Vinariseの方が便利であるため現在消去"
"augroup BinaryXXD
"  autocmd!
"  autocmd BufReadPre  *.bin let &binary = 1
"  autocmd BufReadPost * if &binary | silent %!xxd -g 1
"  autocmd BufReadPost * set ft=xxd | endif
"  autocmd BufWritePre * if &binary | %!xxd -r | endif
"  autocmd BufWritePost * if &binary | silent %!xxd -g 1
"  autocmd BufWritePost * set nomod | endif
"augroup END

" END binary "
" vimgrep and open cwindow
autocmd QuickFixCmdPost *grep* cwindow

" 実行時に下のパスにある設定ファイルも読み込む "
set runtimepath+=~/.vim/
runtime! userautoload/*.vim

" E.O.F. "
