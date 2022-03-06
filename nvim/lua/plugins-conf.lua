local utils = require('utils')

-- SETTINGS --

-- Comment.nvim setup
require('Comment').setup()

-- indent blankline
vim.g.indent_blankline_char = '┊'
require("indent_blankline").setup {
  show_current_context = true,
}

-- nvim treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  sync_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- WhichKey
require("which-key").setup()

-- MAPPINGS --

-- FZF
utils.Map('<Leader>ff', ':FZF<CR>')
utils.Map('<Leader>fb', ':Buffers<CR>')    -- fzf buffer
utils.Map('<Leader>fr', ':Rg<CR>')         -- fzf ripgrep search

-- NrwwRgn
utils.Map('<Leader>nn', ':NR!<CR>')
utils.Map('<Leader>ns', ':WR<CR>:bdelete!<CR>')

-- WhichKey
utils.Ex.cabbrev('W', 'WhichKey')
