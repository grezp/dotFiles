local utils = require('utils')

-- SETTINGS --

-- telescope
require('telescope').load_extension('fzf')

-- Comment.nvim setup
require('Comment').setup()

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

-- WhichKey
require('which-key').setup()


-- MAPPINGS --

-- telescope
utils.Map('<leader>ff', '<cmd>Telescope find_files<cr>')
utils.Map('<leader>fg', '<cmd>Telescope live_grep<cr>')
utils.Map('<leader>fb', '<cmd>Telescope buffers<cr>')
utils.Map('<leader>fh', '<cmd>Telescope help_tags<cr>')

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

