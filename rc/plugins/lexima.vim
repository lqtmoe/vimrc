scriptencoding utf-8

let g:lexima_no_default_rules = 1
call lexima#set_default_rules()

" <CR>のマップを再定義(asyncompleteの設定も参照)
inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : lexima#expand('<CR>', 'i')

" vim: et sw=2:
