local utils = require('utils')

--------------
-- SETTINGS --
--------------

-- simple setups --
require('telescope').load_extension('fzf')
require('Comment').setup()
require('which-key').setup()
require('mkdir')
require('gitsigns').setup()

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
utils.Map([[<leader>ff]], [[<cmd>lua require('telescope.builtin').find_files()<cr>]])
utils.Map([[<leader>fg]], [[<cmd>lua require('telescope.builtin').live_grep()<cr>]])
utils.Map([[<leader>fb]], [[<cmd>lua require('telescope.builtin').buffers()<cr>]])
utils.Map([[<leader>fh]], [[<cmd>lua require('telescope.builtin').help_tags()<cr>]])
utils.Map([[<leader>f/]], [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]])
utils.Map([[<leader>fc]], [[<cmd>lua require('telescope.builtin').command_history()<cr>]])
utils.Map([[<leader>fo]], [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]])
utils.Map([[<leader>fm]], [[<cmd>lua require('telescope.builtin').man_pages()<cr>]])
utils.Map([[<leader>f']], [[<cmd>lua require('telescope.builtin').marks()<cr>]])
utils.Map([[<leader>f"]], [[<cmd>lua require('telescope.builtin').registers()<cr>]])

-- NrwwRgn --
utils.Map('<Leader>nn', ':NR!<CR>')
utils.Map('<Leader>ns', ':WR<CR>:bdelete!<CR>')

-- WhichKey --
utils.Ex.cabbrev('W', 'WhichKey')

-- hlslens --
utils.Nmap('n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]])
utils.Nmap('N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]])
utils.Nmap('*', [[*<Cmd>lua require('hlslens').start()<CR>]])
utils.Nmap('#', [[#<Cmd>lua require('hlslens').start()<CR>]])
utils.Nmap('g*', [[g*<Cmd>lua require('hlslens').start()<CR>]])
utils.Nmap('g#', [[g#<Cmd>lua require('hlslens').start()<CR>]])

utils.Xmap('*', [[*<Cmd>lua require('hlslens').start()<CR>]])
utils.Xmap('#', [[#<Cmd>lua require('hlslens').start()<CR>]])
utils.Xmap('g*', [[g*<Cmd>lua require('hlslens').start()<CR>]])
utils.Xmap('g#', [[g#<Cmd>lua require('hlslens').start()<CR>]])

-- bufdelete --
utils.Nmap('<Leader>bd', [[:lua require('bufdelete').bufdelete(0, true)<CR>]])

-- fugitive
utils.Nmap('<Leader>gg', '<cmd>Git<CR>')
utils.Nmap('<Leader>gl', '<cmd>GcLog<CR>')

-- gitsigns --
utils.Nmap(']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
utils.Nmap('[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

utils.Map('<leader>hs', ':Gitsigns stage_hunk<CR>')
utils.Map('<leader>hu', ':Gitsigns undo_stage_hunk<CR>')
utils.Map('<leader>hr', ':Gitsigns reset_hunk<CR>')
utils.Nmap('<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
utils.Nmap('<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
utils.Nmap('<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
utils.Nmap('<leader>hb', '<cmd>lua require"gitsigns".blame_line {full=true, ignore_whitespace=true}<CR>')
utils.Nmap('<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
utils.Nmap('<leader>hd', '<cmd>Gitsigns diffthis<CR>')
utils.Nmap('<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
utils.Nmap('<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')
 
