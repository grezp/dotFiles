HOME = os.getenv("HOME")
vim.g.mapleader = " "

require('plugins')
require('settings')
require('colors')
require('mappings')
require('statusline')
require('autocmds')

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  sync_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
require('autocomplete')
require('lspconf')
