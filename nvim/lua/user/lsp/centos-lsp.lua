local ut = require('user.utils')

-- configure clangd differently in centos
if ut.file_exists('/etc/centos-release') then
  require('lspconfig').clangd.setup {
  on_attach = require('user.lsp.handlers').on_attach,
  capabilities = require('user.lsp.handlers').capabilities,

  -- clangd logs: ~/.cache/nvim/lsp.log
  -- cmd = { 'clangd', '--background-index', '--log=verbose' },
  }
end
