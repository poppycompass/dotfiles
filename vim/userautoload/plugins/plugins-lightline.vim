" lightline設定
" カスタムテーマの追加
let s:theme_dir = expand('~/.vim/dein/repos/github.com/itchyny/lightline.vim/autoload/lightline/colorscheme/')
let s:custom_theme = 'wombat_custom.vim'
let s:target_theme = 'wombat.vim'
if glob(s:theme_dir . s:custom_theme)
  execute '!cp -f ~/.vim/colors/' . s:custom_theme . ' ' . s:theme_dir . s:target_theme
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
