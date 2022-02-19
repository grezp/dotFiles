local fn = vim.fn
local api = vim.api
local M = {}

-- change them if you want to different separator
M.separators = {
    blank = '',
    pipe = '|'
}

-- highlight groups
M.colors = {
    active        = '%#StatusLine#',
    inactive      = '%#StatuslineNC#',
    mode          = '%#Mode#',
    mode_alt      = '%#ModeAlt#',
    bufnum        = '%#BufferNumber#',
    file_mods     = '%#FileMods#',
    rhs_st        = '%#RhsStatus#',
    rhs_st_alt    = '%#RhsStatusAlt#',
    file_sep      = '%#StatusSep#'
}

M.mode = {
  ['n']    = 'NORMAL',
  ['no']   = 'O-PENDING',
  ['nov']  = 'O-PENDING',
  ['noV']  = 'O-PENDING',
  ['no'] = 'O-PENDING',
  ['niI']  = 'NORMAL',
  ['niR']  = 'NORMAL',
  ['niV']  = 'NORMAL',
  ['nt']   = 'NORMAL',
  ['v']    = 'VISUAL',
  ['vs']   = 'VISUAL',
  ['V']    = 'V-LINE',
  ['Vs']   = 'V-LINE',
  ['']   = 'V-BLOCK',
  ['s']  = 'V-BLOCK',
  ['s']    = 'SELECT',
  ['S']    = 'S-LINE',
  ['']   = 'S-BLOCK',
  ['i']    = 'INSERT',
  ['ic']   = 'INSERT',
  ['ix']   = 'INSERT',
  ['R']    = 'REPLACE',
  ['Rc']   = 'REPLACE',
  ['Rx']   = 'REPLACE',
  ['Rv']   = 'V-REPLACE',
  ['Rvc']  = 'V-REPLACE',
  ['Rvx']  = 'V-REPLACE',
  ['c']    = 'COMMAND',
  ['cv']   = 'EX',
  ['ce']   = 'EX',
  ['r']    = 'REPLACE',
  ['rm']   = 'MORE',
  ['r?']   = 'CONFIRM',
  ['!']    = 'SHELL',
  ['t']    = 'TERMINAL',
}

M.path_type = { FULL = 1, TAIL = 2, NAME = 3, }

-----------------------------------------
-- Function to output status line data --
-----------------------------------------

-- determine mode type
function M.get_current_mode()
    local mode_code = vim.api.nvim_get_mode().mode
    if M.mode[mode_code] == nil then
        return mode_code
    end
    return  ' ' .. M.mode[mode_code] .. ' '
end

-- global var to determine if fmt type and file size are shown
M.show_full_rhs = true

-- detemermine file path base on str size
M.get_file_path_type = function()
    -- TODO: determine file patch based on max_len = buffWindow - Mode - buffNumber - gitBranch - rhs
    --       if (file < max_len) -> return file_path_type
    -- local max_file_len = 50
    local max_file_len = api.nvim_win_get_width(0) - 55
    local max_len_total = max_file_len + 13
    local file_len_full = fn.expand('%:p'):len()
    local file_len_part = fn.expand('%:r'):len()

    if file_len_full < max_file_len then
        M.show_full_rhs = true
        return M.path_type.FULL
    elseif file_len_part < max_file_len then
        M.show_full_rhs = true
        return M.path_type.TAIL
    elseif file_len_full < max_len_total then
        M.show_full_rhs = false
        return M.path_type.FULL
    elseif file_len_part < max_len_total then
        M.show_full_rhs = false
        return M.path_type.FULL
    end

    return M.path_type.NAME
end

-- output file name
M.get_filename = function(self)
    local file_path_type = self:get_file_path_type()

    if file_path_type == M.path_type.FULL then
        return " %F "
    elseif file_path_type == M.path_type.TAIL then
        return " %f "
    end

    return ' %t '
end

-- output buffer number
M.get_buf_number = function()
    return '[%n] '
end

-- output format string for mod files, readonly, preview, and help flag
M.get_file_mods = function()
    return '%m%r%w%h'
end

-- output percentage of file
M.get_file_percent = function()
    return ' %2p%% '
end

-- output row & column str
M.get_line_col = function()
    return ' %2l:%2c '
end

-- output git active branch
M.get_git_branch = function()
   local branch = vim.fn['fugitive#head']()

   if branch ~= nil and branch:len() > 0 then
       return '<' .. branch .. '>'
   end
 
    return ''
end

-- output file type e.g lua, cpp
M.get_filetype = function()
    local filetype = vim.bo.filetype

    if filetype == '' then return '' end
    return string.format(' %s ', filetype):lower()
end

-- output file format e.g. unix
M.get_file_fmt = function()
    return string.format(' %s ', vim.bo.fileformat)
end

-- output file size
M.get_filesize = function()
    local bytes = fn.getfsize(fn.expand('%:p'))
    local kbytes = 0
    local mbytes = 0

    if bytes >= 1024 then
        kbytes = bytes/1024
    end
 
    if kbytes >= 1024 then
        mbytes = kbytes/1024
    end

    if bytes <= 0 then return '0' end

    if mbytes > 0 then
        return string.format(' %dMB ', mbytes)
    elseif kbytes > 0 then
        return string.format(' %dKB ', kbytes)
    else
        return string.format(' %dB ', bytes)
    end
end

-- check if file is modified
M.check_file_ch = function()
    if vim.bo.modified then return true end
    return false
end

-- Build Status Line --
-----------------------

-- construct active status line
M.set_active = function(self)
    local colors = self.colors

    local mode         = colors.mode       .. self:get_current_mode()
    local bufnum       = colors.bufnum     .. self:get_buf_number()
    local gitbranch    = colors.mode       .. self:get_git_branch()
    local filename     = colors.active     .. self:get_filename()
    local filename_ch  = colors.file_mods  .. self:get_filename()
    local filemods     = colors.file_mods  .. self:get_file_mods()
    local filemods_sep = colors.file_sep   .. self.separators.blank
    local filetype     = colors.rhs_st     .. self:get_filetype()
    local filetype_sep = colors.file_sep   .. self.separators.pipe
    local filefmt      = colors.rhs_st     .. self:get_file_fmt()
    local filefmt_sep  = colors.file_sep   .. self.separators.pipe
    local filesize     = colors.rhs_st     .. self:get_filesize()
    local filesize_sep = colors.file_sep   .. self.separators.pipe
    local percent      = colors.rhs_st_alt .. self:get_file_percent()
    local percent_sep  = colors.file_sep   .. self.separators.pipe
    local line_col     = colors.rhs_st_alt .. self:get_line_col()
    local line_col_sep = colors.file_sep   .. self.separators.pipe

    return table.concat({
        -- lhs
        colors.active, mode, bufnum, gitbranch,
        -- middle
        "%=", self:check_file_ch() and filename_ch or filename, filemods, filemods_sep, "%=",
        -- rsh
        filetype, filetype_sep,
        M.show_full_rhs and  filefmt .. filefmt_sep .. filesize ..  filesize_sep or '',
        percent, percent_sep, line_col, line_col_sep
        -- filetype, filetype_sep, filefmt, filefmt_sep, filesize, filesize_sep,
        -- percent, percent_sep, line_col, line_col_sep
    })
end

-- construct inactive status line
M.set_inactive = function(self)
    local filemods     = self.colors.file_mods  .. self:get_file_mods()
    local filemods_sep = self.colors.file_sep   .. self.separators.blank

    return table.concat({
        self.colors.inactive .. "%=", ' %t ', filemods, filemods_sep, "%=",
    })
end

-- M.set_explorer = function(self)
--   local title = self.colors.mode .. '    '
--   local title_alt = self.colors.mode_alt .. self.separators[active_sep][2]
--
--   return table.concat({ self.colors.active, title, title_alt })
-- end

-- define status line
Statusline = setmetatable(M, {
    __call = function(statusline, mode)
        if mode == "active" then return statusline:set_active() end
        if mode == "inactive" then return statusline:set_inactive() end
        -- if mode == "explorer" then return statusline:set_explorer() end
    end
})

-- set statusline
api.nvim_exec([[
    augroup Statusline
    au!
    au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline('active')
    au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline('inactive')
    " au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline('explorer')
    augroup END
]], false)

