
local function map_generic(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local function map(shortcut, command)
  map_generic('', shortcut, command)
end

local function nmap(shortcut, command)
  map_generic('n', shortcut, command)
end

local function tmap(shortcut, command)
  map_generic('t', shortcut, command)
end

local ex = setmetatable({}, {
  __index = function(t, k)
    local command = k:gsub("_$", "!")
    local f = function(...)
      return vim.api.nvim_command(table.concat(vim.tbl_flatten {command, ...}, " "))
    end
    rawset(t, k, f)
    return f
  end
})


-- general
map('<Leader>o', 'o<Esc>k')         -- enter new line below & goto normal mode
map('<Leader>O', 'O<Esc>j')         -- enter new line above & goto normal mode
nmap('<Leader>,', ':noh<CR>')       -- stop search highlight

-- system file
nmap('<Leader>s', ':w<CR>')     -- saves current file
nmap('<Leader>q', ':q<CR>')     -- exit window
nmap('<Leader>Q', ':q!<CR>')    -- exit window w/o saving

-- buffers
nmap('<Leader>bb', ':ls<CR>:buffer<Space>')     -- list buffers, then select
nmap('<Leader>bl', ':ls<CR>')           -- list buffers

-- windows
map('<Leader>w', '<C-w>')           -- window keybind
nmap('<Leader>w+', '10<C-w>+')      -- inc window height
nmap('<Leader>w-', '10<C-w>-')      -- dec window height
nmap('<leader>w>', '30<C-w>>')      -- inc > window height
nmap('<leader>w<', '30<C-w><')      -- inc < window height

-- terminal
tmap('<Leader><Esc>', '<C-\\><C-n>')

-- plugin maps

-- FZF
map('<Leader>ff', ':FZF<CR>')
map('<Leader>fb', ':Buffers<CR>')    -- fzf buffer
map('<Leader>fr', ':Rg<CR>')         -- fzf ripgrep search

-- NrwwRgn
map('<Leader>nn', ':NR!<CR>')
map('<Leader>ns', ':WR<CR>:bdelete!<CR>')

-- WhichKey
ex.cabbrev('W', 'WhichKey')
