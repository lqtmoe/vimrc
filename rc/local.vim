scriptencoding utf-8

for s:local_vim in glob(g:vimrc_stdpath['config'] .. '/rc/local/*.vim', v:false, v:true)
  execute 'source' s:local_vim
endfor
unlet! s:local_vim

" vim: et sw=2:
