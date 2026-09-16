vim9script
scriptencoding utf-8

import "util.vim"

minpac#add('vim-skk/eskk.vim')

if g:vimrc_input_method == "eskk"
  set imdisable

  g:eskk#egg_like_newline = 1
  g:eskk#directory = util.StdPath("data") .. "/eskk"

  if filereadable("/usr/share/skk/SKK-JISYO.L")
    g:eskk#large_dictionary = "/usr/share/skk/SKK-JISYO.L"
  endif
endif

# vim: et sw=2:
