HOME = os.getenv('HOME')
vim.g.mapleader = ' '

require('core.augroups')
require('core.settings')

require('core.plugins')
require('core.mappings')
require('plugins.statusline')
require('core.colors')

-- plugin configs
require('plugins.plugins-conf')
require('plugins.comment')
require('plugins.which-key')
require('plugins.luasnips')
require('plugins.cmp')
require('plugins.telescope')
require('plugins.lsp')
require('plugins.treesitter')
require('plugins.neogit')
require('plugins.gitsigns')
require('plugins.hlslens')
require('plugins.autopairs')
