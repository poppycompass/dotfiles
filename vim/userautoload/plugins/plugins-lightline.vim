" lightline設定
" カスタムテーマの追加
let s:theme_dir = expand('~/.vim/dein/repos/github.com/itchyny/lightline.vim/autoload/lightline/colorscheme/')
let s:cache_dir = expand('~/.vim/dein/.cache/init.vim/.dein/autoload/lightline/colorscheme/')
let s:custom_theme = 'wombat_custom.vim'
let s:target_theme = 'wombat.vim'
if !filereadable(s:theme_dir . s:custom_theme)
  execute '!cp -f ~/.vim/colors/' . s:custom_theme . ' ' . s:theme_dir . s:target_theme
  execute '!cp -f ~/.vim/colors/' . s:custom_theme . ' ' . s:cache_dir . s:target_theme
  execute '!cp -f ~/.vim/colors/' . s:custom_theme . ' ' . s:theme_dir . s:custom_theme
endif

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'separator': { 'left': "〉", 'right': "〈" },
      \ 'subseparator': { 'left': "〈", 'right': "〈" },
      \ 'component': {
      \   'readonly': '%{&readonly?"!RO!":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}'
      \ },
      \ 'active': {
      \   'left' : [  [ 'mode', 'paste' ],
      \               [ 'readonly', 'filename', 'modified' ],
      \               [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]  ],
      \   'right': [  [ 'lineinfo' ],
      \               [ 'percent' ],
      \               [ 'fileformat', 'fileencoding', 'filetype' ]  ]
      \ },
      \ 'component_expand': {
      \   'linter_checking': 'lightline#ale#checking',
      \   'linter_warnings': 'lightline#ale#warnings',
      \   'linter_errors': 'lightline#ale#errors',
      \   'linter_ok': 'lightline#ale#ok',
      \ },
      \ 'component_type': {
      \   'linter_checking': 'left',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'left',
      \ }
      \ }
