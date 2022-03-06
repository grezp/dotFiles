local utils = require('utils')

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

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
utils.Nmap('<Leader>ee', '<cmd>lua vim.diagnostic.open_float()<CR>')
utils.Nmap('<Leader>ek', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
utils.Nmap('<Leader>ej', '<cmd>lua vim.diagnostic.goto_next()<CR>')
utils.Nmap('<Leader>el', '<cmd>lua vim.diagnostic.setloclist()<CR>')
utils.Nmap('<Leader>et', '<cmd>lua _G.toggle_diags()<CR>')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
-- local on_attach = function(client, bufnr)
local on_attach = function(bufnr)
  print('LSP has Started')
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- general lsp config
local servers = { 'clangd', 'solargraph' } -- 'pyright'
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,

    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
  }
end

-- lua LSP config

local sumneko_root_path = ''
local sumneko_binary = ''

if vim.fn.has('mac') == 1 then
  sumneko_root_path = HOME .. '/.config/nvim/lua-language-server'
  sumneko_binary = HOME .. '/.config/nvim/lua-language-server/bin/macOS/lua-language-server'
elseif vim.fn.has('unix') == 1 then
  sumneko_root_path = HOME .. '/packages/lua/bin/'
  sumneko_binary = sumneko_root_path .. 'lua-language-server'
else
  print('Unsupported system for sumneko')
end

require'lspconfig'.sumneko_lua.setup {
  on_attach = on_attach,
  cmd = {sumneko_binary, '-E', sumneko_root_path .. 'main.lua'},
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

