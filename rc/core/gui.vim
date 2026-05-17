vim9script
scriptencoding utf-8

if !has('gui_running')
  finish
endif

set guioptions+=a
set guioptions+=C
set guioptions-=e
set guioptions-=T
set guioptions-=m guioptions+=M
set guioptions-=r guioptions-=R
set guioptions-=l guioptions-=L
set guioptions-=b

if has('directx')
  set renderoptions=type:directx,renmode:5
endif

LoadConfig core/gui/font.vim

# vim: et sw=2:
