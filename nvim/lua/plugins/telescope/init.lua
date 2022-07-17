local status_ok, _ = pcall(require, 'telescope')
if not status_ok then
  vim.notify('telescope not found!')
  return
end

require('plugins.telescope.setup').setup()
