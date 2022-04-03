local utils_status_ok,      ut          = pcall(require, 'user.utils')
local comment_status_ok,    comment     = pcall(require, 'Comment')
local which_key_status_ok,  which_key   = pcall(require, 'which-key')
local gitsigns_status_ok,   gitsigns    = pcall(require, 'gitsigns')
local blankline_status_ok,  blankline   = pcall(require, 'indent_blankline')
local treesitter_status_ok, treesitter  = pcall(require, 'nvim-treesitter.configs')
local neogit_status_ok,     neogit      = pcall(require, 'neogit')

--------------
-- SETTINGS --
--------------

-- simple setups --
if comment_status_ok then
  comment.setup()
else
  vim.notify('Comment not found!')
end

if which_key_status_ok then
  which_key.setup()
else
  vim.notify('which-key not found!')
end

if gitsigns_status_ok then
  gitsigns.setup()
else
  vim.notify('gitsigns not found!')
end

-- indent blankline --
if blankline_status_ok then
  vim.g.indent_blankline_char = '┊'
  blankline.setup {
    show_current_context = true,
  }
else
  vim.notify('indent_blankline not found!')
end

-- nvim treesitter --
if treesitter_status_ok then
  treesitter.setup {
    ensure_installed = 'maintained',
    sync_install = false,

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  }
else
  vim.notify('nvim-treesitter not found!')
end

-- neogit --
if neogit_status_ok then
  neogit.setup {
    signs = {
      section = { '', '' },
      item = { '', '' },
    },
    integrations = {
      diffview = true,
    },
  }
else
  vim.notify('neogit not found!')
end


--------------
-- MAPPINGS --
--------------
if utils_status_ok then

  -- WhichKey --
  if which_key_status_ok then
    ut.Ex.cabbrev('W', 'WhichKey')
  end

  -- gitsigns --
  if gitsigns_status_ok then
    ut.keymap('n', ']c', [[&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>']], {expr=true})
    ut.keymap('n', '[c', [[&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>']], {expr=true})

    ut.keymap('',  '<leader>hs', ':Gitsigns stage_hunk<CR>')
    ut.keymap('',  '<leader>hu', ':Gitsigns undo_stage_hunk<CR>')
    ut.keymap('',  '<leader>hr', ':Gitsigns reset_hunk<CR>')
    ut.keymap('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
    ut.keymap('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
    ut.keymap('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
    ut.keymap('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line {full=true, ignore_whitespace=true}<CR>')
    ut.keymap('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
    ut.keymap('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
    ut.keymap('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
    ut.keymap('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')
  end

  if neogit_status_ok then
    ut.keymap('n', '<leader>gg', '<cmd>Neogit<CR>')
  end

  -- NrwwRgn --
  ut.keymap('', '<Leader>nn', ':NR!<CR>')
  ut.keymap('', '<Leader>ns', ':WR<CR>:bdelete!<CR>')

  -- hlslens --
  ut.keymap('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]])
  ut.keymap('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]])
  ut.keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]])
  ut.keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]])
  ut.keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]])
  ut.keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]])

  ut.keymap('x', '*', [[*<Cmd>lua require('hlslens').start()<CR>]])
  ut.keymap('x', '#', [[#<Cmd>lua require('hlslens').start()<CR>]])
  ut.keymap('x', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]])
  ut.keymap('x', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]])

  -- bufdelete --
  ut.keymap('n', '<Leader>bd', [[:lua require('bufdelete').bufdelete(0, true)<CR>]])

  -- fugitive
  ut.keymap('n', '<Leader>gf', '<cmd>Git<CR>')
  ut.keymap('n', '<Leader>gl', '<cmd>GcLog<CR>')
end
