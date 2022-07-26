require('core.augroups')
require('core.settings')

vim.defer_fn(function()
  require("core.utils").load_mappings()
end, 0)

require('custom.globals')
require('custom.statusline')
require('custom.colors')

-- plugin configs
require('plugins.packer')
