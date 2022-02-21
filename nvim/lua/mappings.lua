
local function map_generic(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local function map(shortcut, command)
  map_generic('', shortcut, command)
end

local function nmap(shortcut, command)
  map_generic('n', shortcut, command)
end

-- general
map('<Leader>o', 'o<Esc>k')         -- enter new line below & goto normal mode
map('<Leader>O', 'O<Esc>j')         -- enter new line above & goto normal mode
nmap('<Leader>,', ':noh<CR>')       -- stop search highlight

-- system file
nmap('<Leader>s', ':w<CR>')     -- saves current file
nmap('<Leader>q', ':q<CR>')     -- exit window
nmap('<Leader>Q', ':q!<CR>')    -- exit window w/o saving

-- buffers
nmap('gb', ':ls<CR>:buffer<Space>')     -- list buffers, then select
nmap('<Leader>bl', ':ls<CR>')           -- list buffers

-- windows
map('<Leader>w', '<C-w>')           -- window keybind
nmap('<Leader>w+', '10<C-w>+')      -- inc window height
nmap('<Leader>w-', '10<C-w>-')      -- dec window height
nmap('<leader>w>', '30<C-w>>')      -- inc > window height
nmap('<leader>w<', '30<C-w><')      -- inc < window height

-- plugin maps

-- FZF
map('<Leader>ff', ':FZF<CR>')
map('<Leader>fb', ':Buffers<CR>')    -- fzf buffer
map('<Leader>fg', ':Rg<CR>')         -- fzf ripgrep search

-- NrwwRgn
map('<Leader>nn', ':NR!<CR>')
map('<Leader>ns', ':WR<CR>:bdelete!<CR>')
