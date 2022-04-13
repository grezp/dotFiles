local status_ok, gitsigns = pcall(require, 'gitsigns')

if not status_ok then
  vim.notify('gitsigns not found!')
  return
end

gitsigns.setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },

  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`

  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },

  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`

  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },

  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,

  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },

  yadm = {
    enable = false
  },
}

local ut = require('user.utils')
ut.keymap('n', ']c', [[&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>']], {expr=true})
ut.keymap('n', '[c', [[&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>']], {expr=true})

ut.keymap({'n', 'v'},  '<leader>hs', ':Gitsigns stage_hunk<CR>')
ut.keymap({'n', 'v'},  '<leader>hu', ':Gitsigns undo_stage_hunk<CR>')
ut.keymap({'n', 'v'},  '<leader>hr', ':Gitsigns reset_hunk<CR>')
ut.keymap('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
ut.keymap('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
ut.keymap('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
ut.keymap('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line {full=true, ignore_whitespace=true}<CR>')
ut.keymap('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
ut.keymap('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
ut.keymap('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
ut.keymap('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

