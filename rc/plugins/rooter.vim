vim9script
scriptencoding utf-8

g:rooter_cd_cmd = 'lcd'
g:rooter_patterns = [
  '.git', '_darcs', '.hg', '.bzr', '.svn', 'package.json',
  'build/Makefile', 'build/build.ninja', 'build/compile_commands.json',
  '*.nimble'
]

# vim: et sw=2:
