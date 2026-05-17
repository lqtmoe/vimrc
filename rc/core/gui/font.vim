vim9script
scriptencoding utf-8

const FONTS = [
  ('UDEV Gothic NF',          11),
  ('PlemolJP NF',             10),
  ('HackGen NF',              11),
  ('UDEV Gothic',             11),
  ('PlemolJP',                10),
  ('HackGen',                 11),
  ('Ricty Discord',           11),
  ('Ricty Dminished Discord', 11),
  ('Ricty',                   11),
  ('Ricty Dminished',         11),
  ('VL Gothic',               11),
  ('ＭＳ ゴシック',           11),
]

if has('gui_gtk') && executable("fc-list")
  var system_font_list = systemlist("env LC_ALL=C fc-list --format='%{family[0]}\\n'")
  set guifont=monospace\ 11
  for [font_name, font_size] in FONTS
    if index(system_font_list, font_name) > -1
      &guifont = font_name .. ' ' .. font_size
      break
    endif
  endfor
elseif has('gui_win32')
  set guifont=
  for [font_name, font_size] in FONTS
    execute 'set' 'guifont+=' .. substitute(font_name, '\s', '_', 'g') .. ':h' .. font_size
  endfor
  set guifont+=monospace:h11
endif

# vim: et sw=2:
