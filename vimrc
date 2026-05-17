vim9script
set encoding=utf-8
scriptencoding utf-8

source $VIMRUNTIME/defaults.vim

augroup vimrc | autocmd! | augroup END

import "util.vim"

def LoadConfig(bang: bool, config: string)
  var config_path = util.StdPath("config") .. "/rc/" .. config
  if filereadable(config_path)
    execute "source" fnameescape(config_path)
  else
    if !bang
      echohl WarningMsg | echomsg "Failed to load file: " .. config | echohl None
    endif
  endif
enddef
command -nargs=1 -bang LoadConfig LoadConfig(<bang>0, <q-args>)

LoadConfig core.vim
LoadConfig extra.vim
LoadConfig plugins.vim

LoadConfig! local.vim

delcommand LoadConfig

# vim: et sw=2:
