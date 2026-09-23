vim9script
scriptencoding utf-8

var minpac_path = vimrc#util#SplitOption(&packpath)[0] .. "/pack/minpac/opt/minpac"
if !isdirectory(minpac_path)
  g:vimrc#first_install_progress = true

  echo "Install k-takata/minpac"
  mkdir(fnamemodify(minpac_path, ":p"), "p")
  execute "!git clone https://github.com/k-takata/minpac.git " .. shellescape(minpac_path)

  def FinishInstallCb(_, _, _)
    g:vimrc#first_install_progress = false
    vimrc#util#Reload()
    packloadall!
  enddef

  autocmd vimrc VimEnter * minpac#update("", { do: FinishInstallCb })
endif

packadd minpac

minpac#init()
minpac#add('k-takata/minpac', { type: 'opt' })

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
command! PackStatus call minpac#status()

# vim: et sw=2:
