vim9script
scriptencoding utf-8

const FONTS = [
  ('UDEV Gothic NF',          11, true),
  ('PlemolJP NF',             10, true),
  ('HackGen NF',              11, true),
  ('UDEV Gothic',             11, false),
  ('PlemolJP',                10, false),
  ('HackGen',                 11, false),
  ('Ricty Discord',           11, false),
  ('Ricty Dminished Discord', 11, false),
  ('Ricty',                   11, false),
  ('Ricty Dminished',         11, false),
  ('VL Gothic',               11, false),
  ('ＭＳ ゴシック',           11, false),
]

if has('gui_gtk') && executable("fc-list")
  var system_font_list = vimrc#util#GetSystemFontList()
  set guifont=monospace\ 11
  for [font_name, font_size, is_nerdfonts] in FONTS
    if index(system_font_list, font_name) > -1
      &guifont = font_name .. ' ' .. font_size
      if is_nerdfonts && !has_key(environ(), "VIMRC_NERDFONTS_ENABLE")
        g:vimrc#nerdfonts_enable = true
      endif
      break
    endif
  endfor
elseif has('gui_win32')
  set guifont=
  for [font_name, font_size, _] in FONTS
    execute 'set' 'guifont+=' .. substitute(font_name, '\s', '_', 'g') .. ':h' .. font_size
  endfor
  set guifont+=monospace:h11
endif

# vim: et sw=2:
