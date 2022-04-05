local ut = require('user.utils')
local blankline_status_ok, blankline = pcall(require, 'indent_blankline')

-------------------
-- SIMPLE SETUPS --
-------------------

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


---------------------
-- PLUGIN MAPPINGS --
---------------------

-- NrrwRgn --
ut.keymap('', '<Leader>nn', ':NR!<CR>')
ut.keymap('', '<Leader>ns', ':WR<CR>:bdelete!<CR>')

-- hlslens --
ut.keymap('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]])
ut.keymap('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]])
ut.keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]])
ut.keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]])
ut.keymap('x', '*', [[*<Cmd>lua require('hlslens').start()<CR>]])
ut.keymap('x', '#', [[#<Cmd>lua require('hlslens').start()<CR>]])

-- bufdelete --
ut.keymap('n', '<Leader>bd', [[:lua require('bufdelete').bufdelete(0, true)<CR>]])

-- fugitive
ut.keymap('n', '<Leader>gf', '<cmd>Git<CR>')
ut.keymap('n', '<Leader>gl', '<cmd>GcLog<CR>')
