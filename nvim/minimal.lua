vim.g.mapleader = ' '

vim.keymap.set(
  'n',
  '<Leader>f',
  function()
    require('telescope.builtin').fd {
      hidden = false,     -- don't show hidden files
      no_ignore = false,  -- don't show ignore files
      sorting_strategy = 'ascending',
      find_command = {
        'fd',
        '--type',
        'f',
        '--strip-cwd-prefix'
      },
    }
  end,
  {noremap = true}
)

local install_path = vim.fn.stdpath'data'..'/site/pack/packer/opt/packer.nvim'
if vim.fn.isdirectory(install_path) == 0 then
  os.execute('git clone https://github.com/wbthomason/packer.nvim '..install_path)
  vim.cmd'packadd packer.nvim'
end

require'packer'.startup(function()
  use'wbthomason/packer.nvim'
  use{
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
    },
    keys = {
      '<Leader>f',
    },
  }
end)

