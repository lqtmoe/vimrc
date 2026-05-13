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

const qf_title_com = simplenine.FunctionComponent.new(
  (_: bool): string => {
    var title: string
    var is_loclist = get(get(getwininfo(win_getid()), 0, {}), "loclist", 0) == 1

    if is_loclist
      title = get(getloclist(0, {title: 1}), "title", "Location list")
    else
      title = get(getqflist({title: 1}), "title", "Quickfix list")
    endif

    return title->substitute(" ", "\u00a0", "g")
  }
)

const qf_type_com = simplenine.FunctionComponent.new(
  (_: bool): string => get(get(getwininfo(win_getid()), 0, {}), "loclist", 0) == 1 ? "location" : "quickfix"
)

const qf_components = [
  qf_title_com,
  simplenine#components#separator,
  simplenine.StringComponent.new("%l/%L"),
  qf_type_com
]

simplenine#SetBufTypeComponents("quickfix", qf_components)

simplenine#SetFileTypeComponents("fern", [simplenine.StringComponent.new("Fern")])
simplenine#SetFileTypeComponents("tagbar", [simplenine.StringComponent.new("Tagbar")])
simplenine#SetFileTypeComponents("startify", [simplenine.StringComponent.new("Startify")])

# vim: et sw=2:
