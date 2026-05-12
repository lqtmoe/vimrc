vim9script
scriptencoding utf-8

import "util.vim"
import "simplenine.vim"

if g:vimrc_input_method == "skkeleton"
  set imdisable

  imap <C-j> <Plug>(skkeleton-enable)
  cmap <C-j> <Plug>(skkeleton-enable)
  tmap <C-j> <Plug>(skkeleton-enable)

  g:vimrc_skkeleton_config = {
    eggLikeNewline: true
  }

  def SetupSimpleNine()
    var components = simplenine#GetComponents()

    components->add(
      simplenine.FunctionComponent.new(
        (_: bool): string => get(
          { hira: "あ", kata: "ア", hankata: "ｱ", zenkaku: "Ａ", abbrev: "あ" },
          skkeleton#mode(),
          "Aa"
        ),
        (active: bool): bool => active && skkeleton#is_enabled()
      )
    )

    simplenine#SetComponents(components)
  enddef

  autocmd vimrc User skkeleton-initialize-pre skkeleton#config(g:vimrc_skkeleton_config)
  autocmd vimrc User skkeleton-initialize-post SetupSimpleNine()
endif

if g:vimrc_input_method == "eskk"
  set imdisable

  g:eskk#egg_like_newline = 1
  g:eskk#directory = util.StdPath("config") .. "/eskk"

  def SetupSimpleNine()
    var components = simplenine#GetComponents()

    components->add(
      simplenine.FunctionComponent.new(
        (_: bool): string => get(
          g:eskk#statusline_mode_strings,
          eskk#get_mode(),
          "Aa"
        ),
        (active: bool): bool => active && eskk#is_enabled()
      )
    )

    simplenine#SetComponents(components)
  enddef

  autocmd vimrc User eskk-initialize-post SetupSimpleNine()
endif

# vim: et sw=2:
