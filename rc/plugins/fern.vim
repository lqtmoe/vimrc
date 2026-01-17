scriptencoding utf-8

augroup vimrc
  " Fernのバッファは行番号を非表示にする
  autocmd FileType fern setlocal nonumber

  " 矢印キーで開閉操作ができるようにする
  autocmd FileType fern nmap <buffer><silent> <Right> <Plug>(fern-action-open-or-expand)
  autocmd FileType fern nmap <buffer><silent> <Left> <Plug>(fern-action-collapse)
augroup END

if g:vimrc_nerdfont_enable
  let g:fern#renderer = 'nerdfont'
endif

" vim: et sw=2:
