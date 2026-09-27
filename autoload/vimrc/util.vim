vim9script
scriptencoding utf-8

export def SplitOption(option: string): list<string>
  return split(option, '\%(^\|[^\\]\)\%(\\\\\)*\zs,')->map((_, v) => substitute(substitute(v, '\\\\', '\\', 'g'), '\\,', ',', 'g'))
enddef

const STD_PATH_CONFIG = SplitOption(&rtp)[0]
const STD_PATH_CACHE  = has("unix") ? empty($XDG_CACHE_HOME) ? expand("~/.cache/vim")       : expand("$XDG_CACHE_HOME/vim") : has("win32") ? expand("$TEMP/vim-data")         : expand("~/.vim")
const STD_PATH_DATA   = has("unix") ? empty($XDG_DATA_HOME)  ? expand("~/.local/share/vim") : expand("$XDG_DATA_HOME/vim")  : has("win32") ? expand("$LOCALAPPDATA/vim-data") : expand("~/.vim")
const STD_PATH_STATE  = has("unix") ? empty($XDG_STATE_HOME) ? expand("~/.local/state/vim") : expand("$XDG_STATE_HOME/vim") : has("win32") ? expand("$LOCALAPPDATA/vim-data") : expand("~/.vim")

export def StdPath(what: string): string
  if what == "config"
    return STD_PATH_CONFIG
  elseif what == "cache"
    return STD_PATH_CACHE
  elseif what == "data"
    return STD_PATH_DATA
  elseif what == "state"
    return STD_PATH_STATE
  else
    echoerr $"vimrc#util#StdPath: \"{what}\" is not a valid stdpath"
    return null_string
  endif
enddef

export def SystemList(expr: list<string>): list<string>
  var tmpfile = tempname()
  defer delete(tmpfile)

  var job_object = job_start(
    expr,
    {
      in_io: "null",
      err_io: "null",
      out_io: "file",
      out_name: tmpfile,
    }
  )

  while job_status(job_object) == "run"
    sleep 10m
  endwhile

  return filereadable(tmpfile) ? readfile(tmpfile) : []
enddef

export def System(expr: list<string>): string
  return SystemList(expr)->join("\\n")
enddef

var system_font_list = null_list

def GetSystemFontList_FontConfig(): list<string>
  if !executable("fc-list")
    return []
  endif

  return SystemList(["env", "LC_ALL=C", "fc-list", "--format=%{family[0]}\\n"])
enddef

export def GetSystemFontList(force_update: bool = false): list<string>
  if system_font_list isnot null_list && !force_update
    return system_font_list
  endif

  system_font_list = []

  if has("gui_gtk")
    system_font_list = GetSystemFontList_FontConfig()
  endif

  return copy(system_font_list)
enddef

var reloading = false

export def Reload()
  if v:vim_did_init && !reloading
    reloading = true
    echo $"vimrc#util#Reload: Reload \"{$MYVIMRC}\""
    execute 'source' $MYVIMRC
    reloading = false
  else
    echoerr "vimrc#util#Reload: Cannot reload recursively"
  endif
enddef

# vim: et sw=2:
