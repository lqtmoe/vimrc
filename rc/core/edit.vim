vim9script
scriptencoding utf-8

if has("persistent_undo")
  set noundofile
endif

set complete^=o
set autocomplete
set completeopt=menuone,popuphidden,noinsert

# vim: et sw=2:
