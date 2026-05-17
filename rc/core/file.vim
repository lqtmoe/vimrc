vim9script
scriptencoding utf-8

set backup
set writebackup
set backupext=.bak~
autocmd vimrc BufWritePre * &backupext = '.' .. strftime('%Y%m%d') .. '.bak~'

# vim: et sw=2:
