local status_ok, ut = pcall(require, 'user.utils')
if not status_ok then
  vim.notify('user.utils not found')
  return
end

-- general
ut.keymap('',  '<Leader>o', 'o<Esc>k')         -- enter new line below & goto normal mode
ut.keymap('',  '<Leader>O', 'O<Esc>j')         -- enter new line above & goto normal mode
ut.keymap('n', '<Leader>,', ':noh<CR>')       -- stop search highlight
ut.keymap('n', '<Leader>rr', [[<cmd>source %<CR>]])

-- system file
ut.keymap('n', '<Leader>s', ':w<CR>')     -- saves current file
ut.keymap('n', '<Leader>q', ':q<CR>')     -- exit window
ut.keymap('n', '<Leader>Q', ':q!<CR>')    -- exit window w/o saving

-- buffers
ut.keymap('n', '<Leader>bb', ':ls<CR>:buffer<Space>')     -- list buffers, then select
ut.keymap('n', '<Leader>bl', ':ls<CR>')                   -- list buffers
ut.keymap('n', '<Leader>bn', ':bnext<CR>')                -- next buffer
ut.keymap('n', '<Leader>bp', ':bprev<CR>')                -- prev buffer
ut.keymap('n', '<Leader>bd', ':Bdelete<CR>')              -- delete buffer
ut.keymap('n', '<Leader>bD', ':bdelete<CR>')              -- delete buffer

-- windows
ut.keymap('',  '<Leader>w', '<C-w>')                    -- window keybind
ut.keymap('n', '<C-Up>',    ':resize +2<CR>')           -- inc ^ window height
ut.keymap('n', '<C-Down>',  ':resize -2<CR>')           -- dec v window height
ut.keymap('n', '<C-Left>',  ':vertical resize -2<CR>')  -- inc > window height
ut.keymap('n', '<C-Right>', ':vertical resize +2<CR>')  -- inc < window height

-- text manipulation
ut.keymap('v', 'J', [[:move .+1<CR>==]])        -- move selected text ^ cursor
ut.keymap('v', 'K', [[:move .-2<CR>==]])        -- move selected text v cursor
ut.keymap('x', 'J', [[:move '>+1<CR>gv-gv]])    -- move selected text ^ cursor
ut.keymap('x', 'K', [[:move '<-2<CR>gv-gv]])    -- move selected text v cursor

-- keep prev copy in buffer 0
ut.keymap('v', 'p', '"_dP')

-- file explorer
ut.keymap('n', '<Leader>te', ':Lex 30<CR>')   -- toggles netrw as left vert split

-- terminal
ut.keymap('t', '<Leader><Esc>', '<C-\\><C-n>')

-- misc.
ut.keymap('n', '<Leader>cd', 'cd %:p:h<CR>')        -- change neovim directory to current file
ut.keymap('n', '<Leader>*', [[<Cmd>let @/='\<'.expand('<cword>').'\>'<bar>set hlsearch<CR>]]) -- highlight word w/o moving

-------------
-- Plugins --
-------------

-- telescope
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
