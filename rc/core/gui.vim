scriptencoding utf-8

if !has('gui_running')
  finish
endif

set guioptions+=M
set guioptions+=a
set guioptions-=e
set guioptions-=T
set guioptions-=m
set guioptions-=b
set guioptions-=l guioptions-=L
set guioptions-=r guioptions-=R

if has('kaoriya')
  set guioptions+=C
endif

if has('vim_starting')
  set columns=140
  set lines=48
endif

" vim: et sw=2:
