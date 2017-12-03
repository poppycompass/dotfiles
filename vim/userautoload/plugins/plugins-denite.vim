" 上手く動かないときは :echo has('python3')で1が返ってくるか確認．もしかしたらpacman -S python-neovim で解決するかも
nmap [denite] <Nop>
map <C-d> [denite]

" プロジェクト内のファイル検索
nmap <silent> [denite]<C-f> :Denite file_rec -highlight-mode-insert=Search<CR>
" 検索結果のプレピュー付き
nmap <silent> [denite]<C-p> :Denite -auto_preview grep<CR>
" 前回の結果を再表示
nmap <silent> [denite]<C-r> :Denite -resume<CR>
" バッファに展開中のファイル 
nmap <silent> [denite]<C-b> :Denite buffer -highlight-mode-insert=Search<CR>
" ファイル内の関数/クラス等の
nmap <silent> [denite]<C-o> :Denite outline -highlight-mode-insert=Search<CR>
" dotfiles配下をカレントにし _rec起動
nmap <silent> [denite]<C-v> :call denite#start([{'name': 'file_rec', 'args': ['~/dotfiles']}]) -highlight-mode-insert=Search=Search<CR>

" 上下移動を<C-N>, <C-P>
call denite#custom#map('normal', '<C-N>', '<denite:move_to_next_line>')
call denite#custom#map('normal', '<C-P>', '<denite:move_to_previous_line>')
call denite#custom#map('insert', '<C-N>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<C-P>', '<denite:move_to_previous_line>')
" 入力履歴移動を<C-J>, <C-K>
call denite#custom#map('insert', '<C-J>', '<denite:assign_next_text>')
call denite#custom#map('insert', '<C-K>', '<denite:assign_previous_text>')
" 横割りオープンを`<C-S>`
call denite#custom#map('insert', '<C-S>', '<denite:do_action:split>')
" 縦割りオープンを`<C-I>`
call denite#custom#map('insert', '<C-I>', '<denite:do_action:vsplit>')
" タブオープンを`<C-O>`
call denite#custom#map('insert', '<C-O>', '<denite:do_action:tabopen>')

" file_rec検索時にfuzzymatchを有効にし、検索対象から指定のファイルを除外
call denite#custom#source(
    \ 'file_rec', 'matchers', ['matcher_fuzzy', 'matcher_project_files', 'matcher_ignore_globs'])

" 検索対象外のファイル指定
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
    \ [ '.git/', '.ropeproject/', '__pycache__/',
    \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/',
    \   'deps/'])
