" ----- dein settings -----
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.vim/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" deinがなかったら持ってくる
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif

" ネットに繋がっていないとかでdeinがない
"if !isdirectory(s:dein_repo_dir)
"  let s:noplugin = 1
"endif

execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir    = expand('~/.vim/userautoload/dein/')

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(g:rc_dir . 'dein.toml'         , {'lazy': 0})
  call dein#load_toml(g:rc_dir . 'dein_lazy.toml'    , {'lazy': 1})
  call dein#load_toml(g:rc_dir . 'dein_go.toml'       , {'lazy': 1})
  "call dein#load_toml(g:rc_dir . 'dein_c.toml'       , {'lazy': 1})
  "call dein#load_toml(g:rc_dir . 'dein_python.toml'  , {'lazy': 1})
  "call dein#load_toml(g:rc_dir . 'dein_vim.toml'     , {'lazy': 1})
  "call dein#load_toml(g:rc_dir . 'dein_ruby.toml'    , {'lazy': 1})
  "call dein#load_toml(g:rc_dir . 'dein_haskell.toml' , {'lazy': 1})

  call dein#end()
  call dein#save_state()

endif

" vimprocのビルド・アップデートも自動でやってくれるらしい
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
" プラグインを追加・削除やtomlファイルを編集した後は適宜 call dein#update, call dein#clear_stateを呼ぶ, has('vim_starting')は起動時のみtrue
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
