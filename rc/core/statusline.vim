scriptencoding utf-8

set laststatus=2
let &statusline =
      \    " "
      \ .. "%{%get({\"\\<C-v>\":\"V\",\"\\<C-s>\":\"S\"},mode(),toupper(mode()))%}"
      \ .. " │ "
      \ .. "%t%r%m"
      \ .. "%="
      \ .. "%{&ff}"
      \ .. " │ "
      \ .. "%{!empty(&fenc)?&fenc:&enc}"
      \ .. " │ "
      \ .. "%3p%%"
      \ .. " │ "
      \ .. "%{!empty(&ft)?&ft:\"unknown\"}"
      \ .. " "

" vim: et sw=2:
