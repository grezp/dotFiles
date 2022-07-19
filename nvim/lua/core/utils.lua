local M = {}

local merge_tb = vim.tbl_deep_extend

M.load_mappings = function(mappings, mapping_opt)
  -- set mapping function with/without whichkey
  local set_maps
  local whichkey_exists, wk = pcall(require, "which-key")

  if whichkey_exists then
    set_maps = function(keybind, mapping_info, opts)
      wk.register({ [keybind] = mapping_info }, opts)
    end
  else
    set_maps = function(keybind, mapping_info, opts)
      local mode = opts.mode
      opts.mode = nil
      vim.keymap.set(mode, keybind, mapping_info[1], opts)
    end
  end

  mappings = mappings or vim.deepcopy(require('core.mappings'))
  mappings.lspconfig = nil

  for _, section in pairs(mappings) do
    for mode, mode_values in pairs(section) do
      for keybind, mapping_info in pairs(mode_values) do
        -- merge default + user opts
        local default_opts = merge_tb('force', { mode = mode }, mapping_opt or {})
        local opts = merge_tb('force', default_opts, mapping_info.opts or {})

        if mapping_info.opts then
          mapping_info.opts = nil
        end

        set_maps(keybind, mapping_info, opts)
      end
    end
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
