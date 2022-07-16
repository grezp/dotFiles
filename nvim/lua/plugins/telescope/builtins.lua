local M = {}

function M.edit_neovim()
  require('telescope.builtin').find_files {
    prompt_title = '~ nvim ~',
    shorten_path = false,
    cwd = '~/.config/nvim',
    find_command = {
      'fd',
      '--type',
      'f',
      '--strip-cwd-prefix'
    },
  }
end

function M.installed_plugins()
  require('telescope.builtin').find_files {
    prompt_title = '~ nvim packages ~',
    cwd = vim.fn.stdpath 'data' .. '/site/pack/packer/start/',
    find_command = {
      'fd',
      '--type',
      'f',
      '--strip-cwd-prefix'
    },
  }
end

function M.fd()
  require('telescope.builtin').fd {
    hidden = false,     -- don't show hidden files
    no_ignore = false,  -- don't show ignore files
    sorting_strategy = 'ascending',
    find_command = {
      'fd',
      '--type',
      'f',
      '--strip-cwd-prefix'
    },
  }
end

function M.search_all_files()
  require('telescope.builtin').find_files {
    find_command = {
      'rg',
      '--no-ignore',
      '--files'
    },
  }
end

function M.search_only_certain_files()
  require('telescope.builtin').find_files {
    find_command = {
      'rg',
      '--files',
      '--type',
      vim.fn.input 'Type: ',
    },
  }
end

function M.git_files()
  local path = vim.fn.expand '%:h'
  if path == '' then
    path = nil
  end

  require('telescope.builtin').git_files {
    cwd = path,
    use_git_root = true,
  }
end

function M.grep_string()
  require('telescope.builtin').grep_string {
    word_match = '-w',
    sort_only_text = true,
    disable_coordinates = false,
  }
end

function M.grep_last_search(opts)
  opts = opts or {}

  -- \<getreg\>\C
  -- -> Subs out the search things
  local register = vim.fn.getreg('/'):gsub('\\<', ''):gsub('\\>', ''):gsub('\\C', '')

  require('telescope.builtin').grep_string {
    word_match = '-w',
    sort_only_text = true,
    disable_coordinates = false,
    search = register,
  }
end

function M.grep_only_certain_files()
  require('telescope.builtin').live_grep {
    find_command = {
      'rg',
      '--files',
      '--type',
      vim.fn.input 'Type: ',
    },
  }
end

function M.bookmarks()
  require('telescope').extensions.bookmarks.bookmarks()
end

function M.oldfiles()
  require('telescope').extensions.frecency.frecency()
end

function M.lsp_refs()
  require('telescope.builtin').lsp_references {
    ignore_filename = false,
  }
end

function M.lsp_defs()
  require('telescope.builtin').lsp_definitions {
    ignore_filename = false,
  }
end

function M.lsp_impl()
  require('telescope.builtin').lsp_implementations {
    ignore_filename = false,
  }
end

function M.lsp_global_symbols()
  require('telescope.builtin').lsp_dynamic_workspace_symbols {
    ignore_filename = false,
  }
end

function M.diags()
  require('telescope.builtin').diagnostics {
  }
end

TelescopeMapArgs = TelescopeMapArgs or {}

M.map_tele = function(key, f, options, buffer)
  local map_key = vim.api.nvim_replace_termcodes(f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  local mode = 'n'
  local cmd = [[<cmd>lua require('plugins.telescope.builtins')]]
  cmd = cmd .. [[['%s'](TelescopeMapArgs['%s'])<CR>]]
  local rhs = string.format(cmd, f, map_key)

  local map_options = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  else
    vim.api.nvim_buf_set_keymap(buffer, mode, key, rhs, map_options)
    end
end

return setmetatable({}, {
  __index = function(_, k)
    if M[k] then
      return M[k]
    else
      return require('telescope.builtin')[k]
    end
  end,
})
