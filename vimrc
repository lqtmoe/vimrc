vim9script
set encoding=utf-8
scriptencoding utf-8

import "util.vim"

source $VIMRUNTIME/defaults.vim

# 2 移動、検索とパターン
set wrapscan
if has("extra_search")
  set incsearch
endif
set ignorecase
set smartcase

# 4 テキストの表示
set nowrap
set sidescroll=1
set fillchars+=vert:┃
set list
set listchars=tab:^\ ,nbsp:.,extends:>,precedes:<
set number

# 5 構文ハイライトとスペルチェック
if has("extra_search")
  set hlsearch
endif
set cursorline

# 6 複数ウィンドウ
set splitright
set splitbelow

# 12 メッセージと情報
set noruler
set showcmd
set noshowmode

# 14 テキスト編集
if has("persistent_undo")
  set noundofile
endif
set completeopt=menuone,popuphidden,noinsert

# 15 タブとインデント
set autoindent

# 17 差分モード
set diffopt=internal,filler,closeoff,algorithm:histogram

# 18 マッピング
set notimeout
set ttimeout

# 20 スワップファイル
set updatetime=1000

# 21 コマンドライン編集
set wildmenu
set wildmode=full

# 23 make の実行とエラーへのジャンプ (quickfix)
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

#  キーマップ
nnoremap <C-]> g<C-]>
vnoremap <C-]> g<C-]>
nnoremap g<C-]> <C-]>
vnoremap g<C-]> <C-]>
imap <expr> <Tab>   pumvisible() ? '<C-n>' : '<Tab>'
imap <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'
imap <expr> <CR> pumvisible() ? '<C-y>' : '<CR>'
cmap <expr> <CR> wildmenumode() && getcmdline() =~ '[\\/]$' ? '<C-y>' : '<CR>'
if has('extra_search')
  nnoremap <Esc><Esc> <Cmd>nohlsearch<CR><Esc>
endif

#  自動コマンド
augroup vimrc
  autocmd!
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
  autocmd QuickfixCmdPost *grep* copen
  autocmd TerminalWinOpen * setlocal nonumber
  autocmd ColorScheme * highlight default link Terminal Normal
augroup END

#  追加ファイル読み込み
runtime rc/core.vim
runtime rc/plugins.vim
runtime rc/local.vim

# vim: et sw=2:
