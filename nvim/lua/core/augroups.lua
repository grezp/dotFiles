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
  pattern = '*',
  command = 'set cursorline',
})
aucmd(out_event, {
  group = cursor_focus_grp,
  pattern = '*',
  command = 'set nocursorline',
})

-- disable auto-comments on new line
local auto_comment_grp = augroup('noAutoComments', { clear = true })
aucmd({ 'BufEnter', 'BufRead' }, {
  group = auto_comment_grp,
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})

-- reloads neovim whenever plugins.lua file is saved
local packer_grp = augroup('packer_user_config', { clear = true })
aucmd('BufWritePost', {
  group = packer_grp,
  pattern = 'packer.lua',
  command = 'source <afile> | PackerSync',
})

-- go to last loc when opening a buffer
aucmd( 'BufReadPost', {
  command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]]
})

-- windows to close with 'q'
aucmd( 'FileType', {
  pattern = { 'help', 'startuptime', 'qf', 'lspinfo' },
  command = [[nnoremap <buffer><silent> q :close<CR>]]
})
aucmd('FileType', {
  pattern = 'man',
  command = [[nnoremap <buffer><silent> q :quit<CR>]]
})

-- dont list quickfix buffers
aucmd('FileType', {
   pattern = 'qf',
   callback = function()
      vim.opt_local.buflisted = false
   end,
})

-- store listed buffers in tab local var
vim.t.bufs = vim.api.nvim_list_bufs()

-- autocmds for tabufline -> store bufnrs on bufadd, bufenter events
-- thx to https://github.com/ii14 & stores buffer per tab -> table
aucmd({ "BufAdd", "BufEnter" }, {
  callback = function(args)
    if vim.t.bufs == nil then
      vim.t.bufs = { args.buf }
    else
      local bufs = vim.t.bufs

      -- check for duplicates
      if not vim.tbl_contains(bufs, args.buf) and (args.event == "BufAdd" or vim.bo[args.buf].buflisted) then
        table.insert(bufs, args.buf)
        vim.t.bufs = bufs
      end
    end
  end,
})

aucmd("BufDelete", {
  callback = function(args)
    for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
      local bufs = vim.t[tab].bufs
      if bufs then
        for i, bufnr in ipairs(bufs) do
          if bufnr == args.buf then
            table.remove(bufs, i)
            vim.t[tab].bufs = bufs
            break
          end
        end
      end
    end
  end,
})
