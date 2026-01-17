scriptencoding utf-8

let g:startify_session_dir = g:vimrc_stdpath['cache'] .. '/session'
let g:startify_files_number = 5
let g:startify_bookmarks = []
let g:startify_commands = []
let g:startify_lists = [
      \   #{ type: 'sessions',  header: [' Sessions']  },
      \   #{ type: 'bookmarks', header: [' Bookmarks'] },
      \   #{ type: 'files',     header: [' Recently Used'] },
      \ ]
if executable('fortune')
  let g:startify_custom_header = 'systemlist("fortune")'
else
  let g:startify_custom_header = 'startify#fortune#quote()'
endif
autocmd vimrc User Startified nnoremap <buffer><nowait><silent> a :enew <bar> startinsert<cr>

" vim: et sw=2:
