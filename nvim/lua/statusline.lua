local fn = vim.fn
local api = vim.api
local M = {}

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
  insert        = '%#InsertModeStatus#',
  visual        = '%#VisualModeStatus#',
  replace       = '%#ReplaceModeStatus#',
  other         = '%#OtherModeStatus#',

  normal_inv    = '%#NormalModeInvStatus#',
  insert_inv    = '%#InsertModeInvStatus#',
  visual_inv    = '%#VisualModeInvStatus#',
  replace_inv   = '%#ReplaceModeInvStatus#',
  other_inv     = '%#OtherModeInvStatus#',

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
    data.color_inv = M.colors.other_inv
    return data
  end

  if mode_str == 'NORMAL' then
    data.color = M.colors.normal
    data.color_inv = M.colors.normal_inv
    data.color_alt = M.colors.normal_alt
  elseif mode_str == 'VISUAL' or mode_str == 'V-LINE' or mode_str == 'V-BLOCK' then
    data.color = M.colors.visual
    data.color_inv = M.colors.visual_inv
    data.color_alt = M.colors.visual_alt
  elseif mode_str == 'INSERT' then
    data.color = M.colors.insert
    data.color_inv = M.colors.insert_inv
    data.color_alt = M.colors.insert_alt
  elseif mode_str == 'REPLACE' or mode_str == 'V-REPLACE' then
    data.color = M.colors.replace
    data.color_inv = M.colors.replace_inv
    data.color_alt = M.colors.replace_alt
  else
    data.color = M.colors.other
    data.color_inv = M.colors.other_inv
    data.color_alt = M.colors.other_alt
  end

  data.mode = ' ' .. M.mode[mode_code] .. ' '

  return  data
end

-- detemermine file path base on str size + show/hide rhs status
M.get_file_path_type = function()
  local max_file_len = api.nvim_win_get_width(0) - 55
  local max_len_total = max_file_len + 20
  local file_len = fn.fnamemodify(fn.expand("%"), ":~:."):len()
  local data = {}

  if file_len < max_file_len then
    data.type = M.path_type.TAIL
    data.show = true
  elseif file_len < max_len_total then
    data.type = M.path_type.TAIL
    data.show = false
  else
    data.type = M.path_type.NAME
    data.show = true
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

  data.show = type.show

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
  local branch = vim.fn['fugitive#head']()

  if branch ~= nil and branch:len() > 0 then
    return ' ' .. branch .. ' '
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
  local curr_mode = self:get_current_mode()
  local file_ch = self:check_file_ch()
  local file = self:get_filename()

  local mode         = curr_mode.color_inv  .. curr_mode.mode
  local bufnum       = colors.active_alt    .. self:get_buf_number()
  local gitbranch    = colors.active_alt    .. self:get_git_branch()
  local filename     = colors.active        .. file.type
  local filename_ch  = colors.file_mods     .. file.type
  local readonly     = colors.file_mods     .. self:get_readonly()
  local filetype     = colors.active_alt    .. self:get_filetype()
  local filefmt      = colors.active_alt    .. self:get_file_fmt()
  local filesize     = colors.active_alt    .. self:get_filesize()
  local percent      = curr_mode.color_inv  .. self:get_file_percent()
  local line_col     = curr_mode.color_inv  .. self:get_line_col()

  local blank_sep_m  = curr_mode.color_inv  .. self.separators.blank
  local blank_sep    = colors.active        .. self.separators.blank

  local rs_arrow_m2a = curr_mode.color_alt  .. self.separators.rs_arrow
  local rs_arrow_a2b = colors.alt_bg        .. self.separators.rs_arrow
  local rs_arrow_a2f = colors.alt_ch        .. self.separators.rs_arrow

  local lh_arrow_m   = curr_mode.color_inv  .. self.separators.lh_arrow
  local lh_arrow_a   = colors.active_alt    .. self.separators.lh_arrow
  local ls_arrow_m2a = curr_mode.color_alt  .. self.separators.ls_arrow
  local ls_arrow_m2b = curr_mode.color      .. self.separators.ls_arrow
  local ls_arrow_a2b = colors.alt_bg        .. self.separators.ls_arrow

  local rh_arrow_f   = colors.file_mods     .. self.separators.rh_arrow
  local rs_arrow_f2b = colors.file_mods_inv .. self.separators.rs_arrow
  local rs_arrow_b2f = colors.file_mods     .. self.separators.rs_arrow

  return table.concat{
    -- lhs
    blank_sep_m, mode, rs_arrow_m2a, gitbranch, bufnum,
    file_ch and rs_arrow_a2f or rs_arrow_a2b,

    -- middle
    file_ch and filename_ch .. rh_arrow_f .. ' + ' .. rs_arrow_f2b or filename,
    string.find(readonly, ' RO ') and rs_arrow_b2f .. readonly .. rs_arrow_f2b or '',
    blank_sep, "%=",

    -- rsh
    file.show and ls_arrow_a2b .. filetype .. lh_arrow_a ..  filefmt .. lh_arrow_a .. filesize or '',
    file.show and ls_arrow_m2a, percent, lh_arrow_m, line_col or ls_arrow_m2b,
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

