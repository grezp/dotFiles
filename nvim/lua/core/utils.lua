local M = {}

-- generic keymaps --
M.keymap = function(mode, shortcut, command, opts)
  opts = opts or { noremap = true, silent = true }

  if type(mode) == 'table' then
    for _, m in ipairs(mode) do
      vim.api.nvim_set_keymap(m, shortcut, command, opts)
    end
  else
    vim.api.nvim_set_keymap(mode, shortcut, command, opts)
  end
end

-- generic buffer keymaps --
M.buf_keymap = function(bufnr, mode, shortcut, command, opts)
  opts = opts or { noremap = true, silent = true }

  if type(mode) == 'table' then
    for _, m in pairs(mode) do
      vim.api.nvim_buf_set_keymap(bufnr, m, shortcut, command, opts)
    end
  else
    vim.api.nvim_buf_set_keymap(bufnr, mode, shortcut, command, opts)
  end
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

-- check if file exist
M.file_exists = function (name)
   local f=io.open(name,'r')
   if f~=nil then io.close(f) return true else return false end
end

return M
