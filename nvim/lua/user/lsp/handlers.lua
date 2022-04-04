local utils_status_ok, ut = pcall(require, 'user.utils')
local teles_status_ok,  _ = pcall(require, 'telescope')
local M = {}

-- TODO: backfill this to template
M.setup = function()
  local signs = {
    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn', text = '' },
    { name = 'DiagnosticSignHint', text = '' },
    { name = 'DiagnosticSignInfo', text = '' },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
  })

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
  })
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

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

local function lsp_keymaps(bufnr)
  if utils_status_ok then
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    ut.buf_keymap(bufnr, 'n', '<Leader>ee', '<cmd>lua vim.diagnostic.open_float()<CR>')
    ut.buf_keymap(bufnr, 'n', '<Leader>ek', '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>')
    ut.buf_keymap(bufnr, 'n', '<Leader>ej', '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>')
    ut.buf_keymap(bufnr, 'n', '<Leader>el', '<cmd>lua vim.diagnostic.setloclist()<CR>')
    ut.buf_keymap(bufnr, 'n', '<Leader>et', '<cmd>lua _G.toggle_diags()<CR>')

    if teles_status_ok then
      local map_tele = require('user.telescope.builtins').map_tele
      map_tele('<leader>ed', 'diags', _, bufnr)

      map_tele('<leader>ld', 'lsp_defs', _, bufnr)
      map_tele('<leader>lr', 'lsp_refs', _, bufnr)
      map_tele('<leader>li', 'lsp_impl', _, bufnr)
      map_tele('<leader>ls', 'lsp_global_symbols', _, bufnr)
    else
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      ut.buf_keymap(bufnr, 'n', '<Leader>lD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
      ut.buf_keymap(bufnr, 'n', '<Leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR>')
      ut.buf_keymap(bufnr, 'n', '<Leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>')
      ut.buf_keymap(bufnr, 'n', '<Leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>')
      -- ut.buf_keymap(bufnr, 'n', '<Leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>')
      -- ut.buf_keymap(bufnr, 'n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
      -- ut.buf_keymap(bufnr, 'n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
      -- ut.buf_keymap(bufnr, 'n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
      -- ut.buf_keymap(bufnr, 'n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
    end

    ut.buf_keymap(bufnr, 'n', '<Leader>lk', '<cmd>lua vim.lsp.buf.hover()<CR>')
    ut.buf_keymap(bufnr, 'n', '<Leader>lK', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  else
    vim.notify('user.utils not found')
  end
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
  print('LSP attached '..client.name..' to buffer '..bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not status_ok then
  vim.notify('cmp-nvim-lsp not found!')
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
