vim9script
scriptencoding utf-8

augroup vimrc
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
  autocmd QuickfixCmdPost *grep* copen
  autocmd TerminalWinOpen * setlocal nonumber
  autocmd ColorScheme * highlight default link Terminal Normal
augroup END

# vim: et sw=2:
