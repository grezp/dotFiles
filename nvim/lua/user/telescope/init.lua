local status_ok, _ = pcall(require, 'telescope')
if not status_ok then
  vim.notify('telescope not found!')
	return
end

require('user.telescope.setup').setup()
require('user.telescope.mappings')
