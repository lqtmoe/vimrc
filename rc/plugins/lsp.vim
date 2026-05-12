vim9script
scriptencoding utf-8

import "simplenine.vim"

g:lsp_use_native_client = 1
g:lsp_diagnostics_echo_cursor = 1
g:lsp_diagnostics_float_cursor = 0
g:lsp_diagnostics_virtual_text_enabled = 0
g:lsp_semantic_enabled = 1
g:lsp_inlay_hints_enabled = 1
g:lsp_work_done_progress_enabled = 1
g:lsp_max_buffer_size = 1024 * 1024
g:lsp_inlay_hints_mode = { normal: ['curline'] }
if g:vimrc_nerdfont_enable
  g:lsp_diagnostics_signs_error = { text: "\uf05e" }
  g:lsp_diagnostics_signs_warning = { text: "\uf071" }
endif

augroup vimrc
  autocmd User lsp_buffer_enabled setlocal tagfunc=lsp#tagfunc
augroup END

g:lsp_settings = {
  clangd: {
    args: ['--clang-tidy', '--header-insertion=never']
  }
}

if has('timers')  # プラグイン無効であればキーマップ登録もしない
  imap <C-space> <Plug>(asyncomplete_force_refresh)
  imap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : '<CR>'
endif

# 補完選択 → スニペットジャンプ → 通常キー入力
imap <expr> <Tab>   pumvisible() ? '<C-n>' : vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <expr> <S-Tab> pumvisible() ? '<C-p>' : vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

var lsp_warn_com = simplenine.FunctionComponent.new(
  (_: bool): string => (g:vimrc_nerdfont_enable ? "\uf071\u00a0" : "W:")
    .. get(lsp#get_buffer_diagnostics_counts(), "warning", 0),
  (_: bool): bool => get(lsp#get_buffer_diagnostics_counts(), "warning", 0) > 0
)

var lsp_err_com = simplenine.FunctionComponent.new(
  (_: bool): string => (g:vimrc_nerdfont_enable ? "\uf05e\u00a0" : "E:")
    .. get(lsp#get_buffer_diagnostics_counts(), "error", 0),
  (_: bool): bool => get(lsp#get_buffer_diagnostics_counts(), "error", 0) > 0
)

var lsp_prog_com = simplenine.FunctionComponent.new(
  (_: bool): string => {
    var progress = get(lsp#get_progress(), 0, {})
    return get(progress, "server") .. ":\u00a0"
      .. get(progress, "title", "")
      .. (has_key(progress, "percentage") ? "(" .. progress.percentage .. "%)" : "")
  },
  (_: bool): bool => {
    var progress = get(lsp#get_progress(), 0, {})
    return has_key(progress, "server") && has_key(progress, "title")
  }
)

var components = simplenine#GetComponents()
var idx = index(components, simplenine#components#separator) + 1

components->insert(lsp_err_com, idx)
components->insert(lsp_warn_com, idx)
components->insert(lsp_prog_com, idx)

simplenine#SetComponents(components)

# vim: et sw=2:
