HOME = os.getenv('HOME')
vim.g.mapleader = ' '

require('plugins')
require('plugins-conf')
require('settings')
require('mappings')
require('statusline')
require('augroups')
require('autocomplete')
require('lspconf')
require('colors')
