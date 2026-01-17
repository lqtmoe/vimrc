set encoding=utf-8
scriptencoding utf-8
" ============================================================================ "
"                        o8o                                                   "
"                        `"'                                                   "
"           oooo    ooo oooo  ooo. .oo.  .oo.   oooo d8b  .ooooo.              "
"            `88.  .8'  `888  `888P"Y88bP"Y88b  `888""8P d88' `"Y8             "
"             `88..8'    888   888   888   888   888     888                   "
"              `888'     888   888   888   888   888     888   .o8             "
"               `8'     o888o o888o o888o o888o d888b    `Y8bod8P'             "
"                                                                              "
" ============================================================================ "

" 𝑉𝑖 𝐼𝑀𝑝𝑟𝑜𝑣𝑒𝑑
if &compatible
  set nocompatible
endif

" ---------------------------------------------------------------------------- "
"  初期設定                                                                    "
" ---------------------------------------------------------------------------- "
if filereadable(expand('$VIMRUNTIME/defaults.vim'))
  unlet! skip_defaults_vim
  source $VIMRUNTIME/defaults.vim
endif

if has('eval')
  if has('win32')
    let g:vimrc_stdpath = {
          \   "config": expand("$UserProfile/vimfiles"),
          \   "cache": expand("$Temp/vim"),
          \ }
  else
    let g:vimrc_stdpath = {
          \   "config": expand("~/.vim"),
          \   "cache": expand("~/.cache/vim"),
          \ }
  endif
endif

" ---------------------------------------------------------------------------- "
"  2 移動、検索とパターン                                                      "
" ---------------------------------------------------------------------------- "
set wrapscan
if has('extra_search')
  set incsearch
endif
set ignorecase
set smartcase

" ---------------------------------------------------------------------------- "
"  4 テキストの表示                                                            "
" ---------------------------------------------------------------------------- "
set nowrap
set sidescroll=1
set fillchars+=vert:┃
set list
set listchars=tab:^\ ,nbsp:.,extends:>,precedes:<
set number

" ---------------------------------------------------------------------------- "
"  5 構文ハイライトとスペルチェック                                            "
" ---------------------------------------------------------------------------- "
if has('extra_search')
  set hlsearch
endif
set cursorline

" ---------------------------------------------------------------------------- "
"  6 複数ウィンドウ                                                            "
" ---------------------------------------------------------------------------- "
set splitright
set splitbelow

" ---------------------------------------------------------------------------- "
"  12 メッセージと情報                                                         "
" ---------------------------------------------------------------------------- "
set noruler
set showcmd
set noshowmode

" ---------------------------------------------------------------------------- "
"  14 テキスト編集                                                             "
" ---------------------------------------------------------------------------- "
if has('persistent_undo')
  set noundofile
endif
set completeopt=menuone,popuphidden,noinsert

" ---------------------------------------------------------------------------- "
"  15 タブとインデント                                                         "
" ---------------------------------------------------------------------------- "
set autoindent

" ---------------------------------------------------------------------------- "
"  17 差分モード                                                               "
" ---------------------------------------------------------------------------- "
set diffopt=internal,filler,closeoff,algorithm:histogram

" ---------------------------------------------------------------------------- "
"  18 マッピング                                                               "
" ---------------------------------------------------------------------------- "
set notimeout
set ttimeout

" ---------------------------------------------------------------------------- "
"  19 ファイルの読み書き                                                       "
" ---------------------------------------------------------------------------- "
set nobackup
set writebackup

" ---------------------------------------------------------------------------- "
"  20 スワップファイル                                                         "
" ---------------------------------------------------------------------------- "
set updatetime=1000

" ---------------------------------------------------------------------------- "
"  21 コマンドライン編集                                                       "
" ---------------------------------------------------------------------------- "
set wildmenu
set wildmode=full

" ---------------------------------------------------------------------------- "
"  23 make の実行とエラーへのジャンプ (quickfix)                               "
" ---------------------------------------------------------------------------- "
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ag')
  set grepprg=ag\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" ---------------------------------------------------------------------------- "
"  キーマップ                                                                  "
" ---------------------------------------------------------------------------- "
nnoremap <C-]> g<C-]>
vnoremap <C-]> g<C-]>
nnoremap g<C-]> <C-]>
vnoremap g<C-]> <C-]>
if has('eval')
  nnoremap <expr> n v:searchforward ? 'n' : 'N'
  nnoremap <expr> N v:searchforward ? 'N' : 'n'
  imap <expr> <Tab>   pumvisible() ? '<C-n>' : '<Tab>'
  imap <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'
  imap <expr> <CR> pumvisible() ? '<C-y>' : '<CR>'
  cmap <expr> <CR> wildmenumode() && getcmdline() =~ '[\\/]$' ? '<C-y>' : '<CR>'
endif
if has('extra_search')
  if v:version >= 900
    nnoremap <Esc><Esc> <Cmd>nohlsearch<CR><Esc>
  else
    nnoremap <Esc><Esc> :<C-u>nohlsearch<CR><Esc>
  endif
endif

" ---------------------------------------------------------------------------- "
"  自動コマンド                                                                "
" ---------------------------------------------------------------------------- "
augroup vimrc
  autocmd!
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
  autocmd QuickfixCmdPost *grep* copen
  autocmd TerminalWinOpen * setlocal nonumber
  autocmd ColorScheme * highlight default link Terminal Normal
augroup END

" ---------------------------------------------------------------------------- "
"  追加ファイル読み込み                                                        "
" ---------------------------------------------------------------------------- "
if filereadable(g:vimrc_stdpath['config'] . '/rc/core.vim')
  execute 'source' g:vimrc_stdpath['config'] . '/rc/core.vim'
endif
if filereadable(g:vimrc_stdpath['config'] . '/rc/plugins.vim')
  execute 'source' g:vimrc_stdpath['config'] . '/rc/plugins.vim'
endif
if filereadable(g:vimrc_stdpath['config'] . '/rc/local.vim')
  execute 'source' g:vimrc_stdpath['config'] . '/rc/local.vim'
endif

" vim: et sw=2:
