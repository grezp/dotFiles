local ut = require('utils')

-- diable inline diagnostic errors
vim.diagnostic.config( { virtual_text = false })

-- toggles diags with same key map
local toggle = true
function _G.toggle_diags()
  if toggle then
    toggle = false
    return vim.diagnostic.disable()
  end
  toggle = true
  return vim.diagnostic.enable()
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
-- local on_attach = function(client, bufnr)
local on_attach = function(bufnr)
  print('LSP has Started')
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  ut.keymap('n', '<Leader>ee', '<cmd>lua vim.diagnostic.open_float()<CR>')
  ut.keymap('n', '<Leader>ek', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
  ut.keymap('n', '<Leader>ej', '<cmd>lua vim.diagnostic.goto_next()<CR>')
  ut.keymap('n', '<Leader>el', '<cmd>lua vim.diagnostic.setloclist()<CR>')
  ut.keymap('n', '<Leader>et', '<cmd>lua _G.toggle_diags()<CR>')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  ut.buf_keymap(bufnr, 'n', '<Leader>lD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  ut.buf_keymap(bufnr, 'n', '<Leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR>')
  ut.buf_keymap(bufnr, 'n', '<Leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>')
  ut.buf_keymap(bufnr, 'n', '<Leader>lk', '<cmd>lua vim.lsp.buf.hover()<CR>')
  ut.buf_keymap(bufnr, 'n', '<Leader>lK', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  ut.buf_keymap(bufnr, 'n', '<Leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  ut.buf_keymap(bufnr, 'n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  ut.buf_keymap(bufnr, 'n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
  ut.buf_keymap(bufnr, 'n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
  ut.buf_keymap(bufnr, 'n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')

end

-- general lsp config
local servers = { 'clangd', 'solargraph' } -- 'pyright'
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,

    -- clangd logs: ~/.cache/nvim/lsp.log
    -- cmd = { 'clangd', '--background-index', '--log=verbose' },

    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
  }
end

-- lua LSP config

local sumneko_main = ''
local sumneko_binary = ''
if vim.fn.has('mac') == 1 then
  sumneko_main = '/opt/homebrew/opt/lua-language-server/libexec/main.lua'
  sumneko_binary = '/opt/homebrew/bin/lua-language-server'
elseif vim.fn.has('unix') == 1 then
  sumneko_main = HOME .. '/packages/lua/bin/main.lua'
  sumneko_binary = HOME .. '/packages/lua/bin/lua-language-server'
else
  print('Unsupported system for sumneko')
end

require'lspconfig'.sumneko_lua.setup {
  on_attach = on_attach,
  cmd = {sumneko_binary, '-E', sumneko_main},
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        -- path = runtime_path,
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        -- library = vim.api.nvim_get_runtime_file('', true),
        library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  }
}

-- ignore INFO warning on ruby
vim.cmd([[
  augroup rubyDiags
    autocmd!
    autocmd FileType ruby :lua vim.diagnostic.config({underline = { severity = vim.diagnostic.severity.WARN },
                                                    \ signs = { severity = vim.diagnostic.severity.WARN }})
  augroup END
]])

