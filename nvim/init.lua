HOME = os.getenv('HOME')
vim.g.mapleader = ' '

require('user.plugins')
require('user.plugins-conf')
require('user.settings')
require('user.mappings')
require('user.statusline')
require('user.augroups')
require('user.luasnips')
require('user.cmp')
require('user.lspconf')
require('user.colors')
