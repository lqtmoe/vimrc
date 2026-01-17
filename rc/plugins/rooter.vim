scriptencoding utf-8

let g:rooter_cd_cmd = 'lcd'
let g:rooter_patterns = [
      \   '.git', '_darcs', '.hg', '.bzr', '.svn', 'package.json',
      \   'build/Makefile', 'build/build.ninja', 'build/compile_commands.json',
      \   '*.nimble'
      \ ]

" vim: et sw=2:
