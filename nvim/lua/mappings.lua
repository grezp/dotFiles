local utils = require('utils')

-- general
utils.Map('<Leader>o', 'o<Esc>k')         -- enter new line below & goto normal mode
utils.Map('<Leader>O', 'O<Esc>j')         -- enter new line above & goto normal mode
utils.Nmap('<Leader>,', ':noh<CR>')       -- stop search highlight

-- system file
utils.Nmap('<Leader>s', ':w<CR>')     -- saves current file
utils.Nmap('<Leader>q', ':q<CR>')     -- exit window
utils.Nmap('<Leader>Q', ':q!<CR>')    -- exit window w/o saving

-- buffers
utils.Nmap('<Leader>bb', ':ls<CR>:buffer<Space>')     -- list buffers, then select
utils.Nmap('<Leader>bl', ':ls<CR>')                   -- list buffers
utils.Nmap('<Leader>bn', ':bnext<CR>')                -- next buffer
utils.Nmap('<Leader>bp', ':bprev<CR>')                -- prev buffer
utils.Nmap('<Leader>bd', ':bdelete<CR>')              -- delete buffer

-- windows
utils.Map('<Leader>w', '<C-w>')           -- window keybind
utils.Nmap('<Leader>w+', '10<C-w>+')      -- inc window height
utils.Nmap('<Leader>w-', '10<C-w>-')      -- dec window height
utils.Nmap('<leader>w>', '30<C-w>>')      -- inc > window height
utils.Nmap('<leader>w<', '30<C-w><')      -- inc < window height

-- terminal
utils.Tmap('<Leader><Esc>', '<C-\\><C-n>')

