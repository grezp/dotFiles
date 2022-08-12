local ut = require('core.utils')

-- configure clangd differently in centos
if ut.file_exists('/etc/centos-release') then
  require('lspconfig').clangd.setup {
  on_attach = require('plugins.lsp.handlers').on_attach,
  capabilities = require('plugins.lsp.handlers').capabilities,

  -- clangd logs: ~/.cache/nvim/lsp.log
  -- cmd = { 'clangd', '--background-index', '--log=verbose' },
  cmd = { 'clangd', '--completion-style=detailed' },
  }
end
