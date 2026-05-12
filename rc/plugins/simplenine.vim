vim9script
scriptencoding utf-8

import "simplenine.vim"

const components = [
  simplenine#components#filename,
  simplenine#components#readonly,
  simplenine#components#modify,
  simplenine#components#separator,
  simplenine#components#percent,
  simplenine#components#encoding,
  simplenine#components#fileformat,
  simplenine#components#filetype
]
simplenine#SetComponents(components)

simplenine#SetBufTypeComponents("help", [simplenine#components#filename])
simplenine#SetBufTypeComponents("terminal", [simplenine#components#filename])

const qf_components = [
  simplenine#components#filename,
  simplenine#components#separator,
  simplenine.StringComponent.new("%l/%L")
]

simplenine#SetBufTypeComponents("quickfix", qf_components)

simplenine#SetFileTypeComponents("fern", [simplenine.StringComponent.new("Fern")])
simplenine#SetFileTypeComponents("tagbar", [simplenine.StringComponent.new("Tagbar")])
simplenine#SetFileTypeComponents("startify", [simplenine.StringComponent.new("Startify")])

# vim: et sw=2:
