vim9script
scriptencoding utf-8

def LspErrorCount(): string
  var count = len(filter(
    lsp#diag#GetDiagsForBuf(),
    (_, val) => val.severity == 1
  ))

  if count > 0
    return (g:vimrc#nerdfonts_enable ? "\uf05e " : "E:") .. count
  else
    return null_string
  endif
enddef

def LspWarningCount(): string
  var count = len(filter(
    lsp#diag#GetDiagsForBuf(),
    (_, val) => val.severity == 2
  ))

  if count > 0
    return (g:vimrc#nerdfonts_enable ? "\uf071 " : "W:") .. count
  else
    return null_string
  endif
enddef

augroup vimrc
  autocmd User LspSetup {
    g:lightline.component_expand->extend({
      "lsp_error": expand("<SID>") .. "LspErrorCount",
      "lsp_warning": expand("<SID>") .. "LspWarningCount" }
    )
    g:lightline.component_type->extend({
      "lsp_error": "error",
      "lsp_warning": "warning" }
    )
    g:lightline.active.right[0]->add("lsp_warning")
    g:lightline.active.right[0]->add("lsp_error")

    if exists('g:loaded_lightline')
      lightline#init()
      lightline#update()
    endif
  }

  autocmd User LspDiagsUpdated {
    if exists('g:loaded_lightline')
      lightline#update()
    endif
  }
augroup END

# vim: et sw=2:
