" quickrunで開く窓を水平分割にする
" quickrun横分割時は下へ，縦分割時は右に新しいウィンドウが開く
" 'c/gcc'などで設定した内容は :QuickRun c/gccで実行
" '_'は全部に対する設定
let g:quickrun_config={
            \ '_': {
            \    'runner' : 'vimproc',
            \    'updatetime' : 40,
            \    'outputter' : 'error:buffer:quickfix',
            \    'split': '',
            \    'outputter/buffer/close_on_empty' : 0,
            \    'runner/vimproc/updatetime' : 60,
            \},
          \}

" 実行時に前回の表示内容をクローズ&保存してから実行
let g:quickrun_no_default_key_mappings = 1
nmap <Leader>r :cclose<CR>:write<CR>:QuickRun -mode n<CR>
