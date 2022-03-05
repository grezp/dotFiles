HOME = os.getenv('HOME')
vim.g.mapleader = ' '

require('plugins')
require('settings')
require('mappings')
require('statusline')
require('autocmds')
require('autocomplete')
require('lspconf')
require('colors')
