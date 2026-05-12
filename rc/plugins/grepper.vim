vim9script
scriptencoding utf-8

g:grepper = {}
g:grepper.tools = ['git', 'rg', 'grep', 'findstr']

# :h grepper-faq-04
g:grepper.open = 0
autocmd vimrc User Grepper copen

# vim: et sw=2:
