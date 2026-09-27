vim9script
scriptencoding utf-8

minpac#add('yegappan/lsp')
minpac#add('hrsh7th/vim-vsnip')
minpac#add('hrsh7th/vim-vsnip-integ')

g:lsp_options = {
  autoComplete: false,
  omniComplete: true,
  condensedCompletionMenu: true,
  snippetSupport: true,
  vsnipSupport: true,
  semanticHighlight: true,
  showDiagWithVirtualText: true,
  diagVirtualTextAlign: "below",
  showInlayHints: true,
  incrementalSync: true,
}

if g:vimrc#nerdfonts_enable
  g:lsp_options.diagSignErrorText = "\uf05e"
  g:lsp_options.diagSignWarningText = "\uf071"
endif

# clangd
if executable("clangd")
  g:vimrc#lsp_servers->add({
    name: "clangd",
    filetype: ["c", "cpp"],
    path: "clangd",
    args: ['--clang-tidy', '--header-insertion=never']
  })
endif

# rust-analyzer
if executable("rust-analyzer")
  g:vimrc#lsp_servers->add({
    name: "rust-analyzer",
    filetype: ["rust"],
    path: "rust-analyzer"
  })
endif

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
    if !empty(g:vimrc#lsp_servers)
      g:LspAddServer(deepcopy(g:vimrc#lsp_servers))
    endif
  }

  autocmd User LspSetup {
    g:lightline.component_expand->extend({
      "lsp_error": expand("<SID>") .. "LspErrorCount",
      "lsp_warning": expand("<SID>") .. "LspWarningCount" }
    )
    g:lightline.component_type->extend({
      "lsp_error": "error",
      "lsp_warning": "warning" }
    )
    g:lightline.active.right[0]->insert("lsp_error")
    g:lightline.active.right[0]->insert("lsp_warning")

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

  autocmd User LspAttached {
    nnoremap <buffer> <silent> gd <Cmd>LspGotoDefinition<CR>
    nnoremap <buffer> <silent> K  <Cmd>LspHover<CR>
    nnoremap <buffer> <silent> [d <Cmd>LspDiag prev<CR>
    nnoremap <buffer> <silent> ]d <Cmd>LspDiag next<CR>
    nnoremap <buffer> <silent> <leader>rn <Cmd>LspRename<CR>
    nnoremap <buffer> <silent> <leader>ca <Cmd>LspCodeAction<CR>
  }
  autocmd User LspAttached setlocal tagfunc=lsp#lsp#TagFunc

  autocmd User LspDetached {
    silent! unmap <buffer> gd
    silent! unmap <buffer> K
    silent! unmap <buffer> [d
    silent! unmap <buffer> ]d
    silent! unmap <buffer> <leader>rn
    silent! unmap <buffer> <leader>ca
  }
  autocmd User LspDetached setlocal tagfunc<
augroup END

# 補完選択 → スニペットジャンプ → 通常キー入力
imap <expr> <Tab>   pumvisible() ? '<C-n>' : vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <expr> <S-Tab> pumvisible() ? '<C-p>' : vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

# vim: et sw=2:
