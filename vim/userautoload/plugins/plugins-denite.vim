" 上手く動かないときは :echo has('python3')で1が返ってくるか確認．もしかしたらpacman -S python-neovim で解決するかも
nmap [denite] <Nop>
map <C-D> [denite]

" プロジェクト内のファイル検索
nmap <silent> [denite]<C-F> :Denite -auto-action=preview file/rec<CR>
" 検索結果のプレピュー付き
nmap <silent> [denite]<C-P> :Denite grep<CR>
" 前回の結果を再表示
nmap <silent> [denite]<C-R> :Denite -resume<CR>
" バッファに展開中のファイル 
nmap <silent> [denite]<C-B> :Denite buffer<CR>
" ファイル内の関数/クラス等の
nmap <silent> [denite]<C-O> :Denite outline<CR>
" neoyank
nmap <silent> [denite]<C-Y> :Denite neoyank<CR>
" dotfiles配下をカレントにし /rec起動
nmap <silent> [denite]<C-V> :call denite#start([{'name': 'file/rec', 'args': ['~/dotfiles']}])<CR>
" カーソル以下の単語をgrep
nmap <silent> [denite]<C-G> :DeniteCursorWord grep -buffer-name=search line<CR><C-R><C-W><CR>


" プロンプト変更
call denite#custom#option('default', 'prompt', '$')

" 上下移動を<C-N>, <C-P>
call denite#custom#map('normal', '<C-N>', '<denite:move_to_next_line>')
call denite#custom#map('normal', '<C-P>', '<denite:move_to_previous_line>')
call denite#custom#map('insert', '<C-N>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<C-P>', '<denite:move_to_previous_line>')
" 入力履歴移動を<C-J>, <C-L>
call denite#custom#map('insert', '<C-J>', '<denite:assign_next_text>')
call denite#custom#map('insert', '<C-L>', '<denite:assign_previous_text>')
" 横割りオープンを`<C-S>`
call denite#custom#map('insert', '<C-S>', '<denite:do_action:split>')
" 縦割りオープンを`<C-I>`
call denite#custom#map('insert', '<C-I>', '<denite:do_action:vsplit>')
" タブオープンを`<C-T>`
call denite#custom#map('insert', '<C-T>', '<denite:do_action:tabopen>')
" やはりNormalモードへはC-K
call denite#custom#map('insert', '<C-K>', '<denite:enter_mode:normal>')

" file_rec検索時にfuzzymatchを有効にし、検索対象から指定のファイルを除外
"call denite#custom#source(
"    \ 'file_rec', 'matchers', ['matcher_fuzzy', 'matcher_project_files', 'matcher_ignore_globs'])

" matcherを高速なcpsmに変更
call denite#custom#source('file_rec', 'matchers', ['matcher_cpsm'])

" 検索対象外のファイル指定
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
    \ [ '.git/', '.ropeproject/', '__pycache__/',
    \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/',
    \   'deps/'])
