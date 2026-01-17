scriptencoding utf-8

if g:vimrc_input_method == 'skkeleton'
  set imdisable
  imap <C-j> <Plug>(skkeleton-enable)
  cmap <C-j> <Plug>(skkeleton-enable)
  tmap <C-j> <Plug>(skkeleton-enable)
  let g:vimrc_skkeleton_config = {}
  let g:vimrc_skkeleton_config.eggLikeNewline = v:true
  autocmd vimrc User skkeleton-initialize-pre call skkeleton#config(g:vimrc_skkeleton_config)
  function s:lightline_register_skkeleton()
    if exists('g:lightline.component.imstate')
          \ && exists('g:lightline.component_visible_condition.imstate')
      let g:lightline.component.imstate =
            \ '%{%skkeleton#is_enabled()?get(#{hira:"あ",kata:"ア",hankata:"ｱ ",zenkaku:"Ａ",abbrev:"あ"},skkeleton#mode(),"Aa"):""%}'
      let g:lightline.component_visible_condition.imstate = 'skkeleton#is_enabled()'
    endif

    if exists('g:loaded_lightline')
      call lightline#init()
      call lightline#update()
    endif
  endfunction
  autocmd vimrc User skkeleton-initialize-post call s:lightline_register_skkeleton()
endif

if g:vimrc_input_method == 'eskk'
  set imdisable
  let g:eskk#egg_like_newline = 1
  let g:eskk#directory = g:vimrc_stdpath['config'] .. '/eskk'
  function s:lightline_register_eskk()
    if exists('g:lightline.component.imstate')
          \ && exists('g:lightline.component_visible_condition.imstate')
      let g:lightline.component.imstate =
            \ '%{eskk#is_enabled()?get(g:eskk#statusline_mode_strings,eskk#get_mode(),""):""}'
      let g:lightline.component_visible_condition.imstate = 'eskk#is_enabled()'
    endif

    if exists('g:loaded_lightline')
      call lightline#init()
      call lightline#update()
    endif
  endfunction
  autocmd vimrc User eskk-initialize-post call s:lightline_register_eskk()
endif

" vim: et sw=2:
