
-- removes relative number line when not focused
vim.cmd([[
  augroup numbertoggle
    autocmd!
    " relative nr when focused
    autocmd WinEnter,BufEnter,FocusGained,InsertLeave * set relativenumber number
    " normal nw when not focused
    autocmd WinLeave,BufLeave,FocusLost,InsertEnter   * set norelativenumber number
  augroup END
]])

-- removes highlight cursor when not focused
vim.cmd([[
  augroup cursorFocus
    autocmd!
    " cursor highlight when focused
    autocmd WinEnter,BufEnter,FocusGained,InsertLeave * set cursorline
    " no cursor when not focused
    autocmd WinLeave,BufLeave,FocusLost,InsertEnter   * set nocursorline
  augroup END
]])

-- disable auto-comments on new line
vim.cmd[[
  augroup noComments
      autocmd!
      autocmd BufEnter,BufRead * setlocal formatoptions-=cro
  augroup END
  ]]
