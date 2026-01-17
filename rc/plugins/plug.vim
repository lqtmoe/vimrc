scriptencoding utf-8

let v:errmsg = ''
silent! call plug#begin()
if !empty(v:errmsg)
  silent! call plug#end()
  finish
endif

" プラグインマネージャ本体
Plug 'junegunn/vim-plug'

" ライブラリ/フレームワーク
Plug 'Shougo/vimproc.vim', { 'do': 'make' }  " 非同期実行ライブラリ
if g:vimrc_denops_enable
  Plug 'vim-denops/denops.vim'  " TypeScript/JavaScriptベースのプラグインエコシステム
endif
Plug 'lambdalisue/nerdfont.vim'  " NerdFontグリフを取得
Plug 'vim-jp/vital.vim'  " ユーティリティ関数群

" Vim本体の機能を拡張/変更するプラグイン
Plug 'thinca/vim-ambicmd'  " 小文字で入力したコマンドを大文字に補完する
if has('timers') && v:version > 802
  Plug 'antoinemadec/FixCursorHold.nvim'  " 'updatetime'とCursorHoldの発生間隔を分離する
endif
Plug 'rickhowe/diffchar.vim'  " 文字単位/単語単位の差分をハイライトする

" 大型/多機能プラグイン
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

" 表示
if has('signs')
  Plug 'mhinz/vim-signify'  " VCSから差分を取得し目印(sign)を表示する
  Plug 'kshenoy/vim-signature'  " マークに目印(sign)を表示する
endif
Plug 'osyo-manga/vim-brightest'  " カーソル下のキーワードをハイライトする
Plug 'junegunn/rainbow_parentheses.vim'  " 括弧のペアを色分けして表示する
Plug 'rbtnn/vim-ambiwidth'  " set ambwidth=single で文字幅を適切に設定する
Plug 'vim-scripts/AnsiEsc.vim'  " ANSIエスケープシーケンスを解釈する
Plug 'machakann/vim-highlightedyank'  " ヤンクした範囲をハイライトする

" 編集
Plug 'tpope/vim-surround'  " テキスト周辺を編集する
Plug 'junegunn/vim-easy-align'  " テキストを整形する
Plug 'cohama/lexima.vim'  " 括弧などを自動展開する

" ユーティリティ
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

" ファイルタイプサポート
Plug 'rust-lang/rust.vim'  " Rust
Plug 'zah/nim.vim'  " Nim
Plug 'aklt/plantuml-syntax'  " PlanetUML
Plug 'vim-skk/skkdict.vim'  " SKK辞書

" ドキュメント
Plug 'vim-jp/vimdoc-ja'  " 日本語ドキュメント

" カラースキーム
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
Plug 'eihigh/vim-aomi-grayscale'

call plug#end()

" 初回インストール
let s:first_install_marker = g:vimrc_stdpath['cache'] .. '/1st_inst'
if filewritable(g:vimrc_stdpath['cache']) == 2 && empty(glob(s:first_install_marker))
  call writefile(['1st PlugInstall command executed.'], s:first_install_marker)
  PlugInstall --sync
endif
unlet s:first_install_marker

" vim: et sw=2:
