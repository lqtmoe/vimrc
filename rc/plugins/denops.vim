scriptencoding utf-8

if g:vimrc_denops_enable
  " 推奨設定(denops-recommended 参照)
  noremap <silent> <C-c> <Cmd>call denops#interrupt()<CR><C-c>
  inoremap <silent> <C-c> <Cmd>call denops#interrupt()<CR><C-c>
  cnoremap <silent> <C-c> <Cmd>call denops#interrupt()<CR><C-c>
  command! DenopsRestart call denops#server#restart()
  command! DenopsFixCache call denops#cache#update(#{reload: v:true})
endif

" vim: et sw=2:
