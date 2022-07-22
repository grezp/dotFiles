local M = {}

-------------------
-- SIMPLE SETUPS --
-------------------

-- impatiet --
-- needs to be setup before all other plugins --
M.impatient = function()
  local present, impatient = pcall(require, 'impatient')

  if not present then
    vim.notify('impatient not found!')
    return
  end

  impatient.enable_profile()
end

-- indent blankline --

M.blankline = function()
  local present, blankline = pcall(require, 'indent_blankline')

  if not present then
    vim.notify('indent_blankline not found!')
    return
  end

  vim.g.indent_blankline_char = '┊'
  blankline.setup {
    show_current_context = true,
  }
end

-- csv.vim --
M.csv = function()
  vim.g.csv_nomap_bs = 1
  vim.g.csv_nomap_space = 1
  vim.g.csv_nomap_cr = 1
end

return M
