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
  showInlayHints: true,
  incrementalSync: true,
  popupBorder: true,
}

if g:vimrc#nerdfonts_enable
  g:lsp_options.diagSignErrorText = "\uf05e"
  g:lsp_options.diagSignWarningText = "\uf071"
endif

# 補完選択 → スニペットジャンプ → 通常キー入力
imap <expr> <Tab>   pumvisible() ? '<C-n>' : vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <expr> <S-Tab> pumvisible() ? '<C-p>' : vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

augroup vimrc
  autocmd User LspSetup {
    if !empty(g:vimrc#lsp_servers)
      g:LspAddServer(deepcopy(g:vimrc#lsp_servers))
    endif
  }

  # CursorHold で診断情報ポップアップ
  autocmd User LspSetup autocmd vimrc CursorHold * silent! LspDiag! current

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

LoadConfig plugins/lsp/server.vim
LoadConfig plugins/lsp/statusline.vim

# vim: et sw=2:
