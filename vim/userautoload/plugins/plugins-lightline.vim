" lightline設定
" カスタムテーマの追加
let s:theme_dir = expand('~/.vim/dein/repos/github.com/itchyny/lightline.vim/autoload/lightline/colorscheme/')
let s:custom_theme = 'wombat_custom.vim'
if glob(s:theme_dir . s:custom_theme)
  execute '!ln -sf ~/.vim/colors/wombat_custom.vim ' . s:theme_dir
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
