scriptencoding utf-8

let g:brightest#enable_on_CursorHold = 1
let g:brightest#highlight = #{ group: 'Visual' }
if exists('##ModeChanged')
  " ビジュアルモードに入った時にBrightestのハイライト(Visual)を消去する
  autocmd vimrc ModeChanged *:[vV\x16]* BrightestClear
endif

" vim: et sw=2:
