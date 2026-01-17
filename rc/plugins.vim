scriptencoding utf-8

if v:version < 802
  finish
endif

if !&loadplugins
  finish
endif

" カスタマイズ変数
" g:vimrc_denops_enable - denopsとdenopsに依存するプラグインを利用可能にする
if !exists('g:vimrc_denops_enable')
  let g:vimrc_denops_enable = v:version >= 901 && executable(get(g:, 'denops#deno', 'deno'))
endif
" g:vimrc_nerdfont_enable - NerdFontによる装飾を有効にする
if !exists('g:vimrc_nerdfont_enable')
  let g:vimrc_nerdfont_enable = 1
endif
" g:vimrc_input_method - インプットメソッドを選択する
if !exists('g:vimrc_input_method')
  if g:vimrc_denops_enable
    let g:vimrc_input_method = 'skkeleton'
  else
    let g:vimrc_input_method = 'eskk'
  endif
endif

execute 'source' g:vimrc_stdpath['config'] . '/rc/plugins/builtin.vim'
execute 'source' g:vimrc_stdpath['config'] . '/rc/plugins/plug.vim'
execute 'source' g:vimrc_stdpath['config'] . '/rc/plugins/denops.vim'
execute 'source' g:vimrc_stdpath['config'] . '/rc/plugins/lightline.vim'
execute 'source' g:vimrc_stdpath['config'] . '/rc/plugins/fern.vim'
execute 'source' g:vimrc_stdpath['config'] . '/rc/plugins/lsp.vim'
execute 'source' g:vimrc_stdpath['config'] . '/rc/plugins/fzf.vim'
execute 'source' g:vimrc_stdpath['config'] . '/rc/plugins/startify.vim'
execute 'source' g:vimrc_stdpath['config'] . '/rc/plugins/skk.vim'
execute 'source' g:vimrc_stdpath['config'] . '/rc/plugins/vimwiki.vim'
execute 'source' g:vimrc_stdpath['config'] . '/rc/plugins/tagbar.vim'
execute 'source' g:vimrc_stdpath['config'] . '/rc/plugins/rooter.vim'
execute 'source' g:vimrc_stdpath['config'] . '/rc/plugins/grepper.vim'
execute 'source' g:vimrc_stdpath['config'] . '/rc/plugins/lexima.vim'
execute 'source' g:vimrc_stdpath['config'] . '/rc/plugins/brightest.vim'
execute 'source' g:vimrc_stdpath['config'] . '/rc/plugins/ambiwidth.vim'
execute 'source' g:vimrc_stdpath['config'] . '/rc/plugins/nord.vim'
execute 'source' g:vimrc_stdpath['config'] . '/rc/plugins/misc.vim'

" vim: et sw=2:
