vim9script
scriptencoding utf-8

# rainbow_parentheses
g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
augroup vimrc
  autocmd FileType c,cpp,rust,lisp,scheme RainbowParentheses
augroup END

# easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

# previm
g:previm_show_header = 0
g:previm_enable_realtime = 1

# FixCursorHold
g:cursorhold_updatetime = 300

# highlightedyank
g:highlightedyank_highlight_duration = 500

# nerdfont
g:nerdfont#autofix_cellwidths = 0

# autofmt
set formatexpr=autofmt#japanese#formatexpr()

# vim: et sw=2:
