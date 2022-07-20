local fn = vim.fn
local api = vim.api
local M = {}
local status_ok, _ = pcall(require, 'tokyonight')

-- change them if you want to different separator
M.separators = {
  blank = '',
  pipe = '|',
  rh_arrow = '',
  lh_arrow = '',
  rs_arrow = '',
  ls_arrow = '',
}

-- highlight groups
M.colors = {
  active        = '%#StatusLine#',
  inactive      = '%#StatuslineNC#',
  inactive_alt  = '%#StatuslineNCAlt#',
  active_alt    = '%#StatusLineAlt#',
  file_mods     = '%#FileMods#',
  file_mods_inv = '%#FileModsInv#',
  alt_bg        = '%#AltToBg#',
  alt_ch        = '%#AltToCh#',

  normal        = '%#NormalModeStatus#',
  normal_inv    = '%#NormalModeStatusInv#',
  insert        = '%#InsertModeStatus#',
  visual        = '%#VisualModeStatus#',
  replace       = '%#ReplaceModeStatus#',
  other         = '%#OtherModeStatus#',

  normal_alt    = '%#NormalModeAltStatus#',
  insert_alt    = '%#InsertModeAltStatus#',
  visual_alt    = '%#VisualModeAltStatus#',
  replace_alt   = '%#ReplaceModeAltStatus#',
  other_alt     = '%#OtherModeAltStatus#',
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
  local mode_code = api.nvim_get_mode().mode
  local mode_str = M.mode[mode_code]
  local data = {}

  if mode_str == nil then
    data.mode = mode_code
    data.color = M.colors.other
    return data
  end

  if mode_str == 'NORMAL' then
    data.color = M.colors.normal
    data.color_alt = M.colors.normal_alt
  elseif mode_str == 'VISUAL' or mode_str == 'V-LINE' or mode_str == 'V-BLOCK' then
    data.color = M.colors.visual
    data.color_alt = M.colors.visual_alt
  elseif mode_str == 'INSERT' then
    data.color = M.colors.insert
    data.color_alt = M.colors.insert_alt
  elseif mode_str == 'REPLACE' or mode_str == 'V-REPLACE' then
    data.color = M.colors.replace
    data.color_alt = M.colors.replace_alt
  else
    data.color = M.colors.other
    data.color_alt = M.colors.other_alt
  end

  data.mode = ' ' .. M.mode[mode_code] .. ' '

  return  data
end

-- detemermine file path base on str size + show/hide rhs status
M.get_file_path_type = function()
  local max_file_len = api.nvim_win_get_width(0) - 55
  local file_len = fn.fnamemodify(fn.expand('%'), ':~:.'):len()
  local data = {}

  if file_len < max_file_len then
    data.type = M.path_type.TAIL
  else
    data.type = M.path_type.NAME
  end

  return data
end

-- output file name + show/hide rhs boolean
M.get_filename = function(self)
  local type = self:get_file_path_type()
  local data = {}

  if  type.type == M.path_type.TAIL then
    data.type = ' %f '
  else
    data.type = ' %t '
  end

  return data
end

-- output buffer number
M.get_buf_number = function()
  return ' %n '
end

-- output readonly flag
M.get_readonly = function()
  if vim.o.readonly then return ' RO ' end

  return ''
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
  local branch = vim.fn['FugitiveHead']()

  if branch ~= nil and branch:len() > 0 then
    return '  ' .. branch .. ' '
  end

  return ''
end

-- output file type e.g lua, cpp
M.get_filetype = function()
  local d = {}
  d.data = vim.bo.filetype
  d.show = true

  if d.data == '' or d.data == nil then
    d.show = false
  else
    d.data = ' ' .. d.data .. ' '
  end

  return d
end

-- output file format e.g. unix
M.get_file_fmt = function()
  return ' ' .. vim.bo.fileformat .. ' '
end

-- output file size
M.get_filesize = function()
  local bytes = fn.getfsize(fn.expand('%:p'))
  local kbytes = 0
  local mbytes = 0
  local d = {}
  d.show = true

  if bytes >= 1024 then
      kbytes = bytes/1024
  end

  if kbytes >= 1024 then
      mbytes = kbytes/1024
  end

  if mbytes > 0 then
    d.data = string.format(' %dMB ', mbytes)
  elseif kbytes > 0 then
    d.data = string.format(' %dKB ', kbytes)
  elseif bytes > 0 then
    d.data = string.format(' %dB ', bytes)
  else
    d.data = 0
    d.show = false
  end

  return d
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
  local curr_mode = self:get_current_mode()
  local file_ch = self:check_file_ch()
  local file = self:get_filename()
  local filesize = self:get_filesize()
  local filetype = self:get_filetype()

  -- only load solid arrows if colorscheme is detected
  local rs_arrow = self.separators.rs_arrow
  local ls_arrow = self.separators.ls_arrow
  if not status_ok then
    rs_arrow = self.separators.rh_arrow
    ls_arrow = self.separators.lh_arrow
  end

  local mode         = curr_mode.color      .. curr_mode.mode
  local bufnum       = colors.active_alt    .. self:get_buf_number()
  local gitbranch    = colors.active_alt    .. self:get_git_branch()
  local filename     = colors.active        .. file.type
  local filename_ch  = colors.file_mods     .. file.type
  local readonly     = colors.file_mods     .. self:get_readonly()
  local filetype_d   = colors.active_alt    .. filetype.data
  local filefmt      = colors.active_alt    .. self:get_file_fmt()
  local filesize_d   = colors.active_alt    .. filesize.data
  local percent      = curr_mode.color      .. self:get_file_percent()
  local line_col     = curr_mode.color      .. self:get_line_col()

  local blank_sep_m  = curr_mode.color      .. self.separators.blank
  local blank_sep    = colors.active        .. self.separators.blank

  local rs_arrow_m2a = curr_mode.color_alt  .. rs_arrow
  local rs_arrow_a2b = colors.alt_bg        .. rs_arrow
  local rs_arrow_a2f = colors.alt_ch        .. rs_arrow

  local lh_arrow_m   = curr_mode.color      .. self.separators.lh_arrow
  local lh_arrow_a   = colors.active_alt    .. self.separators.lh_arrow
  local ls_arrow_m2a = curr_mode.color_alt  .. ls_arrow
  local ls_arrow_a2b = colors.alt_bg        .. ls_arrow

  local rh_arrow_f   = colors.file_mods     .. self.separators.rh_arrow
  local rs_arrow_f2b = colors.file_mods_inv .. rs_arrow
  local rs_arrow_b2f = colors.file_mods     .. rs_arrow

  return table.concat{
    -- lhs
    blank_sep_m, mode, rs_arrow_m2a, gitbranch, bufnum,
    file_ch and rs_arrow_a2f or rs_arrow_a2b,

    -- middle
    file_ch and filename_ch .. rh_arrow_f .. ' + ' .. rs_arrow_f2b or filename,
    string.find(readonly, ' RO ') and rs_arrow_b2f .. readonly .. rs_arrow_f2b or '',
    blank_sep, '%=',

    -- rsh
    ls_arrow_a2b,
    filetype.show and filetype_d .. lh_arrow_a or '',
    filefmt,
    filesize.show and lh_arrow_a .. filesize_d or '',
    ls_arrow_m2a, percent, lh_arrow_m, line_col,
  }
end

-- construct inactive status line
M.set_inactive = function(self)
  local colors = self.colors

  local filename     = colors.inactive      .. ' %t '
  local ls_arrow_a2b = colors.inactive_alt  .. self.separators.lh_arrow
  local rs_arrow_a2b = colors.inactive_alt  .. self.separators.rh_arrow

  return table.concat{
    '%=', ls_arrow_a2b, ls_arrow_a2b, filename, rs_arrow_a2b, rs_arrow_a2b, '%=',
  }
end

M.set_explorer = function(self)
  local color = self.colors
  local sep = self.separators

  local title = color.normal_inv .. ' Nvim Tree '
  local l_sep = color.inactive .. sep.lh_arrow .. sep.lh_arrow
  local r_sep = color.inactive .. sep.rh_arrow .. sep.rh_arrow


  return table.concat({ '%=', l_sep, title, r_sep, '%=' })
end

-- define status line
Statusline = setmetatable(M, {
  __call = function(self, mode)
    return self["set_" .. mode](self)
  end,
})

-- set statusline
local augroup = vim.api.nvim_create_augroup
local aucmd = vim.api.nvim_create_autocmd
local status_grp = augroup('StatusLine', { clear = true })

aucmd({ 'WinEnter', 'BufEnter' }, {
  group = status_grp,
  command = "setlocal statusline=%!v:lua.Statusline('active')",
})
aucmd({ 'WinLeave', 'BufLeave' }, {
  group = status_grp,
  command = "setlocal statusline=%!v:lua.Statusline('inactive')",
})
aucmd({ 'WinEnter', 'BufEnter', 'FileType' }, {
  group = status_grp,
  pattern = 'NvimTree_1',
  command = "setlocal statusline=%!v:lua.Statusline('explorer')",
})
