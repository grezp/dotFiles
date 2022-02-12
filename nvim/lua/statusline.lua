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

M.trunc_width = setmetatable({
    mode       = 80,
    git_status = 90,
    filename   = 140,
    -- line_col   = 60,
}, {
    __inde = function()
        return 80
    end
})

M.is_truncated = function(_, width)
    local current_width = api.nvim_win_get_width(0)
    return current_width < width
end

M.modes = setmetatable({
  ['n']  = {'Normal', 'N'};
  ['no'] = {'N·Pending', 'N·P'} ;
  ['v']  = {'Visual', 'V' };
  ['V']  = {'V·Line', 'V·L' };
  -- TODO visual block doesn't work. fix later
  ['']   = {'V·Block', 'V·B'}; -- this is not ^V, but it's , they're different
  ['s']  = {'V·Block', 'V·B'};
  ['s']  = {'Select', 'S'};
  ['S']  = {'S·Line', 'S·L'};
  ['']   = {'S·Block', 'S·B'}; -- same with this one, it's not ^S but it's
  ['i']  = {'Insert', 'I'};
  ['ic'] = {'Insert', 'I'};
  ['R']  = {'Replace', 'R'};
  ['Rv'] = {'V·Replace', 'V·R'};
  ['c']  = {'Command', 'C'};
  ['cv'] = {'Vim·Ex ', 'V·E'};
  ['ce'] = {'Ex ', 'E'};
  ['r']  = {'Prompt ', 'P'};
  ['rm'] = {'More ', 'M'};
  ['r?'] = {'Confirm ', 'C'};
  ['!']  = {'Shell ', 'S'};
  ['t']  = {'Terminal ', 'T'};
}, {
    __index = function()
        return {'Unknown', 'U'} -- handle edge cases
    end
})

M.get_current_mode = function(self)
    local current_mode = api.nvim_get_mode().mode

    if self:is_truncated(self.trunc_width.mode) then
        return string.format(' %s ', self.modes[current_mode][2]):upper()
    end
    return string.format(' %s ', self.modes[current_mode][1]):upper()
end

-- M.get_git_status = function(self)
--   -- use fallback because it doesn't set this variable on the initial `BufEnter`
--   local signs = vim.b.gitsigns_status_dict or {head = '', added = 0, changed = 0, removed = 0}
--   local is_head_empty = signs.head ~= ''
--
--   if self:is_truncated(self.trunc_width.git_status) then
--     return is_head_empty and string.format('  %s ', signs.head or '') or ''
--   end
--
--   return is_head_empty and string.format(
--     ' +%s ~%s -%s |  %s ',
--     signs.added, signs.changed, signs.removed, signs.head
--   ) or ''
-- end

M.get_filename = function(self)
    if self:is_truncated(self.trunc_width.filename) then return " %t " end
    return " %F "
end

M.get_filetype = function()
    local filetype = vim.bo.filetype

    if filetype == '' then return '' end
    return string.format(' %s ', filetype):lower()
end

M.get_buf_number = function()
    return '[%n] '
end

M.get_file_mods = function()
    return '%m%r%w%h'
end

M.get_file_percent = function()
    return ' %2p%% '
end

M.get_line_col = function()
    return ' %2l:%2c '
end

M.get_git_branch = function()
    local branch = vim.fn['fugitive#head']()

    if branch ~= nil and branch:len() > 0 then
        return '<' .. branch .. '>'
    end
 
    return ''
end

M.get_file_fmt = function()
    -- return ' %{%ff} '
    return string.format(' %s ', vim.bo.fileformat)
end

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

M.check_file_ch = function()
    if vim.bo.modified then return true end
    return false
end

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
    local filesize     = colors.rhs_st     .. self:get_filesize()
    local filesize_sep = colors.file_sep   .. self.separators.pipe
    local filefmt      = colors.rhs_st     .. self:get_file_fmt()
    local filefmt_sep  = colors.file_sep   .. self.separators.pipe
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
        filetype, filetype_sep, filefmt, filefmt_sep, filesize, filesize_sep,
        percent, percent_sep, line_col, line_col_sep
    })
end

M.set_inactive = function(self)
    return self.colors.inactive .. '%= %F %='
end

-- M.set_explorer = function(self)
--   local title = self.colors.mode .. '    '
--   local title_alt = self.colors.mode_alt .. self.separators[active_sep][2]
--
--   return table.concat({ self.colors.active, title, title_alt })
-- end

Statusline = setmetatable(M, {
    __call = function(statusline, mode)
        if mode == "active" then return statusline:set_active() end
        if mode == "inactive" then return statusline:set_inactive() end
        -- if mode == "explorer" then return statusline:set_explorer() end
    end
})

-- set statusline
-- TODO: replace this once we can define autocmd using lua
api.nvim_exec([[
    augroup Statusline
    au!
    au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline('active')
    au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline('inactive')
    au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline('explorer')
    augroup END
]], false)

