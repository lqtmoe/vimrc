scriptencoding utf-8

set noshowmode
set laststatus=2
set showtabline=1

let g:lightline = #{
      \   active: #{
      \     left: [[ 'mode' ], [ 'filename' ], [ 'readonly', 'modified', 'truncate' ]],
      \     right: [[ 'filetype', 'imstate', 'lsp_errors', 'lsp_warnings' ], [ 'percent' ], [ 'lsp_progress', 'fileformat', 'fileencoding' ]]
      \   },
      \   inactive: #{
      \     left: [[ 'filename' ], [ 'readonly', 'modified', 'truncate' ]],
      \     right: [[ 'filetype' ], [ 'fileformat', 'fileencoding' ]]
      \   },
      \   tabline: #{
      \     left: [[ 'tabs' ]]
      \   },
      \   tab: #{
      \     active: [ 'filename', 'modified' ],
      \     inactive: [ 'filename', 'modified' ]
      \   },
      \   component: #{
      \     filetype: '%{!empty(&ft)?&ft:"unknown"}',
      \     truncate: '%<',
      \     imstate: ''
      \   },
      \   component_visible_condition: #{
      \     truncate: '0',
      \     imstate: '0',
      \   },
      \   component_function: #{
      \     lsp_progress: expand('<SID>') .. 'lightline_lsp_progress'
      \   },
      \   component_function_visible_condition: {},
      \   component_expand: #{
      \     lsp_warnings: 'lightline_lsp#warnings',
      \     lsp_errors: 'lightline_lsp#errors',
      \     lsp_ok: 'lightline_lsp#ok'
      \   },
      \   component_type: #{
      \     lsp_warnings: 'warning',
      \     lsp_errors: 'error',
      \     lsp_ok: 'middle'
      \   },
      \   component_raw: #{
      \     truncate: 1
      \   },
      \   tab_component: {},
      \   tab_component_function: #{
      \     modified: expand('<SID>)') .. 'lightline_tab_modified'
      \   },
      \   colorscheme: 'default',
      \   mode_map: {
      \     'n': 'N',
      \     'i': 'I',
      \     'R': 'R',
      \     'v': 'V',
      \     'V': 'V',
      \     "\<C-v>": 'V',
      \     'c': 'C',
      \     's': 'S',
      \     'S': 'S',
      \     "\<C-s>": 'S',
      \     't': 'T',
      \   },
      \   separator: #{ left: '', right: '' },
      \   subseparator: #{ left: '│', right: '│' },
      \   tabline_separator: #{ left: '', right: '' },
      \   tabline_subseparator: #{ left: '│', right: '│' }
      \ }

" タブ内の全ウィンドウを対象とした変更有無表示
function! s:lightline_tab_modified(n)
  for b in tabpagebuflist(a:n)
    if getbufvar(b, '&buftype', '') != 'terminal'  " Terminalは除外
      if getbufvar(b, '&modified', 0)
        return '+'
      endif
    endif
  endfor
endfunction

" Language Serverの進捗状況を表示する
function! s:lightline_lsp_progress()
  let l:p = get(lsp#get_progress(), 0, {})
  if !has_key(l:p, 'server') || !has_key(l:p, 'title')
    return ''
  endif

  if has_key(l:p, 'percentage')
    return $'{l:p.server}: {l:p.title}({l:p.percentage}%)'
  else
    return $'{l:p.server}: {l:p.title}'
  endif
endfunction

if g:vimrc_nerdfont_enable
  let g:lightline.separator = #{ left: "\ue0b0", right: "\ue0b6" }
  let g:lightline.subseparator = #{ left: "\ue0b1", right: "\ue0b7" }
  let g:lightline.tabline_separator = #{ left: "\ue0bc", right: "\ue0ba" }
  let g:lightline.tabline_subseparator = #{ left: "\ue0bd", right: "\ue0bd" }
  let g:lightline.component.filetype = '%{nerdfont#find()} %{!empty(&ft)?&ft:"unknown"}'
  let g:lightline.tab_component_function.filename = expand('<SID>') .. 'lightline_tab_filename'

  " アイコン付きのファイル名表示
  function! s:lightline_tab_filename(n)
    let l:filename = lightline#tab#filename(a:n)
    return nerdfont#find(l:filename) .. ' ' .. l:filename
  endfunction
endif

" 本体とlightlineのカラースキームを同期
function! s:lightline_colorscheme_update(colors_name = get(g:, 'colors_name', 'default'))
  " 初期化
  let g:lightline.colorscheme = 'default'

  for l:c in [a:colors_name, substitute(a:colors_name, '-', '_', 'g')]
    if !empty(globpath(&rtp, 'autoload/lightline/colorscheme/' .. l:c .. '.vim'))
          \ || exists('g:lightline#colorscheme#' .. l:c .. '#palette')
      let g:lightline.colorscheme = l:c
      break
    endif
  endfor

  if exists('g:loaded_lightline')
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
  endif
endfunction

" 自動コマンド登録
autocmd vimrc ColorScheme * call s:lightline_colorscheme_update(expand('<amatch>'))

" 現在のカラースキームに対して適用するため呼び出し
call s:lightline_colorscheme_update()

" vim: et sw=2:
