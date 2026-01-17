scriptencoding utf-8

set backup
set writebackup
set backupext=.bak~

let s:backupdir = g:vimrc_stdpath['cache'] .. '/backup'
call mkdir(s:backupdir, 'p')
let &backupdir = s:backupdir .. '//'
unlet s:backupdir

autocmd BufWritePre * let &backupext = '.' .. strftime('%Y%m%d') .. '.bak~'

" vim: et sw=2:
