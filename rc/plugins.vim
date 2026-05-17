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

LoadConfig plugins/builtin.vim
LoadConfig plugins/plug.vim
LoadConfig plugins/denops.vim
LoadConfig plugins/lightline.vim
LoadConfig plugins/simplenine.vim
LoadConfig plugins/fern.vim
LoadConfig plugins/lsp.vim
LoadConfig plugins/fzf.vim
LoadConfig plugins/startify.vim
LoadConfig plugins/skk.vim
LoadConfig plugins/vimwiki.vim
LoadConfig plugins/tagbar.vim
LoadConfig plugins/rooter.vim
LoadConfig plugins/grepper.vim
LoadConfig plugins/lexima.vim
LoadConfig plugins/brightest.vim
LoadConfig plugins/ambiwidth.vim
LoadConfig plugins/misc.vim

# vim: et sw=2:
