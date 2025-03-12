scriptencoding utf-8
"==================================_======================================"
"                     ____ __   __(_)___ ___  __________                  "
"                    / __ `/ | / / / __ `__ \/ ___/ ___/                  "
"                   / /_/ /| |/ / / / / / / / /  / /__                    "
"                   \__, / |___/_/_/ /_/ /_/_/   \___/                    "
"==================/____/================================================="

" ローカル設定(事前) {{{

if has('eval')
  let s:gvimrc_local_pre = g:vimrc_root_dir . '/gvimrc_local_pre'

  if filereadable(s:gvimrc_local_pre)
    execute 'source' s:gvimrc_local_pre
  endif

  unlet s:gvimrc_local_pre
endif

" }}}

" オプション {{{

set guioptions+=a  " クリップボード同期
set guioptions-=e  " 非GUIのタブ表示を使用する
set guioptions-=T  " ツールバー非表示
set guioptions-=m  " メニューバー非表示
set guioptions-=b  " 水平スクロールバー非表示
set guioptions-=l guioptions-=L  " 左スクロールバー非表示
set guioptions-=r guioptions-=R  " 右スクロールバー非表示

if has('win32') && has('kaoriya')
  set guioptions+=C  " タイトルバー非表示
endif

" }}}

" ウィンドウサイズ {{{

" 起動時のみ
if has('vim_starting')
  set lines=48
  set columns=140
endif

" }}}

" フォント設定 {{{

if has('gui_gtk')
  " for GTK UI {{{
  " fontconfigからフォント一覧を取得
  if exists('?systemlist')
    let s:system_font_list = systemlist('env LC_ALL=C fc-list --format=' . shellescape('%{family[0]}\n'))
  else
    let s:system_font_list = split(system('env LC_ALL=C fc-list --format=' . shellescape('%{family[0]}\n')), '\n')
  endif

  " 優先度の高い順にフォントの存在を確認
  " guifontにはフォントをひとつだけ設定する(複数設定しても先頭以外は無視される)
  let s:fonts = [['UDEV Gothic NF'          , 11],
        \        ['PlemolJP Console NFJ'    , 10],
        \        ['PlemolJP Console NF'     , 10],
        \        ['HackGen Console NFJ'     , 11],
        \        ['UDEV Gothic'             , 11],
        \        ['PlemolJP Console'        , 10],
        \        ['HackGen Console'         , 11],
        \        ['Ricty Discord'           , 11],
        \        ['Ricty Dminished Discord' , 11],
        \        ['Ricty'                   , 11],
        \        ['Ricty Dminished'         , 11],
        \        ['VL Gothic'               , 11],
        \        ['monospace'               , 11]]

  for [s:font_name, s:font_size] in s:fonts
    if index(s:system_font_list, s:font_name) > -1
      let &guifont = s:font_name . ' ' . s:font_size
      break
    endif
  endfor

  " 後片付け
  unlet s:system_font_list s:fonts s:font_name s:font_size
  " }}}
elseif has('gui_win32')
  " for Win32 UI {{{
  set guifont=  " リセット
  " 優先度の高い順にフォントを追加
  set guifont+=UDEV_Gothic_NF:h11
  set guifont+=PlemolJP_Console_NFJ:h10
  set guifont+=PlemolJP_Console_NF:h10
  set guifont+=HackGen_Console_NFJ:h11
  set guifont+=HackGen_Console_NF:h11
  set guifont+=UDEV_Gothic:h11
  set guifont+=PlemolJP_Console:h10
  set guifont+=HackGen_Console:h11
  set guifont+=Ricty_Discord:h11
  set guifont+=Ricty_Diminished_Discord:h11
  set guifont+=Ricty:h11
  set guifont+=Ricty_Dminished:h11
  set guifont+=ＭＳ_ゴシック:h11

  " レンダリングにDirectXを使う
  if has('directx')
    set renderoptions=type:directx,renmode:5
  endif
  " }}}
endif

" }}}

" ローカル設定(事後) {{{

if has('eval')
  let s:gvimrc_local = g:vimrc_root_dir . '/gvimrc_local'

  if filereadable(s:gvimrc_local)
    execute 'source' s:gvimrc_local
  endif

  unlet s:gvimrc_local
endif

" }}}

" vim: et sw=2 fdm=marker:
