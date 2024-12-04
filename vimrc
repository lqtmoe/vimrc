set encoding=utf-8
scriptencoding utf-8
"==============================_=========================================="
"                       _   __(_)___ ___  __________                      "
"                      | | / / / __ `__ \/ ___/ ___/                      "
"                      | |/ / / / / / / / /  / /__                        "
"                      |___/_/_/ /_/ /_/_/   \___/                        "
"========================================================================="

" 𝑉𝑖 𝐼𝑀𝑝𝑟𝑜𝑣𝑒𝑑 {{{

if &compatible
  set nocompatible
endif

" +eval機能が無効な場合
silent! while 0
  set nocompatible
silent! endwhile

" }}}

" 初期設定 {{{

" 初期化 {{{

" デフォルト設定ファイル
if filereadable(expand('$VIMRUNTIME/defaults.vim'))
  unlet! skip_defaults_vim
  source $VIMRUNTIME/defaults.vim
endif

" augroup登録/autocmd初期化
silent! augroup vimrc
  silent! autocmd!
silent! augroup END

" }}}

" パス設定 {{{
" +eval機能が無効な場合はこれらの変数は使用できない

if has('eval')
  " g:vimrc_root_dir - 設定ファイルのルートディレクトリ
  let g:vimrc_root_dir = expand('~/.vim')
  if expand('<sfile>:p:h') != expand('~')
    let g:vimrc_root_dir = expand('<sfile>:p:h')
  elseif has('win32')
    let g:vimrc_root_dir = expand('~/vimfiles')
  endif
  " runtimepathに含まれていなければ追加
  if index(split(&rtp,','), g:vimrc_root_dir) == -1
    execute 'set' 'runtimepath+=' . g:vimrc_root_dir
  endif

  " g:vimrc_cache_dir - キャッシュ用ディレクトリ
  let g:vimrc_cache_dir = expand('~/.cache/vim')
  if has('win32')
    let g:vimrc_cache_dir = expand('$LocalAppData/vim')
  endif
endif

" }}}

" }}}

" ローカル設定(事前) {{{

if has('eval')
  let s:local_pre_vim = g:vimrc_root_dir . '/local/pre.vim'

  if filereadable(s:local_pre_vim)
    execute 'source' s:local_pre_vim
  endif

  unlet s:local_pre_vim
endif

" }}}

" 基本 {{{

" 行番号
set number

set ruler
set showcmd
set showmode

set nowrap
set sidescroll=1

" 現在行表示
set cursorline
" カレントウィンドウ以外は表示しない
silent! autocmd vimrc WinEnter * setlocal cursorline
silent! autocmd vimrc WinLeave * setlocal nocursorline

" 自動インデント
set autoindent

" 更新間隔
set updatetime=1000

" コマンドライン補完
set wildmenu
set wildmode=longest:full,full

" }}}

" 表示 {{{

" listモード
set list
set listchars=
set listchars+=tab:^\ 
set listchars+=nbsp:.
set listchars+=extends:>
set listchars+=precedes:<

" fillchars
set fillchars=
set fillchars+=vert:┃

" }}}

" 編集 {{{

" 補完
set completeopt=menuone,popuphidden,noinsert

" }}}

" ウィンドウ {{{

set splitright
set splitbelow

" }}}

" ステータスライン {{{

if has('statusline')
  set laststatus=2

  " components
  let s:c = {
        \ 'separator': ' │ ',
        \ 'padding': '%=',
        \ 'filename': '%t',
        \ 'readonly': '%r',
        \ 'modify': '%m',
        \ 'fileencfmt': '%{!empty(&fenc)?&fenc:&enc}(%{&ff})',
        \ 'ruler': '%l,%c%V',
        \ 'filetype': '%{!empty(&ft)?&ft:"unknown"}'
        \ }

  let &statusline = ' '
        \ . s:c['filename'] . s:c['readonly'] . s:c['modify']
        \ . s:c['padding']
        \ . s:c['fileencfmt']
        \ . s:c['separator']
        \ . s:c['ruler']
        \ . s:c['separator']
        \ . s:c['filetype']
        \ . ' '

  unlet s:c
endif

" }}}

" タブライン {{{

set showtabline=1

" }}}

" 検索 {{{

set ignorecase
set smartcase

set wrapscan

if has('extra_search')
  set hlsearch
  set incsearch
endif

" }}}

" Diff {{{

set diffopt=internal,filler,closeoff,algorithm:histogram

" }}}

" Grep {{{

" 外部Grep
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ag')
  set grepprg=ag\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" Grep後にQuickfixを開く
silent! autocmd vimrc QuickfixCmdPost *grep* copen

" }}}

" アンドゥ {{{

if has('persistent_undo')
  set noundofile
endif

" }}}

" バックアップ {{{

" バックアップ機能を無効にする
" 'backupdir' が設定できない場合に、カレントディレクトリを散らかしたくないため
set nobackup
set writebackup

if has('eval')
  set backup
  set writebackup
  set backupext=.bak~

  " バックアップファイルにタイムスタンプ(yyyymmdd)を付与
  silent! autocmd vimrc BufWritePre * let &backupext = '.' . strftime('%Y%m%d') . '.bak~'

  let s:backupdir = g:vimrc_cache_dir . '/backup'
  call mkdir(s:backupdir, 'p')

  let &backupdir = s:backupdir . '//'

  unlet s:backupdir  " 後片付け
endif

" }}}

" 端末機能 {{{

if has('terminal')
  " 端末ウィンドウは行番号非表示
  autocmd vimrc TerminalWinOpen * setlocal nonumber

  " 動作中の端末の配色を他のウィンドウと同じにする
  autocmd vimrc ColorScheme * highlight default link Terminal Normal
endif

" }}}

" 構文ハイライト {{{

if has('syntax')

  " C/C++ {{{
  let c_functions = 1
  let c_space_errors = 1
  unlet! c_comment_strings
  " }}}

endif

" }}}

" コマンド {{{

" :GrepHere - カーソル下の単語を編集中ファイルのルートで再帰的にGrep
if &grepprg =~ '^grep'
  command! -nargs=0 -bang GrepHere
        \ execute 'grep<bang>' shellescape(expand('<cword>'), 1) '-r' '%:p:h:S'
else
  command! -nargs=0 -bang GrepHere
        \ execute 'grep<bang>' shellescape(expand('<cword>'), 1) '%:p:h:S'
endif

" }}}

" キーマップ {{{

" キーマップのタイムアウトを無効化
set notimeout
set ttimeout

" タグジャンプ機能の入れ替え
nnoremap <C-]> g<C-]>
vnoremap <C-]> g<C-]>
nnoremap g<C-]> <C-]>
vnoremap g<C-]> <C-]>

" 強調表示解除
if has('extra_search')
  if v:version >= 900  " Vim9.0以上であれば<Cmd>が使える
    nnoremap <Esc><Esc> <Cmd>nohlsearch<CR><Esc>
  else
    nnoremap <Esc><Esc> :<C-u>nohlsearch<CR><Esc>
  endif
endif

" }}}

" GUI設定 {{{
" gvimrcより前に設定する必要がある項目はここに書く

if has('gui_running')
  set guioptions+=M  " メニューを読み込まない
endif

" }}}

" プラグイン設定 {{{

" プラグインはVim 8.2以降で有効とする
if v:version >= 802
  let s:plugins_vim = g:vimrc_root_dir . '/plugins.vim'

  if filereadable(s:plugins_vim)
    execute 'source' s:plugins_vim
  endif

  unlet s:plugins_vim
endif

" }}}

" ローカル設定(事後) {{{

if has('eval')
  let s:local_post_vim = g:vimrc_root_dir . '/local/post.vim'

  if filereadable(s:local_post_vim)
    execute 'source' s:local_post_vim
  endif

  unlet s:local_post_vim
endif

" }}}

" vim: et sw=2 fdm=marker:
