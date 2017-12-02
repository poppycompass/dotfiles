" 古いVim向け．Neobundle等
" VimShell
nnoremap <silent> .v :Hexplore<CR>:VimShell<CR>

" ----- Neobundle Settings -----"
let s:noplugin = 0
let s:bundle_root = expand('~/.vim/bundle')
let s:neobundle_root = s:bundle_root . '/neobundle.vim'
" neobundleがなかったら持ってくる
if !isdirectory(s:neobundle_root)
  execute '!git clone https://github.com/Shougo/neobundle.vim' s:neobundle_root
endif

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
