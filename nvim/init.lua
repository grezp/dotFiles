HOME = os.getenv('HOME')
vim.g.mapleader = ' '

require('user.plugins')
require('user.settings')
require('user.mappings')
require('user.statusline')
require('user.augroups')
require('user.colors')

-- plugin configs
require('user.plugins-conf')
require('user.comment')
require('user.which-key')
require('user.luasnips')
require('user.cmp')
require('user.telescope')
require('user.lsp')
require('user.treesitter')
require('user.neogit')
require('user.gitsigns')
require('user.hlslens')
require('user.autopairs')
