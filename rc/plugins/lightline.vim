vim9script
scriptencoding utf-8

set noshowmode
set laststatus=2
set showtabline=1

g:lightline = {
  enable: { statusline: 0, tabline: 1 },
  tabline: { left: [[ 'tabs' ]] },
  tab: {
    active: [ 'filename', 'modified' ],
    inactive: [ 'filename', 'modified' ]
  },
  tab_component: {},
  tab_component_function: {
    modified: expand('<SID>)') .. 'LightlineTabModified'
  },
  colorscheme: 'default',
  tabline_separator: { left: '', right: '' },
  tabline_subseparator: { left: '│', right: '│' }
}

# タブ内の全ウィンドウを対象とした変更有無表示
function LightlineTabModified(n)
  for b in tabpagebuflist(a:n)
    if getbufvar(b, '&buftype', '') != 'terminal'
      if getbufvar(b, '&modified', 0)
        return '+'
      endif
    endif
  endfor
endfunction

if g:vimrc_nerdfont_enable
  g:lightline.tabline_separator = { left: "\ue0bc", right: "\ue0ba" }
  g:lightline.tabline_subseparator = { left: "\ue0bd", right: "\ue0bd" }
  g:lightline.tab_component_function.filename = expand('<SID>') .. 'LightlineTabFilename'

  # アイコン付きのファイル名表示
  function LightlineTabFilename(n)
    let l:filename = lightline#tab#filename(a:n)
    return nerdfont#find(l:filename) .. ' ' .. l:filename
  endfunction
endif

# 本体とlightlineのカラースキームを同期
def LightlineColorschemeUpdate(colors_name: string = get(g:, 'colors_name', 'default'))
  # 初期化
  g:lightline.colorscheme = 'default'

  for c in [colors_name, substitute(colors_name, '-', '_', 'g')]
    if !empty(globpath(&rtp, 'autoload/lightline/colorscheme/' .. c .. '.vim'))
          \ || exists('g:lightline#colorscheme#' .. c .. '#palette')
      g:lightline.colorscheme = c
      break
    endif
  endfor

  if exists('g:loaded_lightline')
    lightline#init()
    lightline#colorscheme()
    lightline#update()
  endif
enddef

# 自動コマンド登録
autocmd vimrc ColorScheme * call LightlineColorschemeUpdate(expand('<amatch>'))

# 現在のカラースキームに対して適用するため呼び出し
LightlineColorschemeUpdate()

# vim: et sw=2:
