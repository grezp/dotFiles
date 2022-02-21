
-- removes relative number line when not focused
-- vim.o.number = true
-- vim.o.relativenumber = true
vim.cmd([[
    augroup numbertoggle
        autocmd!
        " relative nr when focused
        autocmd BufEnter,FocusGained,InsertLeave * set relativenumber number
        " normal nw when not focused
        autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber number
    augroup END
]])

-- removes highlight cursor when not focused
vim.cmd([[
    augroup cursorFocus
        autocmd!
        " cursor highlight when focused
        autocmd BufEnter,FocusGained,InsertLeave * set cursorline
        " no cursor when not focused
        autocmd BufLeave,FocusLost,InsertEnter   * set nocursorline
    augroup END
]])

-- stop from auto unfolding while in insert mode
-- vim.cmd([[
--     augroup manAutoBrackets
--         autocmd!
--         autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
--         autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
--     augroup END
-- ]])

-- vim.cmd([[
--     augroup indentFolds
--         autocmd!
--         autocmd FileType ruby setlocal foldmethod=indent
--     augroup END
-- ]])

-- disable auto-comments on new line
vim.cmd[[ autocmd BufEnter,BufRead * setlocal formatoptions-=cro ]]
