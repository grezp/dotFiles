local utils = require('utils')

--------------
-- SETTINGS --
--------------

-- simple setups
require('telescope').load_extension('fzf')
require('Comment').setup()
require('which-key').setup()
require('mkdir')

-- indent blankline
vim.g.indent_blankline_char = '┊'
require('indent_blankline').setup {
  show_current_context = true,
}

-- nvim treesitter
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

-- telescope
utils.Map([[<leader>ff]], [[<cmd>lua require('telescope.builtin').find_files()<cr>]])
utils.Map([[<leader>fg]], [[require('telescope.builtin').live_grep()<cr>]])
utils.Map([[<leader>fb]], [[<cmd>lua require('telescope.builtin').buffers()<cr>]])
utils.Map([[<leader>fh]], [[<cmd>lua require('telescope.builtin').help_tags()<cr>]])
utils.Map([[<leader>f/]], [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]])
utils.Map([[<leader>fc]], [[<cmd>lua require('telescope.builtin').command_history()<cr>]])
utils.Map([[<leader>fo]], [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]])
utils.Map([[<leader>fm]], [[<cmd>lua require('telescope.builtin').man_pages()<cr>]])
utils.Map([[<leader>f']], [[<cmd>lua require('telescope.builtin').marks()<cr>]])
utils.Map([[<leader>f"]], [[<cmd>lua require('telescope.builtin').registers()<cr>]])

-- NrwwRgn
utils.Map('<Leader>nn', ':NR!<CR>')
utils.Map('<Leader>ns', ':WR<CR>:bdelete!<CR>')

-- WhichKey
utils.Ex.cabbrev('W', 'WhichKey')

-- hlslens
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

-- bufdelete
utils.Nmap('<Leader>bd', [[:lua require('bufdelete').bufdelete(0, true)<CR>]])

