local status_ok, configs = pcall(require, 'nvim-treesitter.configs')

if not status_ok then
  vim.notify('nvim-treesitter not found!')
  return
end

configs.setup {
  ensure_installed = 'maintained',
  sync_install = false,
  ignore_install = { '' }, -- List of parsers to ignore installing

  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { '' }, -- list of language that will be disabled

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },

  indent = {
    enable = true,
    disable = { '' },
  },
}
