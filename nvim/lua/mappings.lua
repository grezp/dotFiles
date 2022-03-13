local ut = require('utils')

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
ut.keymap('n', '<Leader>bD', ':bdelete<CR>')              -- delete buffer

-- windows
ut.keymap('',  '<Leader>w', '<C-w>')           -- window keybind
ut.keymap('n', '<Leader>w+', '10<C-w>+')      -- inc window height
ut.keymap('n', '<Leader>w-', '10<C-w>-')      -- dec window height
ut.keymap('n', '<leader>w>', '30<C-w>>')      -- inc > window height
ut.keymap('n', '<leader>w<', '30<C-w><')      -- inc < window height

-- terminal
ut.keymap('t', '<Leader><Esc>', '<C-\\><C-n>')

-- misc.
ut.keymap('n', '<Leader>cd', 'cd %:p:h<CR>')        -- change neovim directory to current file
ut.keymap('n', '<Leader>*', [[<Cmd>let @/='\<'.expand('<cword>').'\>'<bar>set hlsearch<CR>]]) -- highlight word w/o moving

