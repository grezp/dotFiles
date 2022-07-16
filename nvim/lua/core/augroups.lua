local augroup = vim.api.nvim_create_augroup
local aucmd = vim.api.nvim_create_autocmd

-- sets relative number line when focused
-- only show number line when not focused
local in_event  = { 'WinEnter', 'BufEnter', 'FocusGained', 'InsertLeave' }
local out_event = { 'WinLeave', 'BufLeave', 'FocusLost', 'InsertEnter' }
local num_toggle_grp = augroup('numberToggle', { clear = true })

aucmd(in_event, {
   group = num_toggle_grp,
  command = 'set relativenumber number',
})
aucmd(out_event, {
  group = num_toggle_grp,
  command = 'set norelativenumber number',
})

-- removes highlight cursor when not focused
local cursor_focus_grp = augroup('cursorFocus', { clear = true })
aucmd(in_event, {
  group = cursor_focus_grp,
  command = 'set cursorline',
})
aucmd(out_event, {
  group = cursor_focus_grp,
  command = 'set nocursorline',
})

-- disable auto-comments on new line
local auto_comment_grp = augroup('noAutoComments', { clear = true })
aucmd({ 'BufEnter', 'BufRead' }, {
  group = auto_comment_grp,
  command = 'setlocal formatoptions-=cro',
})

-- reloads neovim whenever plugins.lua file is saved
local packer_grp = augroup('packer_user_config', { clear = true })
aucmd('BufWritePost', {
  group = packer_grp,
  pattern = 'plugins.lua',
  command = 'source <afile> | PackerSync',
})
