vim9script
scriptencoding utf-8

import "util.vim"
import "simplenine.vim"

if g:vimrc_input_method == "eskk"
  set imdisable

  g:eskk#egg_like_newline = 1
  g:eskk#directory = util.StdPath("data") .. "/eskk"

  if filereadable("/usr/share/skk/SKK-JISYO.L")
    g:eskk#large_dictionary = "/usr/share/skk/SKK-JISYO.L"
  endif

  def SetupSimpleNineEskk()
    simplenine#UpdateComponents(
      (c: list<simplenine.Component>) => c->add(
        simplenine.FunctionComponent.new(
          (_: bool): string => get(
            g:eskk#statusline_mode_strings,
            eskk#get_mode(),
            "Aa"
          ),
          (active: bool): bool => active && eskk#is_enabled()
        )
      )
    )
  enddef

  autocmd vimrc User eskk-initialize-post SetupSimpleNineEskk()
endif

# vim: et sw=2:
