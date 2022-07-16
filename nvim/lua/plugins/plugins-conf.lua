local ut = require('core.utils')
local impatient_status_ok, impatient = pcall(require, 'impatient')
local blankline_status_ok, blankline = pcall(require, 'indent_blankline')

-------------------
-- SIMPLE SETUPS --
-------------------

-- impatiet --
-- needs to be setup before all other plugins --
if impatient_status_ok then
  impatient.enable_profile()
else
  vim.notify('impatient not found!')
end

-- indent blankline --
if blankline_status_ok then
  vim.g.indent_blankline_char = '┊'
  blankline.setup {
    show_current_context = true,
  }

  ut.keymap('n', '<leader>ti', '<cmd>IndentBlanklineToggle!<CR>')
else
  vim.notify('indent_blankline not found!')
end

-- csv.vim --
vim.g.csv_nomap_bs = 1
vim.g.csv_nomap_space = 1
vim.g.csv_nomap_cr = 1

---------------------
-- PLUGIN MAPPINGS --
---------------------

-- fugitive
ut.keymap('n', '<Leader>gf', '<cmd>Git<CR>')
ut.keymap('n', '<Leader>gl', '<cmd>GcLog<CR>')
