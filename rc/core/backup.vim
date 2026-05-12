vim9script
scriptencoding utf-8

import "util.vim"

set backup
set writebackup
set backupext=.bak~

var backupdir = util.StdPath("data") .. '/backup'
call mkdir(backupdir, 'p')
&backupdir = backupdir .. '//'

autocmd BufWritePre * &backupext = '.' .. strftime('%Y%m%d') .. '.bak~'

# vim: et sw=2:
