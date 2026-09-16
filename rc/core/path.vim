vim9script
scriptencoding utf-8

# See also $VIMRUNTIME/xdg.vim

const VIM_DIRS = [
  vimrc#util#StdPath("cache"),
  vimrc#util#StdPath("data"),
  vimrc#util#StdPath("data")  .. "/undo",
  vimrc#util#StdPath("data")  .. "/view",
  vimrc#util#StdPath("state"),
  vimrc#util#StdPath("state") .. "/swap",
  vimrc#util#StdPath("state") .. "/backup",
]

for d in VIM_DIRS
  if !isdirectory(d) | mkdir(d, "p", 0o700) | endif
endfor

execute 'set' 'packpath^=' .. fnameescape(vimrc#util#StdPath("data"))
execute 'set' 'packpath+=' .. fnameescape(vimrc#util#StdPath("data") .. "/after")

&undodir = vimrc#util#StdPath("data") .. "/undo"
&viewdir = vimrc#util#StdPath("data") .. "/view"

&directory = vimrc#util#StdPath("state") .. "/swap//"
&backupdir = vimrc#util#StdPath("state") .. "/backup//"

&viminfofile = vimrc#util#StdPath("state") .. "/viminfo"

# vim: et sw=2:
