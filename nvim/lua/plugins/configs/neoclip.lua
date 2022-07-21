local present, neoclip = pcall(require, 'neoclip')

if not present then
  vim.notify('neoclip not found!')
  return
end

local options = {
  history = 1000,
  enable_persistent_history = true,
  continuous_sync = false,
  db_path = vim.fn.stdpath('data') .. '/databases/neoclip.sqlite3',
  filter = nil,
  preview = true,
  default_register = '"',
  default_register_macros = 'q',
  enable_macro_history = true,
  content_spec_column = false,
  on_paste = {
    set_reg = false,
  },
  on_replay = {
    set_reg = false,
  },
  keys = {
    telescope = {
      i = {
        select = '<cr>',
        paste = '<c-p>',
        paste_behind = '<c-k>',
        replay = '<c-q>',  -- replay a macro
        delete = '<c-d>',  -- delete an entry
        custom = {},
      },
      n = {
        select = '<cr>',
        paste = 'p',
        --- It is possible to map to more than one key.
        -- paste = { 'p', '<c-p>' },
        paste_behind = 'P',
        replay = 'q',
        delete = 'd',
        custom = {},
      },
    },
  },
}

neoclip.setup(options)
