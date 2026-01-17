scriptencoding utf-8

let g:lsp_use_native_client = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 0
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_semantic_enabled = 1
let g:lsp_inlay_hints_enabled = 1
let g:lsp_work_done_progress_enabled = 1
let g:lsp_max_buffer_size = 1024 * 1024
let g:lsp_inlay_hints_mode = #{ normal: ['curline'] }
if g:vimrc_nerdfont_enable
  let g:lsp_diagnostics_signs_error = #{ text: "\uf05e" }
  let g:lsp_diagnostics_signs_warning = #{ text: "\uf071" }
endif
augroup vimrc
  autocmd User lsp_buffer_enabled setlocal tagfunc=lsp#tagfunc
augroup END

let g:lsp_settings = #{
      \   clangd: #{
      \     args: ['--clang-tidy', '--header-insertion=never']
      \   }
      \ }

if has('timers')  " プラグイン無効であればキーマップ登録もしない
  imap <C-space> <Plug>(asyncomplete_force_refresh)
  imap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : '<CR>'
endif

" 補完選択 → スニペットジャンプ → 通常キー入力
imap <expr> <Tab>   pumvisible() ? '<C-n>' : vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <expr> <S-Tab> pumvisible() ? '<C-p>' : vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

" vim: et sw=2:
