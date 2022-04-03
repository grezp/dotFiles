TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(key, f, options, buffer)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  local mode = "n"
  local rhs = string.format("<cmd>lua require('user.telescope.builtins')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

  local map_options = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end

vim.api.nvim_set_keymap("c", "<c-r><c-r>", "<Plug>(TelescopeFuzzyCommandSearch)", { noremap = false, nowait = true })

-- Dotfiles
map_tele("<leader>fn", "edit_neovim")
map_tele("<leader>fp", "installed_plugins")

-- Search
map_tele("<leader>fg", "live_grep")
map_tele("<leader>fw", "grep_string")
map_tele("<leader>fl", "grep_last_search")
-- map_tele("<leader>fe", "file_browser") -- extension

-- Files
map_tele("<leader>ff", "fd")
map_tele("<leader>fa", "search_all_files")
map_tele("<leader>fz", "search_only_certain_files")
map_tele("<leader>fo", "oldfiles")

-- Git
-- map_tele("<leader>ft", "git_files")
-- map_tele("<leader>gs", "git_status")
-- map_tele("<leader>gc", "git_commits")

-- Nvim
map_tele("<leader>fb", "buffers")
map_tele("<leader>f/", "current_buffer_fuzzy_find")
map_tele("<leader>fh", "help_tags")
map_tele("<leader>fv", "vim_options")
map_tele("<leader>fm", "man_pages")
map_tele("<leader>f'", "marks")
map_tele('<leader>f"', "registers")

-- Telescope Meta
map_tele("<leader>f<leader>", "builtin")

-- lsp
-- map_tele("<leader>fl", "lsp_implementations")
-- map_tele("<leader>fl", "lsp_references")

-- extensions
map_tele('<leader>fs', "bookmarks")

return map_tele
