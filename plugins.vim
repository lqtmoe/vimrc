scriptencoding utf-8
"=============================__============_============================="
"                      ____  / /_  ______ _(_)___  _____                  "
"                     / __ \/ / / / / __ `/ / __ \/ ___/                  "
"                    / /_/ / / /_/ / /_/ / / / / (__  )                   "
"                   / .___/_/\__,_/\__, /_/_/ /_/____/                    "
"==================/_/============/____/=================================="

" カスタマイズ変数 {{{
" プラグインの有無や振る舞いを変数で制御できるようにする

" g:vimrc_denops_enable - denopsとdenopsに依存するプラグインを利用可能にする
if !exists('g:vimrc_denops_enable')
  let g:vimrc_denops_enable = v:version >= 901 && executable(get(g:, 'denops#deno', 'deno'))
endif

" g:vimrc_nerdfont_enable - NerdFontによる装飾を有効にする
if !exists('g:vimrc_nerdfont_enable')
  let g:vimrc_nerdfont_enable = 1
endif

" g:vimrc_input_method - インプットメソッドを選択する
if !exists('g:vimrc_input_method')
  if g:vimrc_denops_enable
    let g:vimrc_input_method = 'skkeleton'
  else
    let g:vimrc_input_method = 'eskk'
  endif
endif

" }}}

" 標準プラグインの無効化 {{{

" Netrw
" :h netrw-noload
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" }}}

" プラグイン登録 {{{

let v:errmsg = ""
silent! call plug#begin()

" plug#begin()に失敗したら以降の読み込みを中止
" autoload/plug.vimが無い場合など
if !empty(v:errmsg)
  " 念のためplug#end()しておく
  silent! call plug#end()
  finish
endif

" プラグインマネージャ本体 {{{
Plug 'junegunn/vim-plug'
" }}}

" ライブラリ/フレームワーク {{{
Plug 'Shougo/vimproc.vim', { 'do': 'make' }  " 非同期実行ライブラリ
if g:vimrc_denops_enable
  Plug 'vim-denops/denops.vim'  " TypeScript/JavaScriptベースのプラグインエコシステム
endif
Plug 'lambdalisue/nerdfont.vim'  " NerdFontグリフを取得
Plug 'vim-jp/vital.vim'  " ユーティリティ関数群
" }}}

" Vim本体の機能を拡張/変更するプラグイン {{{
Plug 'thinca/vim-ambicmd'  " 小文字で入力したコマンドを大文字に補完する
if has('timers') && v:version > 802
  Plug 'antoinemadec/FixCursorHold.nvim'  " 'updatetime'とCursorHoldの発生間隔を分離する
endif
" }}}

" 大型/多機能プラグイン {{{
" lightline - statusline/tablineを良い感じにする
Plug 'itchyny/lightline.vim'
Plug 'halkn/lightline-lsp'  " vim-lspの状態をlightlineに表示する

" Fern - ファイルエクスプローラ
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'  " NetrwをFernに置き換える
Plug 'lambdalisue/fern-renderer-nerdfont.vim'  " NerdFontを使用してアイコンを表示する
Plug 'lambdalisue/vim-fern-git-status'  " Git連携

" vim-lsp - Language Server Protocolサポート
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

" asyncomplete - 非同期補完
if has('timers')
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'  " vim-lspと連携
endif

" VSnip - コードスニペット
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ' " vim-lspと連携

" QuickRun - タスクランナー
Plug 'thinca/vim-quickrun'

" Fzf - ファジーファインダ
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" VimWiki - 個人用Wiki
Plug 'vimwiki/vimwiki'

" Startify - スタートアップスクリーンとセッション管理
Plug 'mhinz/vim-startify'
" }}}

" 表示 {{{
if has('signs')
  Plug 'mhinz/vim-signify'  " VCSから差分を取得し目印(sign)を表示する
  Plug 'kshenoy/vim-signature'  " マークに目印(sign)を表示する
endif
Plug 'osyo-manga/vim-brightest'  " カーソル下のキーワードをハイライトする
Plug 'junegunn/rainbow_parentheses.vim'  " 括弧のペアを色分けして表示する
Plug 'rbtnn/vim-ambiwidth'  " set ambwidth=single で文字幅を適切に設定する
Plug 'vim-scripts/AnsiEsc.vim'  " ANSIエスケープシーケンスを解釈する
" }}}

" 編集 {{{
Plug 'tpope/vim-surround'  " テキスト周辺を編集する
Plug 'junegunn/vim-easy-align'  " テキストを整形する
Plug 'cohama/lexima.vim'  " 括弧などを自動展開する
" }}}

" ユーティリティ {{{
Plug 'airblade/vim-rooter'  " ルートファインダ
Plug 'tpope/vim-dispatch'  " 非同期にmakeを実行
Plug 'mhinz/vim-grepper'  " 非同期にgrepを実行
if g:vimrc_input_method == 'skkeleton'
  Plug 'vim-skk/skkeleton'  " Vim版 SKK
endif
if g:vimrc_input_method == 'eskk'
  Plug 'vim-skk/eskk.vim'  " Vim版 SKK
endif
Plug 'previm/previm'  " Markdown/Asciidocをプレビューする
Plug 'preservim/tagbar'  " tagファイルを利用したアウトライン表示
Plug 'tyru/open-browser.vim'  " URLをブラウザで開く
Plug 'vim-jp/autofmt'  " 日本語の禁則処理に対応したテキスト整形
Plug 'freitass/todo.txt-vim'  " todo.txt編集
Plug 'tpope/vim-fugitive'  " Git wrapper
" }}}

" ファイルタイプサポート {{{
Plug 'rust-lang/rust.vim'  " Rust
Plug 'zah/nim.vim'  " Nim
Plug 'aklt/plantuml-syntax'  " PlanetUML
Plug 'vim-skk/skkdict.vim'  " SKK辞書
" }}}

" ドキュメント {{{
Plug 'vim-jp/vimdoc-ja'  " 日本語ドキュメント
" }}}

" カラースキーム {{{
Plug 'nordtheme/vim', { 'as': 'nordtheme' }
Plug 'w0ng/vim-hybrid'
Plug 'cocopon/lightline-hybrid.vim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'tomasr/molokai'
Plug 'altercation/vim-colors-solarized'
Plug 'aereal/vim-colors-japanesque'
Plug 'sakura-theme/vim', { 'as': 'sakura-theme' }
Plug 'morhetz/gruvbox'
Plug 'sainnhe/everforest'
Plug 'junegunn/seoul256.vim'
Plug 'rhysd/vim-color-spring-night'
Plug 'yasukotelin/shirotelin'
Plug 'mhinz/vim-janah'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
" }}}

" マシンローカルなプラグイン {{{
let s:plug_local = g:vimrc_root_dir..'/plug_local.vim'

if filereadable(s:plug_local)
  execute 'source' s:plug_local
endif

unlet s:plug_local
" }}}

call plug#end()

" }}}

" 初回インストール {{{

let s:first_install_marker = g:vimrc_root_dir..'/1st_inst'

if filewritable(g:vimrc_root_dir) == 2 && empty(glob(s:first_install_marker))
  call writefile(['1st PlugInstall command executed.'], s:first_install_marker)

  PlugInstall --sync
endif

unlet s:first_install_marker

" }}}

" パッケージ {{{

if has('packages')
silent! packadd! matchit
silent! packadd! termdebug
silent! packadd! editorconfig
endif

" }}}

" 手動読み込み {{{

if executable('man')
  runtime ftplugin/man.vim  " :Manコマンドを常に使えるようにする
endif

" }}}

" denopsの設定 {{{

if g:vimrc_denops_enable
  " 推奨設定(denops-recommended 参照)
  noremap <silent> <C-c> <Cmd>call denops#interrupt()<CR><C-c>
  inoremap <silent> <C-c> <Cmd>call denops#interrupt()<CR><C-c>
  cnoremap <silent> <C-c> <Cmd>call denops#interrupt()<CR><C-c>
  command! DenopsRestart call denops#server#restart()
  command! DenopsFixCache call denops#cache#update(#{reload: v:true})
endif

" }}}

" FixCursorHoldの設定 {{{

let g:cursorhold_updatetime = 300

" }}}

" lightlineの設定 {{{

set noshowmode
set laststatus=2
set showtabline=1

let g:lightline = #{
      \   active: #{
      \     left: [[ 'mode', 'imstate' ], [ 'filename' ], [ 'readonly', 'modified' ]],
      \     right: [[ 'lsp_errors', 'lsp_warnings', 'filetype' ], [ 'ruler' ], [ 'fileencfmt' ]]
      \   },
      \   inactive: #{
      \     left: [[ 'filename' ], [ 'readonly', 'modified' ]],
      \     right: [[ 'filetype' ], [ 'fileencfmt' ]]
      \   },
      \   tabline: #{
      \     left: [[ 'tabs' ]]
      \   },
      \   tab: #{
      \     active: [ 'filename', 'modified' ],
      \     inactive: [ 'filename', 'modified' ]
      \   },
      \   component: #{
      \     ruler: '%l,%c%V',
      \     filetype: '%{!empty(&ft)?&ft:"unknown"}',
      \     fileencfmt: '%{!empty(&fenc)?&fenc:&enc"}(%{&ff})',
      \     imstate: ''
      \   },
      \   component_visible_condition: #{
      \     imstate: '0',
      \   },
      \   component_function: {},
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
      \   component_raw: {},
      \   tab_component: {},
      \   tab_component_function: #{
      \     modified: expand('<SID>)')..'lightline_tab_modified'
      \   },
      \   colorscheme: 'default',
      \   mode_map: {},
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

" 本体とlightlineのカラースキームを同期
function! s:lightline_colorscheme_update(colors_name = get(g:, 'colors_name', 'default'))
  " 初期化
  let g:lightline.colorscheme = 'default'

  for l:c in [a:colors_name, substitute(a:colors_name, '-', '_', 'g')]
    if !empty(globpath(&rtp, 'autoload/lightline/colorscheme/'..l:c..'.vim'))
          \ || exists('g:lightline#colorscheme#'..l:c..'#palette')
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

" }}}

" fernの設定 {{{

augroup vimrc
  " Fernのバッファは行番号を非表示にする
  autocmd FileType fern setlocal nonumber

  " 矢印キーで開閉操作ができるようにする
  autocmd FileType fern nmap <buffer><silent> <Right> <Plug>(fern-action-open-or-expand)
  autocmd FileType fern nmap <buffer><silent> <Left> <Plug>(fern-action-collapse)
augroup END

" }}}

" vim-lspの設定 {{{

let g:lsp_use_native_client = 1
let g:lsp_semantic_enabled = 1
let g:lsp_inlay_hints_enabled = 1
let g:lsp_inlay_hints_mode = #{ normal: ['curline'] }
let g:lsp_max_buffer_size = 1024 * 1024
" 👀 vim-lsp/issues/1510
"let g:lsp_diagnostics_float_cursor = 1
"let g:lsp_diagnostics_float_insert_mode_enabled = 0
"let g:lsp_diagnostics_float_delay = get(g:, 'cursorhold_updatetime', 300)
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_echo_delay = get(g:, 'cursorhold_updatetime', 300)
let g:lsp_diagnostics_virtual_text_enabled = 0

augroup vimrc
  autocmd User lsp_buffer_enabled setlocal tagfunc=lsp#tagfunc
augroup END

" }}}

" vim-lsp-settingsの設定 {{{

let g:lsp_settings = #{
      \   clangd: #{
      \     args: ['--clang-tidy', '--header-insertion=never']
      \   }
      \ }

" }}}

" asyncompleteの設定 {{{

if has('timers')  " プラグイン無効であればキーマップ登録もしない
  imap <C-space> <Plug>(asyncomplete_force_refresh)
  imap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : '<CR>'
endif

" }}}

" vsnipの設定 {{{

" 補完選択 → スニペットジャンプ → 通常キー入力
imap <expr> <Tab>   pumvisible() ? '<C-n>' : vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <expr> <S-Tab> pumvisible() ? '<C-p>' : vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

" }}}

" Fzfの設定 {{{

let g:fzf_vim = {}

let g:fzf_vim.command_prefix = 'Fzf'

nnoremap <C-p> <Cmd>FzfFiles<CR>

" }}}

" VimWikiの設定 {{{

let g:vimwiki_global_ext = 0
let g:vimwiki_hl_headers = 1
let g:vimwiki_auto_chdir = 1
let g:vimwiki_auto_header = 1
let g:vimwiki_toc_header_level = 2

" }}}

" Startifyの設定 {{{

let g:startify_session_dir = g:vimrc_cache_dir..'/session'
let g:startify_files_number = 5

let g:startify_bookmarks = []
let g:startify_commands = []

let g:startify_lists = [
      \   #{ type: 'sessions',  header: [' Sessions']  },
      \   #{ type: 'bookmarks', header: [' Bookmarks'] },
      \   #{ type: 'files',     header: [' Recently Used'] },
      \ ]

if executable('fortune')
  let g:startify_custom_header = "systemlist('fortune')"
else
  let g:startify_custom_header = "startify#fortune#quote()"
endif

" aでも挿入モードを開始
autocmd vimrc User Startified nnoremap <buffer><nowait><silent> a :enew <bar> startinsert<cr>

" }}}

" vim-brightestの設定 {{{

let g:brightest#enable_on_CursorHold = 1

" Visualでハイライトすると目立ち過ぎず丁度良い
let g:brightest#highlight = #{ group: 'Visual' }

if exists('##ModeChanged')
  " ビジュアルモードに入った時にBrightestのハイライト(Visual)を消去する
  autocmd vimrc ModeChanged *:[vV\x16]* BrightestClear
endif

" }}}

" rainbow_parenthesesの設定 {{{

let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

" RanibowParenteheses有効
augroup vimrc
  autocmd FileType c,cpp,rust,lisp,scheme RainbowParentheses
augroup END

" }}}

" vim-ambiwidthの設定 {{{

" Cica用の設定は無効
let g:ambiwidth_cica_enabled = v:false

" 後で追加できるように空のリストを宣言しておく
let g:ambiwidth_add_list = []

" }}}

" easy-alignの設定 {{{

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" }}}

" leximaの設定 {{{

" ルールを手動で読み込む(キーマップ競合回避)
let g:lexima_no_default_rules = 1
call lexima#set_default_rules()

" <CR>のマップを再定義(asyncompleteの設定も参照)
inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : lexima#expand('<CR>', 'i')

" }}}

" rooterの設定 {{{

let g:rooter_cd_cmd = 'lcd'

" Root Marker
let g:rooter_patterns = []
" rooterのデフォルト (-Makefile)
let g:rooter_patterns += ['.git', '_darcs', '.hg', '.bzr', '.svn', 'package.json']
" cmake/meson
let g:rooter_patterns += ['build/Makefile', 'build/build.ninja', 'build/compile_commands.json']
" nim(nimble)
let g:rooter_patterns += ['*.nimble']

" }}}

" Grepperの設定 {{{

let g:grepper = {}
let g:grepper.tools = ['git', 'rg', 'ag', 'grep', 'findstr']

" ウィンドウの高さをデフォルトに合わせる
" :h grepper-faq-04
let g:grepper.open = 0
autocmd vimrc User Grepper copen

" GrepHere with Grepper
command! -nargs=0 -bang GrepHere Grepper -noprompt -cword -dir file

nnoremap <C-g> <Cmd>Grepper<CR>

" }}}

" skkeletonの設定 {{{

if g:vimrc_input_method == 'skkeleton'
  set imdisable  " システムのIMEを無効化

  " キーマップ
  imap <C-j> <Plug>(skkeleton-enable)
  cmap <C-j> <Plug>(skkeleton-enable)
  tmap <C-j> <Plug>(skkeleton-enable)

  " 設定
  let g:vimrc_skkeleton_config = {}
  let g:vimrc_skkeleton_config.eggLikeNewline = v:true
  autocmd vimrc User skkeleton-initialize-pre call skkeleton#config(g:vimrc_skkeleton_config)

  " Lightline統合
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

" }}}

" eskkの設定 {{{

if g:vimrc_input_method == 'eskk'
  set imdisable  " システムのIMEを無効化

  " 設定
  let g:eskk#egg_like_newline = 1
  let g:eskk#directory = g:vimrc_cache_dir..'/eskk'

  " Lightline統合
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

" }}}

" previmの設定 {{{

let g:previm_show_header = 0
let g:previm_enable_realtime = 1

" }}}

" tagbarの設定 {{{

let g:tagbar_sort = 0
let g:tagbar_width = 30
let g:tagbar_silent = 1
let g:tagbar_compact = 1
let g:tagbar_singleclick = 1

" }}}

" autofmtの設定 {{{

set formatexpr=autofmt#japanese#formatexpr()

" }}}

" nordの設定 {{{

" 一部の配色を変更する
" https://www.nordtheme.com/docs/colors-and-palettes

let s:palette = g:lightline#colorscheme#nord#palette
let s:palette.inactive.left[0] = ['#3B4252', '#E5E9F0', 0, 7]  " nord1, nord5
let s:palette.insert.left[0] = ['#3B4252', '#A3BE8C', 0, 2]  " nord1, nord14
let s:palette.visual.left[0] = ['#3B4252', '#B48EAD', 0, 5]  " nord1, nord15
" 左右の配色を同期させる
let s:palette.normal.right = s:palette.normal.left
let s:palette.inactive.right = s:palette.inactive.left
let s:palette.insert.right = s:palette.insert.left
let s:palette.replace.right = s:palette.replace.left
let s:palette.visual.right = s:palette.visual.left

unlet s:palette  " 後片付け

" }}}

" nerdfontの設定 {{{
" 他のプラグインの設定を後から変える系が多いので下の方に置く

" NerdFontの文字幅設定はvim-ambwidthに任せる
let g:nerdfont#autofix_cellwidths = 0

if g:vimrc_nerdfont_enable
  " lightline {{{
  let g:lightline.separator = #{ left: "\ue0b0", right: "\ue0b6" }
  let g:lightline.subseparator = #{ left: "\ue0b1", right: "\ue0b7" }
  let g:lightline.tabline_separator = #{ left: "\ue0bc", right: "\ue0ba" }
  let g:lightline.tabline_subseparator = #{ left: "\ue0bd", right: "\ue0bd" }
  let g:lightline.component.filetype = '%{nerdfont#find()} %{!empty(&ft)?&ft:"unknown"}'
  let g:lightline.tab_component_function.filename = expand('<SID>')..'lightline_tab_filename'

  " アイコン付きのファイル名表示
  function! s:lightline_tab_filename(n)
    let l:filename = lightline#tab#filename(a:n)
    return nerdfont#find(l:filename)..' '..l:filename
  endfunction
  " }}}

  " fern {{{
  let g:fern#renderer = "nerdfont"
  " }}}

  " vim-lsp {{{
  let g:lsp_diagnostics_signs_error = #{ text: "\uf05e" }
  let g:lsp_diagnostics_signs_warning = #{ text: "\uf071" }
  " }}}

  " vim-ambiwidth {{{
  " Nerd Fontsが提供するグリフの文字幅を定義
  " https://github.com/ryanoasis/nerd-fonts/wiki/Glyph-Sets-and-Code-Points
  " Seti-UI + Custom
  let g:ambiwidth_add_list += [[0xe5fa, 0xe62d, 2]]
  " プラグイン側の定義と重複するためコメントアウト
  "let g:ambiwidth_add_list += [[0xe62e, 0xe62e, 2]]
  let g:ambiwidth_add_list += [[0xe62f, 0xe6b1, 2]]
  " Devicons
  let g:ambiwidth_add_list += [[0xe700, 0xe7c5, 2]]
  " Font Awesome
  let g:ambiwidth_add_list += [[0xf000, 0xf2e0, 2]]
  " Font Awesome Extension
  let g:ambiwidth_add_list += [[0xe200, 0xe2a9, 2]]
  " Material Design Icons
  let g:ambiwidth_add_list += [[0xf0001, 0xf1af0, 2]]
  " Weather
  let g:ambiwidth_add_list += [[0xe300, 0xe3e3, 2]]
  " Octicons
  let g:ambiwidth_add_list += [[0xf400, 0xf532, 2]]
  " プラグイン側の定義と重複するためコメントアウト
  "let g:ambiwidth_add_list += [[0x2665, 0x2665, 2]]
  "let g:ambiwidth_add_list += [[0x26a1, 0x26a1, 2]]
  " Powerline Symbols
  " Powerline系グリフはフォントによって幅が異なるためコメントアウト
  "let g:ambiwidth_add_list += [[0xe0a0, 0xe0a2, 2]]
  "let g:ambiwidth_add_list += [[0xe0b0, 0xe0b3, 2]]
  " Powerline Extra Symbols
  " Powerline系グリフはフォントによって幅が異なるためコメントアウト
  "let g:ambiwidth_add_list += [[0xe0a3, 0xe0a3, 2]]
  "let g:ambiwidth_add_list += [[0xe0b4, 0xe0c8, 2]]
  "let g:ambiwidth_add_list += [[0xe0ca, 0xe0ca, 2]]
  "let g:ambiwidth_add_list += [[0xe0cc, 0xe0d4, 2]]
  " IEC Power Symbols
  let g:ambiwidth_add_list += [[0x23fb, 0x23fe, 2]]
  let g:ambiwidth_add_list += [[0x2b58, 0x2b58, 2]]
  " Font Logos
  let g:ambiwidth_add_list += [[0xf300, 0xf314, 2]]
  " プラグイン側の定義と重複するためコメントアウト
  "let g:ambiwidth_add_list += [[0xf315, 0xf316, 2]]
  let g:ambiwidth_add_list += [[0xf317, 0xf31a, 2]]
  " プラグイン側の定義と重複するためコメントアウト
  "let g:ambiwidth_add_list += [[0xf31b, 0xf31c, 2]]
  let g:ambiwidth_add_list += [[0xf31d, 0xf372, 2]]
  " Pomicons
  let g:ambiwidth_add_list += [[0xe000, 0xe00a, 2]]
  " Codicons
  let g:ambiwidth_add_list += [[0xea60, 0xebeb, 2]]
  " }}}
endif

" }}}

" vim: et sw=2 fdm=marker:
