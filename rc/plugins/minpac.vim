vim9script
scriptencoding utf-8

var minpac_path = vimrc#util#SplitOption(&packpath)[0] .. "/pack/minpac/opt/minpac"
if !isdirectory(minpac_path)
  echo "Install k-takata/minpac"
  mkdir(fnamemodify(minpac_path, ":p"), "p")
  execute "!git clone https://github.com/k-takata/minpac " .. shellescape(minpac_path)

  autocmd vimrc VimEnter * minpac#update()
endif

packadd minpac

minpac#init()
minpac#add('k-takata/minpac', { type: 'opt' })

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
command! PackStatus call minpac#status()

# vim: et sw=2:
