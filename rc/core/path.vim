vim9script
scriptencoding utf-8

# See also $VIMRUNTIME/xdg.vim

import "util.vim"

const VIM_DIRS = [
  util.StdPath("cache"),
  util.StdPath("data"),
  util.StdPath("data")  .. "/undo",
  util.StdPath("data")  .. "/view",
  util.StdPath("state"),
  util.StdPath("state") .. "/swap",
  util.StdPath("state") .. "/backup",
]

for d in VIM_DIRS
  if !isdirectory(d) | mkdir(d, "p", 0o700) | endif
endfor

execute 'set' 'packpath^=' .. fnameescape(util.StdPath("data"))
execute 'set' 'packpath+=' .. fnameescape(util.StdPath("data") .. "/after")

&undodir = util.StdPath("data") .. "/undo"
&viewdir = util.StdPath("data") .. "/view"

&directory = util.StdPath("state") .. "/swap//"
&backupdir = util.StdPath("state") .. "/backup//"

&viminfofile = util.StdPath("state") .. "/viminfo"

# vim: et sw=2:
