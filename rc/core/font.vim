scriptencoding utf-8

if !has('gui_running')
  finish
endif

let s:fonts = [['UDEV Gothic NF'          , 11],
      \        ['PlemolJP Console NFJ'    , 10],
      \        ['PlemolJP Console NF'     , 10],
      \        ['HackGen Console NFJ'     , 11],
      \        ['UDEV Gothic'             , 11],
      \        ['PlemolJP Console'        , 10],
      \        ['HackGen Console'         , 11],
      \        ['Ricty Discord'           , 11],
      \        ['Ricty Dminished Discord' , 11],
      \        ['Ricty'                   , 11],
      \        ['Ricty Dminished'         , 11],
      \        ['VL Gothic'               , 11],
      \        ['ＭＳ ゴシック'           , 11],
      \        ['monospace'               , 11]]

if has('gui_gtk')
  let s:system_font_list = systemlist('env LC_ALL=C fc-list --format=' .. shellescape('%{family[0]}\n'))
  for [s:font_name, s:font_size] in s:fonts
    if index(s:system_font_list, s:font_name) > -1
      let &guifont = s:font_name .. ' ' .. s:font_size
      break
    endif
  endfor
  unlet s:system_font_list s:font_name s:font_size
elseif has('gui_win32')
  set guifont=
  for [s:font_name, s:font_size] in s:fonts
    execute 'set' 'guifont+=' .. substitute(s:font_name, '\s', '_', 'g') .. ':h' .. s:font_size
  endfor
  unlet s:font_name s:font_size
  if has('directx')
    set renderoptions=type:directx,renmode:5
  endif
endif

" vim: et sw=2:
