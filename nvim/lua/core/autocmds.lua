local augroup = vim.api.nvim_create_augroup
local aucmd = vim.api.nvim_create_autocmd

-- sets relative number line when focused
-- only show number line when not focused
local in_event = { "WinEnter", "BufEnter", "FocusGained", "InsertLeave" }
local out_event = { "WinLeave", "BufLeave", "FocusLost", "InsertEnter" }
local num_toggle_grp = augroup("numberToggle", { clear = true })

aucmd(in_event, {
	group = num_toggle_grp,
	command = "set relativenumber number",
})
aucmd(out_event, {
	group = num_toggle_grp,
	command = "set norelativenumber number",
})

-- removes highlight cursor when not focused
local cursor_focus_grp = augroup("cursorFocus", { clear = true })
aucmd(in_event, {
	group = cursor_focus_grp,
	pattern = "*",
	command = "set cursorline",
})
aucmd(out_event, {
	group = cursor_focus_grp,
	pattern = "*",
	command = "set nocursorline",
})

-- disable auto-comments on new line
local auto_comment_grp = augroup("noAutoComments", { clear = true })
aucmd({ "BufEnter", "BufRead" }, {
	group = auto_comment_grp,
	pattern = "*",
	command = "set fo-=c fo-=r fo-=o",
})

-- go to last loc when opening a buffer
aucmd("BufReadPost", {
	command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
})

-- windows to close with 'q'
aucmd("FileType", {
	pattern = { "help", "startuptime", "qf", "lspinfo" },
	command = [[nnoremap <buffer><silent> q :close<CR>]],
})
aucmd("FileType", {
	pattern = "man",
	command = [[nnoremap <buffer><silent> q :quit<CR>]],
})

-- dont list quickfix buffers
aucmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- vim: ts=2 sts=2 sw=2 et
