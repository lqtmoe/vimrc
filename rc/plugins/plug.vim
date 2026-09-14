vim9script
scriptencoding utf-8

import "util.vim"

v:errmsg = ''
silent! call plug#begin(util.StdPath("data") .. "/plugged")
if !empty(v:errmsg)
  silent! call plug#end()
  finish
endif

# プラグインマネージャ本体
Plug 'junegunn/vim-plug'

# ライブラリ
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'lambdalisue/nerdfont.vim'
Plug 'vim-jp/vital.vim'

# Vim本体の機能を拡張/変更するプラグイン
Plug 'thinca/vim-ambicmd'
Plug 'antoinemadec/FixCursorHold.nvim'

# 大型/多機能プラグイン
# lightline
Plug 'itchyny/lightline.vim'
# Fern
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/vim-fern-git-status'
# vim-lsp
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
# asyncomplete
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
# VSnip
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
# QuickRun
Plug 'thinca/vim-quickrun'
# Fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
# VimWiki
Plug 'vimwiki/vimwiki'
# Startify
Plug 'mhinz/vim-startify'

# 表示
Plug 'lqtmoe/vim-simplenine'
Plug 'mhinz/vim-signify'
Plug 'kshenoy/vim-signature'
Plug 'osyo-manga/vim-brightest'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'rbtnn/vim-ambiwidth'
Plug 'vim-scripts/AnsiEsc.vim'

# 編集
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'cohama/lexima.vim'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'

# ユーティリティ
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-dispatch'
Plug 'mhinz/vim-grepper'
Plug 'vim-skk/eskk.vim'
Plug 'previm/previm'
Plug 'preservim/tagbar'
Plug 'tyru/open-browser.vim'
Plug 'vim-jp/autofmt'
Plug 'freitass/todo.txt-vim'
Plug 'tpope/vim-fugitive'

# ファイルタイプサポート
Plug 'rust-lang/rust.vim'
Plug 'zah/nim.vim'
Plug 'aklt/plantuml-syntax'
Plug 'vim-skk/skkdict.vim'

# ドキュメント
Plug 'vim-jp/vimdoc-ja'

# カラースキーム
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

# 初回インストール
var first_install_marker = util.StdPath("state") .. '/1st_inst'
if filewritable(util.StdPath("state")) == 2 && empty(glob(first_install_marker))
  writefile(['1st PlugInstall command executed.'], first_install_marker)
  PlugInstall --sync
endif

# vim: et sw=2:
