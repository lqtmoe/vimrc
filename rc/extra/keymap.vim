vim9script
scriptencoding utf-8

#  キーマップ
nnoremap <C-]> g<C-]>
vnoremap <C-]> g<C-]>
nnoremap g<C-]> <C-]>
vnoremap g<C-]> <C-]>
imap <expr> <Tab>   pumvisible() ? '<C-n>' : '<Tab>'
imap <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'
imap <expr> <CR> pumvisible() ? '<C-y>' : '<CR>'
cmap <expr> <CR> wildmenumode() && getcmdline() =~ '[\\/]$' ? '<C-y>' : '<CR>'
if has('extra_search')
  nnoremap <Esc><Esc> <Cmd>nohlsearch<CR><Esc>
endif

# vim: et sw=2:
