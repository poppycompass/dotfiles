" 自動構文チェック(c/cpp), 重いから無効化中
let g:syntastic_mode_map = { 'mode': 'passive' }
augroup AutoSyntastic
  autocmd!
  " 構文チェックのファイルタイプはここで指定．現在半無効化
  "autocmd BufWritePost *.c,*.cpp call s:syntastic()
  autocmd BufWritePost *.none call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction
