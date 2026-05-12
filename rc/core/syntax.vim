vim9script
scriptencoding utf-8

if !has('syntax')
  finish
endif

# C/C++
legacy let c_functions = 1
legacy let c_space_errors = 1
legacy unlet! c_comment_strings

# vim: et sw=2:
