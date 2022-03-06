local M = {}

local map_generic = function(mode, shortcut, command, opts)
  opts = opts or { noremap = true, silent = true }
  vim.api.nvim_set_keymap(mode, shortcut, command, opts)
end

-- map to any mone
M.Map = function(shortcut, command, opts)
  map_generic('', shortcut, command, opts)
end

-- map in normal mode
M.Nmap = function(shortcut, command, opts)
  map_generic('n', shortcut, command, opts)
end

-- map in terminal mode
M.Tmap = function(shortcut, command, opts)
  map_generic('t', shortcut, command, opts)
end

M.Ex = setmetatable({}, {
  __index = function(t, k)
    local command = k:gsub('_$', '!')
    local f = function(...)
      return vim.api.nvim_command(table.concat(vim.tbl_flatten {command, ...}, ' '))
    end
    rawset(t, k, f)
    return f
  end
})

return M
