vim9script
scriptencoding utf-8

if !has('gui_running')
  finish
endif

var fonts = [('UDEV Gothic NF',          11),
      \      ('PlemolJP Console NFJ',    10),
      \      ('PlemolJP Console NF',     10),
      \      ('HackGen Console NFJ',     11),
      \      ('UDEV Gothic',             11),
      \      ('PlemolJP Console',        10),
      \      ('HackGen Console',         11),
      \      ('Ricty Discord',           11),
      \      ('Ricty Dminished Discord', 11),
      \      ('Ricty',                   11),
      \      ('Ricty Dminished',         11),
      \      ('VL Gothic',               11),
      \      ('ＭＳ ゴシック',           11),
      \      ('monospace',               11)]

if has('gui_gtk')
  var system_font_list = systemlist("env LC_ALL=C fc-list --format='%{family[0]}\\n'")
  for [font_name, font_size] in fonts
    if index(system_font_list, font_name) > -1
      &guifont = font_name .. ' ' .. font_size
      break
    endif
  endfor
elseif has('gui_win32')
  set guifont=
  for [font_name, font_size] in fonts
    execute 'set' 'guifont+=' .. substitute(font_name, '\s', '_', 'g') .. ':h' .. font_size
  endfor
  if has('directx')
    set renderoptions=type:directx,renmode:5
  endif
endif

# vim: et sw=2:
