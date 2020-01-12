let g:ale_linters = {
  \   'javascript': ['eslint'],
  \}
" 常にシンボルカラムの表示
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
" ステータスラインにエラー数を表示
"let g:lightline = {
"  \'active': {
"  \  'left': [
"  \    ['mode', 'paste'],
"  \    ['readonly', 'filename', 'modified', 'ale'],
"  \  ]
"  \},
"  \'component_function': {
"  \  'ale': 'ALEGetStatusLine'
"  \}
"  \ }
"let g:ale_statusline_format = ['x %d', '! %d', 'o ok']
" ファイル保存時にチェック
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
" ファイルオープン時にチェックしない
let g:ale_lint_on_enter = 0
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" Formatter設定
let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'python': ['black'],
  \ }
let g:ale_fix_on_save = 1
