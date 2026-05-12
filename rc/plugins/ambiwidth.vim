vim9script
scriptencoding utf-8

g:ambiwidth_add_list = []
g:ambiwidth_cica_enabled = v:false

if g:vimrc_nerdfont_enable
  # https://github.com/ryanoasis/nerd-fonts/wiki/Glyph-Sets-and-Code-Points
  # Seti-UI + Custom
  g:ambiwidth_add_list->add([0xe5fa, 0xe62d, 2])
  # プラグイン側の定義と重複するためコメントアウト
  #g:ambiwidth_add_list->add([0xe62e, 0xe62e, 2])
  g:ambiwidth_add_list->add([0xe62f, 0xe6b1, 2])
  # Devicons
  g:ambiwidth_add_list->add([0xe700, 0xe7c5, 2])
  # Font Awesome
  g:ambiwidth_add_list->add([0xf000, 0xf2e0, 2])
  # Font Awesome Extension
  g:ambiwidth_add_list->add([0xe200, 0xe2a9, 2])
  # Material Design Icons
  g:ambiwidth_add_list->add([0xf0001, 0xf1af0, 2])
  # Weather
  g:ambiwidth_add_list->add([0xe300, 0xe3e3, 2])
  # Octicons
  g:ambiwidth_add_list->add([0xf400, 0xf532, 2])
  #g:ambiwidth_add_list->add([0x2665, 0x2665, 2])
  #g:ambiwidth_add_list->add([0x26a1, 0x26a1, 2])
  # Powerline Symbols
  #g:ambiwidth_add_list->add([0xe0a0, 0xe0a2, 2])
  #g:ambiwidth_add_list->add([0xe0b0, 0xe0b3, 2])
  # Powerline Extra Symbols
  #g:ambiwidth_add_list->add([0xe0a3, 0xe0a3, 2])
  #g:ambiwidth_add_list->add([0xe0b4, 0xe0c8, 2])
  #g:ambiwidth_add_list->add([0xe0ca, 0xe0ca, 2])
  #g:ambiwidth_add_list->add([0xe0cc, 0xe0d4, 2])
  # IEC Power Symbols
  g:ambiwidth_add_list->add([0x23fb, 0x23fe, 2])
  g:ambiwidth_add_list->add([0x2b58, 0x2b58, 2])
  # Font Logos
  g:ambiwidth_add_list->add([0xf300, 0xf314, 2])
  # プラグイン側の定義と重複するためコメントアウト
  #g:ambiwidth_add_list->add([0xf315, 0xf316, 2])
  g:ambiwidth_add_list->add([0xf317, 0xf31a, 2])
  # プラグイン側の定義と重複するためコメントアウト
  #g:ambiwidth_add_list->add([0xf31b, 0xf31c, 2])
  g:ambiwidth_add_list->add([0xf31d, 0xf372, 2])
  # Pomicons
  g:ambiwidth_add_list->add([0xe000, 0xe00a, 2])
  # Codicons
  g:ambiwidth_add_list->add([0xea60, 0xebeb, 2])
endif

# vim: et sw=2:
