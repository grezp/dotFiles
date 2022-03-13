local ut = require('utils')

--------------
-- SETTINGS --
--------------

-- simple setups --
require('telescope').load_extension('fzf')
require('Comment').setup()
require('which-key').setup()
require('mkdir')

-- gitsigns --
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

-- indent blankline --
vim.g.indent_blankline_char = '┊'
require('indent_blankline').setup {
  show_current_context = true,
}

-- nvim treesitter --
require'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained',
  sync_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}


--------------
-- MAPPINGS --
--------------

-- telescope --
ut.keymap('', [[<leader>ff]], [[<cmd>lua require('telescope.builtin').find_files()<cr>]])
ut.keymap('', [[<leader>fg]], [[<cmd>lua require('telescope.builtin').live_grep()<cr>]])
ut.keymap('', [[<leader>fb]], [[<cmd>lua require('telescope.builtin').buffers()<cr>]])
ut.keymap('', [[<leader>fh]], [[<cmd>lua require('telescope.builtin').help_tags()<cr>]])
ut.keymap('', [[<leader>f/]], [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]])
ut.keymap('', [[<leader>fc]], [[<cmd>lua require('telescope.builtin').command_history()<cr>]])
ut.keymap('', [[<leader>fo]], [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]])
ut.keymap('', [[<leader>fm]], [[<cmd>lua require('telescope.builtin').man_pages()<cr>]])
ut.keymap('', [[<leader>f']], [[<cmd>lua require('telescope.builtin').marks()<cr>]])
ut.keymap('', [[<leader>f"]], [[<cmd>lua require('telescope.builtin').registers()<cr>]])

-- NrwwRgn --
ut.keymap('', '<Leader>nn', ':NR!<CR>')
ut.keymap('', '<Leader>ns', ':WR<CR>:bdelete!<CR>')

-- WhichKey --
ut.Ex.cabbrev('W', 'WhichKey')

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
ut.keymap('n', '<Leader>gg', '<cmd>Git<CR>')
ut.keymap('n', '<Leader>gl', '<cmd>GcLog<CR>')

-- gitsigns --
ut.keymap('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
ut.keymap('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

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

