vim9script
scriptencoding utf-8

minpac#add('junegunn/fzf')
minpac#add('junegunn/fzf.vim')

g:fzf_vim = {}
g:fzf_vim.command_prefix = 'Fzf'

nnoremap <C-p> <Cmd>FzfFiles<CR>

# vim: et sw=2:
