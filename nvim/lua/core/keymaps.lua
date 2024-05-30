local map = vim.keymap.set

-- General --
-------------
-- clears pattern highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- new line below
map("n", "<Leader>o", "o<ESC>", { desc = "new line below" })
map("n", "<Leader>O", "O<ESC>", { desc = "new line above" })

map("n", "fd", "<cmd>cd %:p:h<CR>", { desc = "change [d]irectory" })
map("n", "fc", "<cmd>so %<CR>", { desc = "[s]ource file" })

map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Buffers --
-------------
map("n", "<Leader>bn", "<cmd>bnext<CR>", { desc = "[n]ext buffer" })
map("n", "<Leader>bp", "<cmd>bprev<CR>", { desc = "[p]rev buffer" })
map("n", "<Leader>bD", "<cmd>bdelete<CR>", { desc = "[D]elete buffer + pane" })

-- Windows --
-------------
map("n", "<Leader>w", "<C-w>", { desc = "[W]indow keybind" })
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "inc horiz window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "dec horiz window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "dec vert window height" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "inc vert window height" })

-- Toggles --
-------------
map("n", "<Leader>ts", "<cmd>set list!<CR>", { desc = "white [s]pace" })
map("n", "<Leader>tw", "<cmd>set wrap! <CR>", { desc = "[w]rap line" })
map("n", "<Leader>tn", "<cmd>set number! relativenumber! <CR>", { desc = "[n]umber Line" })

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [d]iagnostic message" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [d]iagnostic message" })
map("n", "<leader>le", vim.diagnostic.open_float, { desc = "Show diagnostic [e]rror messages" })
map("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "Open diagnostic [q]uickfix list" })
