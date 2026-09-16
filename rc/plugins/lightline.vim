vim9script
scriptencoding utf-8

minpac#add('itchyny/lightline.vim')

set noshowmode
set laststatus=2
set showtabline=1

g:lightline = {
  active: {
    left: [[ 'mode' ], [ 'filename' ], [ 'readonly', 'modified' ]],
    right: [[ 'filetype' ], [ 'percent' ], [ 'fileformat', 'fileencoding' ]]
  },
  inactive: {
    left: [[ 'filename' ], [ 'readonly', 'modified' ]],
    right: [[ 'filetype' ], [ 'fileformat', 'fileencoding' ]]
  },
  tabline: {
    left: [[ 'tabs' ]]
  },
  tab: {
    active: [ 'filename', 'modified' ],
    inactive: [ 'filename', 'modified' ]
  },
  component: {
    filetype: '%{!empty(&ft)?&ft:"unknown"}',
  },
  component_function_visible_condition: {},
  tab_component_function: {
    modified: expand('<SID>)') .. 'LightlineTabModified'
  },
  colorscheme: 'default',
  mode_map: {
    'n': 'N',
    'i': 'I',
    'R': 'R',
    'v': 'V',
    'V': 'V',
    "\<C-v>": 'V',
    'c': 'C',
    's': 'S',
    'S': 'S',
    "\<C-s>": 'S',
    't': 'T',
  },
  separator: { left: '', right: '' },
  subseparator: { left: '│', right: '│' },
  tabline_separator: { left: '', right: '' },
  tabline_subseparator: { left: '│', right: '│' }
}

# タブ内の全ウィンドウを対象とした変更有無表示
def LightlineTabModified(n: number): string
  for b in tabpagebuflist(n)
    if getbufvar(b, '&buftype', '') != 'terminal'
      if getbufvar(b, '&modified', 0)
        return '+'
      endif
    endif
  endfor
  return null_string
enddef

if g:vimrc#nerdfont_enable
  g:lightline.separator = { left: "\ue0b0", right: "\ue0b6" }
  g:lightline.subseparator = { left: "\ue0b1", right: "\ue0b7" }
  g:lightline.tabline_separator = { left: "\ue0bc", right: "\ue0ba" }
  g:lightline.tabline_subseparator = { left: "\ue0bd", right: "\ue0bd" }
  g:lightline.component.filetype = '%{nerdfont#find()} %{!empty(&ft)?&ft:"unknown"}'
  g:lightline.tab_component_function.filename = expand('<SID>') .. 'LightlineTabFilename'

  # アイコン付きのファイル名表示
  def LightlineTabFilename(n: number): string
    var filename = lightline#tab#filename(n)
    return nerdfont#find(filename) .. ' ' .. filename
  enddef
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
autocmd vimrc ColorScheme * LightlineColorschemeUpdate(expand('<amatch>'))

if v:vim_did_enter
  LightlineColorschemeUpdate()
else
  autocmd vimrc VimEnter * LightlineColorschemeUpdate()
endif

# vim: et sw=2:
