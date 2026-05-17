vim9script
scriptencoding utf-8

set nowrap
set sidescroll=1
set fillchars+=vert:┃
set list
set listchars=tab:^\ ,nbsp:.,extends:>,precedes:<
set number

if has('gui_running') && has('vim_starting')
  set columns=140
  set lines=48
endif

# vim: et sw=2:
