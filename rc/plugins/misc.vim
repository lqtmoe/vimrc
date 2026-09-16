vim9script
scriptencoding utf-8

# rainbow_parentheses
minpac#add('junegunn/rainbow_parentheses.vim')
g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
augroup vimrc
  autocmd FileType c,cpp,rust,lisp,scheme RainbowParentheses
augroup END

# easy-align
minpac#add('junegunn/vim-easy-align')
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

# previm
minpac#add('previm/previm')
minpac#add('tyru/open-browser.vim')
g:previm_show_header = 0
g:previm_enable_realtime = 1

# FixCursorHold
minpac#add('antoinemadec/FixCursorHold.nvim')
g:cursorhold_updatetime = 300

# highlightedyank
g:highlightedyank_highlight_duration = 500

# nerdfont
minpac#add('lambdalisue/nerdfont.vim')
g:nerdfont#autofix_cellwidths = 0

# autofmt
minpac#add('vim-jp/autofmt')
set formatexpr=autofmt#japanese#formatexpr()

minpac#add('Shougo/vimproc.vim', { do: 'make' })
minpac#add('vim-jp/vital.vim')
minpac#add('thinca/vim-ambicmd')
minpac#add('thinca/vim-quickrun')
minpac#add('mhinz/vim-signify')
minpac#add('kshenoy/vim-signature')
minpac#add('vim-scripts/AnsiEsc.vim')
minpac#add('tpope/vim-surround')
minpac#add('tpope/vim-speeddating')
minpac#add('tpope/vim-repeat')
minpac#add('tpope/vim-dispatch')
minpac#add('freitass/todo.txt-vim')
minpac#add('tpope/vim-fugitive')
minpac#add('vim-jp/vimdoc-ja')

# vim: et sw=2:
