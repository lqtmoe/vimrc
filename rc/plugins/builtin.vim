vim9script
scriptencoding utf-8

g:loaded_netrw = 1
g:loaded_netrwPlugin = 1

if has('packages')
  packadd! matchit
  packadd! termdebug
  packadd! editorconfig
endif

if executable('man')
  runtime ftplugin/man.vim
endif

# vim: et sw=2:
