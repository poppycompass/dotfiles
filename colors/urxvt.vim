" urxvt向けのcolor scheme
" urxvt向けだから256色を想定している．
" CUI向けの色であることに注意
" ~/vim/colors/以下におく
let g:urxvt = expand('<sfile>:t:r')
"set background=dark
"highlight clear

" highlight {group-name} {key}={arg} ...
"  指定できるパラメータは :help attr-list を参照
" cterm: CUI版のVimで使われる文字色，guifgはGUI版の色.
" 前景色，背景色はCUIでは色名か色番号，GUIでは色名か＃RRGGBBで指定できる
" 色名については :help cterm-colors, :help gui-colorsを参照
" :highlight で割り当てを確認して，:colorscheme urxvtで反映
highlight CursorLine term=none cterm=none ctermfg=none ctermbg=236
highlight LineNr term=none cterm=none ctermfg=yellow ctermbg=none
" 現在選択行数字の色
highlight CursorLineNr term=none cterm=none ctermfg=red ctermbg=none
highlight Comment term=none    cterm=italic ctermfg=45  ctermbg=none
highlight ErrorMsg term=standout cterm=standout ctermfg=160 ctermbg=255
" 下のファイル名や行数表示部分
highlight StatusLine term=bold,reverse cterm=bold,reverse ctermfg=darkblue ctermbg=255
" 現在選択中のバッファ以外
highlight StatusLineNC term=bold,reverse cterm=bold,reverse ctermfg=255 ctermbg=0
highlight default link WarningMsg ErrMsg
highlight WarningMsg term=standout cterm=standout ctermfg=160 ctermbg=255
highlight Search  term=reverse cterm=none   ctermfg=237 ctermbg=220
highlight CursorColumn term=reverse cterm=reverse ctermfg=none ctermbg=none
highlight Visual term=reverse cterm=reverse ctermfg=none ctermbg=none
highlight Constant term=underline cterm=none ctermfg=255 ctermbg=none
highlight Directory term=bold cterm=bold ctermfg=12 ctermbg=none
highlight SpecialKey term=bold cterm=bold ctermfg=12 ctermbg=none
highlight ModeMsg term=bold cterm=bold ctermfg=255 ctermbg=none
highlight Statement term=none cterm=none ctermfg=yellow ctermbg=none
highlight Identifier term=none cterm=none ctermfg=2 ctermbg=none
highlight Label term=none cterm=none ctermfg=1 ctermbg=none
highlight String term=none cterm=none ctermfg=160 ctermbg=none
highlight Function term=none cterm=none ctermfg=2 ctermbg=none 
" NonTextは改行文字"$"など
highlight NonText term=none cterm=none ctermfg=12 ctermbg=none
highlight Character term=none cterm=none ctermfg=160 ctermbg=none
" <Ctrl-W> の'Ctrl-W'
highlight Special term=none cterm=none ctermfg=171 ctermbg=none
" <Ctrl-W> の'<', '>'
highlight Delimiter term=none cterm=none ctermfg=171 ctermbg=none
highlight Numer term=none cterm=none ctermfg=160 ctermbg=none
highlight Float term=none cterm=none ctermfg=160 ctermbg=none
highlight Boolean term=none cterm=none ctermfg=39 ctermbg=none
highlight Conceal term=none cterm=none  ctermfg=47 ctermbg=none
" Ctrl+pの背景色
highlight Pmenu term=reverse cterm=reverse ctermfg=244 ctermbg=16
" Ctrl+pの選択行
highlight PmenuSel term=reverse cterm=reverse ctermfg=219 ctermbg=16
highlight Label term=bold cterm=bold ctermfg=33 ctermbg=none
" none, 91とかの設定数値の色
highlight PreProc term=none cterm=none ctermfg=183 ctermbg=none

