vim9script
scriptencoding utf-8

import "util.vim"

g:startify_session_dir = util.StdPath("state") .. '/session'
g:startify_files_number = 5
g:startify_bookmarks = []
g:startify_commands = []
g:startify_lists = [
  { type: 'sessions',  header: [' Sessions']  },
  { type: 'bookmarks', header: [' Bookmarks'] },
  { type: 'files',     header: [' Recently Used'] },
]
if executable('fortune')
  g:startify_custom_header = 'systemlist("fortune")'
else
  g:startify_custom_header = 'startify#fortune#quote()'
endif
autocmd vimrc User Startified nnoremap <buffer><nowait><silent> a :enew <bar> startinsert<cr>

# vim: et sw=2:
