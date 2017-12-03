" shortcuts for global

" FIRST OF ALL ACTION, YOU MUST EXECUTE
" '$ gtags -v'
" INTO SOURCES YOU WANT TO READ.

" Usage: 
" :source shortcut_global.vim

" if you want grep among source
" <C-g> and -g <func><CR>
nmap <C-\><C-g> :Gtags
" 今開いているコードの関数一覧がQuickfix Listに表示
nmap <C-\><C-l> :Gtags -f %<CR>
" 定義先へ飛ぶ
nmap <C-s> :GtagsCursor<CR>
" カーソル以下の使用箇所を探す
nmap <C-\><C-k> :Gtags -r <C-r><C-w><CR>
" open preview window and output word under the cursor
nmap <C-d> :execute 'psearch ' . expand('<cword>')<CR>
" Quickfixでの移動
nmap [q :cn<CR>
nmap ]q :cp<CR>
nmap [Q :<C-u>cfirst<CR>
nmap ]Q :<C-u>clast<CR>
