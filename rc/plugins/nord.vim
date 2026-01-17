scriptencoding utf-8

" https://www.nordtheme.com/docs/colors-and-palettes
let s:palette = g:lightline#colorscheme#nord#palette
let s:palette.inactive.left[0] = ['#3B4252', '#E5E9F0', 0, 7]  " nord1, nord5
let s:palette.insert.left[0] = ['#3B4252', '#A3BE8C', 0, 2]  " nord1, nord14
let s:palette.visual.left[0] = ['#3B4252', '#B48EAD', 0, 5]  " nord1, nord15
let s:palette.normal.right = s:palette.normal.left
let s:palette.inactive.right = s:palette.inactive.left
let s:palette.insert.right = s:palette.insert.left
let s:palette.replace.right = s:palette.replace.left
let s:palette.visual.right = s:palette.visual.left
unlet s:palette

" vim: et sw=2:
