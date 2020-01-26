" ALEGetStatusLine is deprecated
let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'python': ['flake8'],
  \   'ruby': ['rubocop'],
  \   'rust': ['rustfmt'],
  \}
" 常にシンボルカラムの表示
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_statusline_format = ['x %d', '! %d', 'o ok']
" ファイル保存時にチェック
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
" ファイルオープン時にチェックしない
let g:ale_lint_on_enter = 0
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_open_list = 1
nmap <silent> ,k <Plug>(ale_previous_wrap)
nmap <silent> ,j <Plug>(ale_next_wrap)
" Formatter設定
let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'javascript':['eslint'],
  \   'python': ['autopep8', 'black', 'isort'],
  \   'ruby': ['rubocop'],
  \   'rust': ['rustfmt'],
  \ }
let g:ale_fix_on_save = 1
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
