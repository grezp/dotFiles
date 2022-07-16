local status_ok, _ = pcall(require, 'lspconfig')
if not status_ok then
  vim.notify('lspconfig not found!')
	return
end

require('plugins.lsp.lsp-installer')
require('plugins.lsp.centos-lsp')
require('plugins.lsp.handlers').setup()
