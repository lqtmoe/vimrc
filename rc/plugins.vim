vim9script
scriptencoding utf-8

if !&loadplugins
  finish
endif

# カスタマイズ変数
# g:vimrc_denops_enable - denopsとdenopsに依存するプラグインを利用可能にする
if !exists('g:vimrc_denops_enable')
  g:vimrc_denops_enable = executable(get(g:, 'denops#deno', 'deno'))
endif
# g:vimrc_nerdfont_enable - NerdFontによる装飾を有効にする
if !exists('g:vimrc_nerdfont_enable')
  g:vimrc_nerdfont_enable = 1
endif
# g:vimrc_input_method - インプットメソッドを選択する
if !exists('g:vimrc_input_method')
  if g:vimrc_denops_enable
    g:vimrc_input_method = 'skkeleton'
  else
    g:vimrc_input_method = 'eskk'
  endif
endif

runtime rc/plugins/builtin.vim
runtime rc/plugins/plug.vim
runtime rc/plugins/denops.vim
runtime rc/plugins/lightline.vim
runtime rc/plugins/simplenine.vim
runtime rc/plugins/fern.vim
runtime rc/plugins/lsp.vim
runtime rc/plugins/fzf.vim
runtime rc/plugins/startify.vim
runtime rc/plugins/skk.vim
runtime rc/plugins/vimwiki.vim
runtime rc/plugins/tagbar.vim
runtime rc/plugins/rooter.vim
runtime rc/plugins/grepper.vim
runtime rc/plugins/lexima.vim
runtime rc/plugins/brightest.vim
runtime rc/plugins/ambiwidth.vim
runtime rc/plugins/misc.vim

# vim: et sw=2:
