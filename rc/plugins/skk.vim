vim9script
scriptencoding utf-8

if g:vimrc#input_method != "skk"
  finish
endif

minpac#add('vim-skk/eskk.vim')

set imdisable

g:eskk#egg_like_newline = 1
g:eskk#directory = vimrc#util#StdPath("data") .. "/eskk"

if filereadable("/usr/share/skk/SKK-JISYO.L")
  g:eskk#large_dictionary = "/usr/share/skk/SKK-JISYO.L"
endif

const mode_stl = {
  hira:    "あ",
  kata:    "ア",
  hankata: "_ｱ",
  abbrev:  "_A",
  ascii:   "_A",
  zenei:   "Ａ",
}

def SkkMode(): string
  if !eskk#is_enabled()
    return null_string
  endif
  return "▼" .. get(mode_stl, eskk#get_mode(), "_A")
enddef

augroup vimrc
  autocmd User eskk-initialize-post {
    g:lightline.component_function->extend({
      "skk_mode": expand("<SID>") .. "SkkMode" }
    )
    g:lightline.component_function_visible_condition->extend({
      "skk_mode": "eskk#is_enabled()" }
    )
    g:lightline.active.right[2]->insert("skk_mode")

    if exists('g:loaded_lightline')
      lightline#init()
      lightline#update()
    endif
  }

  # 自動補完中に変換開始できないことへの対応
  autocmd User eskk-enable-post {
    if trim(execute("setl ac?")) !~ "^--"
      b:vimrc_eskk_backup_ac = &l:ac
    endif
    &l:ac = false
  }
  autocmd User eskk-disable-post {
    if exists("b:vimrc_eskk_backup_ac")
      &l:ac = b:vimrc_eskk_backup_ac
      unlet b:vimrc_eskk_backup_ac
    else
      setlocal ac<
    endif
  }
augroup END

# vim: et sw=2:
