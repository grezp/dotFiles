local M = {}

function M.edit_neovim()
  require("telescope.builtin").find_files {
    prompt_title = "~ nvim ~",
    shorten_path = false,
    cwd = "~/.config/nvim",
  }
end

function M.installed_plugins()
  require("telescope.builtin").find_files {
    prompt_title = "~ nvim packages ~",
    cwd = vim.fn.stdpath "data" .. "/site/pack/packer/start/",
  }
end

function M.fd()
  require("telescope.builtin").fd {
    hidden = true,      -- show hidden files
    no_ignore = false,  -- don't show ignore files
    sorting_strategy = "ascending",
  }
end

function M.search_all_files()
  require("telescope.builtin").find_files {
    find_command = {
      "rg",
      "--no-ignore",
      "--files"
    },
  }
end

function M.search_only_certain_files()
  require("telescope.builtin").find_files {
    find_command = {
      "rg",
      "--files",
      "--type",
      vim.fn.input "Type: ",
    },
  }
end

function M.git_files()
  local path = vim.fn.expand "%:h"
  if path == "" then
    path = nil
  end

  require("telescope.builtin").git_files {
    cwd = path,
    use_git_root = true,
  }
end

function M.grep_string()
  require("telescope.builtin").grep_string {
    word_match = "-w",
    sort_only_text = true,
    disable_coordinates = false,
  }
end

function M.grep_last_search(opts)
  opts = opts or {}

  -- \<getreg\>\C
  -- -> Subs out the search things
  local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")

  require("telescope.builtin").grep_string {
    word_match = "-w",
    sort_only_text = true,
    disable_coordinates = false,
    search = register,
  }
end

function M.bookmarks()
  require('telescope').extensions.bookmarks.bookmarks()
end

-- function M.oldfiles()
--   require("telescope").extensions.frecency.frecency()
-- end

-- function M.file_browser()
--   local opts
--
--   opts = {
--     sorting_strategy = "ascending",
--     scroll_strategy = "cycle",
--     layout_config = {
--       prompt_position = "top",
--     },
--
--     attach_mappings = function(prompt_bufnr, map)
--       local current_picker = action_state.get_current_picker(prompt_bufnr)
--
--       local modify_cwd = function(new_cwd)
--         local finder = current_picker.finder
--
--         finder.path = new_cwd
--         finder.files = true
--         current_picker:refresh(false, { reset_prompt = true })
--       end
--
--       map("i", "-", function()
--         modify_cwd(current_picker.cwd .. "/..")
--       end)
--
--       map("i", "~", function()
--         modify_cwd(vim.fn.expand "~")
--       end)
--
--       -- local modify_depth = function(mod)
--       --   return function()
--       --     opts.depth = opts.depth + mod
--       --
--       --     current_picker:refresh(false, { reset_prompt = true })
--       --   end
--       -- end
--       --
--       -- map("i", "<M-=>", modify_depth(1))
--       -- map("i", "<M-+>", modify_depth(-1))
--
--       map("n", "yy", function()
--         local entry = action_state.get_selected_entry()
--         vim.fn.setreg("+", entry.value)
--       end)
--
--       return true
--     end,
--   }
--
--   require("telescope").extensions.file_browser.file_browser(opts)
-- end

-- function M.lsp_references()
--   require("telescope.builtin").lsp_references {
--     layout_strategy = "vertical",
--     layout_config = {
--       prompt_position = "top",
--     },
--     sorting_strategy = "ascending",
--     ignore_filename = false,
--   }
-- end
--
-- function M.lsp_implementations()
--   require("telescope.builtin").lsp_implementations {
--     layout_strategy = "vertical",
--     layout_config = {
--       prompt_position = "top",
--     },
--     sorting_strategy = "ascending",
--     ignore_filename = false,
--   }
-- end

return setmetatable({}, {
  __index = function(_, k)
    if M[k] then
      return M[k]
    else
      return require("telescope.builtin")[k]
    end
  end,
})
