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
    echoerr $"util.StdPath: \"{what}\" is not a valid stdpath"
    return null_string
  endif
enddef

# vim: et sw=2:
