vim9script
scriptencoding utf-8

minpac#add('vim-skk/eskk.vim')

if vimrc#input_method == "eskk"
  set imdisable

  g:eskk#egg_like_newline = 1
  g:eskk#directory = vimrc#util#StdPath("data") .. "/eskk"

  if filereadable("/usr/share/skk/SKK-JISYO.L")
    g:eskk#large_dictionary = "/usr/share/skk/SKK-JISYO.L"
  endif

  augroup vimrc
    # 自動補完中に変換開始できないことへの対応
    autocmd vimrc User eskk-enable-post {
      if trim(execute("setl ac?")) !~ "^--"
        b:vimrc_eskk_backup_ac = &l:ac
      endif
      &l:ac = false
    }
    autocmd vimrc User eskk-disable-post {
      if exists("b:vimrc_eskk_backup_ac")
        &l:ac = b:vimrc_eskk_backup_ac
        unlet b:vimrc_eskk_backup_ac
      else
        setlocal ac<
      endif
    }
  augroup END
endif

# vim: et sw=2:
