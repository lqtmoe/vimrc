vim9script
scriptencoding utf-8

# インプットメソッドを選択する
g:vimrc#input_method = get(g:, "vimrc#input_method", "eskk")

# Nerd Fontsによる装飾を有効にする
g:vimrc#nerdfonts_enable = get(g:, "vimrc#nerdfonts_enable", true)

# 初回インストール処理中
g:vimrc#first_install_progress = get(g:, "vimrc#first_install_progress", false)

# 登録するLSPサーバー
g:vimrc#lsp_servers = get(g:, "vimrc#lsp_servers", [])

# vim: et sw=2:
