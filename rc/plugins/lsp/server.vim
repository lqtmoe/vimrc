vim9script
scriptencoding utf-8

# clangd
if executable("clangd")
  g:vimrc#lsp_servers->add({
    name: "clangd",
    filetype: ["c", "cpp"],
    path: "clangd",
    args: ["--clang-tidy", "--header-insertion=never"]
  })
endif

# rust-analyzer
if executable("rust-analyzer")
  g:vimrc#lsp_servers->add({
    name: "rust-analyzer",
    filetype: ["rust"],
    path: "rust-analyzer"
  })
endif

# ruff
if executable("uvx")
  g:vimrc#lsp_servers->add({
    name: "ruff",
    filetype: ["python"],
    path: "uvx",
    args: ["ruff", "server"]
  })
elseif executable("ruff")
  g:vimrc#lsp_servers->add({
    name: "ruff",
    filetype: ["python"],
    path: "ruff",
    args: ["server"]
  })
endif

# pyrefly
if executable("uvx")
  g:vimrc#lsp_servers->add({
    name: "pyrefly",
    filetype: ["python"],
    path: "uvx",
    args: ["pyrefly", "lsp"]
  })
elseif executable("pyrefly")
  g:vimrc#lsp_servers->add({
    name: "pyrefly",
    filetype: ["python"],
    path: "pyrefly",
    args: ["lsp"]
  })
endif

# vim: et sw=2:
