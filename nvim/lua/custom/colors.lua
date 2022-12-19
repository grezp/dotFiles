local colorscheme = 'tokyonight'
local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)

if not status_ok then
  vim.notify('colorscheme ' .. colorscheme .. ' not found!')
  return
end

local M = {}
local colors = require('tokyonight.colors')
local config = require('tokyonight.config')
local util   = require('tokyonight.util')
local c = colors.setup(config)

-- bg colors
local dark3   = c.dark3
local blue_d55  = util.darken(c.blue, 0.55)
local status  = c.bg_statusline
local status2 = util.darken(c.dark3, 0.2)

-- fg colors
local purple  = c.purple
local green   = c.green2
local blue    = c.blue
local red     = c.red
local red1    = c.red1
local orange  = c.orange
local green2  = c.green1
local blue7_d85   = util.lighten(c.blue7, 0.85)
local blue_d7     = util.darken(c.blue, 0.6)
local comment_l85 = util.lighten(c.comment, 0.9)

-- cusor colors
local cursor_bg = '#bb9af7'
local cursor_fg = '#1f2335'


function M.apply_highlight(groups)
  for group, styles in pairs(groups) do
    vim.api.nvim_set_hl(0, group, styles)
  end
end

M.custom_hl_groups = {
  -- status line
  StatuslineNC    = { fg = dark3,     bg = status },
  AltToBg         = { fg = status2,   bg = status },
  AltToCh         = { fg = status2,   bg = green2 },
  StatusLineAlt   = { fg = blue_d55,  bg = status2 },
  StatusLineNCAlt = { fg = status2,   bg = status },
  FileMods        = { fg = status,    bg = green2, bold = true },
  FileModsInv     = { fg = green2,    bg = status },

  -- mode colors
  NormalModeStatus    = { fg = status, bg = purple },
  NormalModeStatusInv = { fg = purple, bg = status },
  InsertModeStatus    = { fg = status, bg = green },
  VisualModeStatus    = { fg = status, bg = blue },
  ReplaceModeStatus   = { fg = status, bg = red },
  OtherModeStatus     = { fg = status, bg = orange },

  -- mode colors
  NormalModeAltStatus  = { fg = purple, bg = status2 },
  InsertModeAltStatus  = { fg = green,  bg = status2 },
  VisualModeAltStatus  = { fg = blue,   bg = status2 },
  ReplaceModeAltStatus = { fg = red,    bg = status2 },
  OtherModeAltStatus   = { fg = orange, bg = status2 },

  -- change cursor to terminal color
  Cursor  = { fg = cursor_fg, bg = cursor_bg },
  lCursor = { fg = cursor_fg, bg = cursor_bg },

  -- number line
  LineNr        = { fg = blue7_d85 },
  CursorLineNr  = { fg = blue_d7 },

  Comment  = { fg = comment_l85, italic = true },

  -- plugins --

  -- indent_blankline
  IndentBlanklineContextChar = { fg = c.blue },

  -- leap
  LeapMatch        = { fg = c.red1, bold = true },
  LeapLabelPrimary = { fg = c.red1, bold = true },
}

M.apply_highlight(M.custom_hl_groups)
