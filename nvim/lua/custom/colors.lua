local colorscheme = 'tokyonight'
local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)

if not status_ok then
  vim.notify('colorscheme ' .. colorscheme .. ' not found!')
  vim.cmd('colorscheme desert')
  return
end

local M = {}
local colors = require('tokyonight.colors')
local config = require('tokyonight.config')
local util   = require('tokyonight.util')
local c = colors.setup(config)

local dark3   = c.dark3
local blue55  = util.darken(c.blue, 0.55)
local status  = c.bg_statusline
local status2 = util.darken(c.dark3, 0.2)

local purple = c.purple
local green  = c.green2
local blue   = c.blue
local red    = c.red
local orange = c.orange
local green2 = c.green1
local violet1 = util.darken( c.magenta, 0.7)
local violet2 = util.darken( c.magenta, 0.5)
local bg_hi  = c.bg_highlight

local cursor_bg = '#bb9af7'
local cursor_fg = '#1f2335'


function M.apply_highlight(groups)
  for group, styles in pairs(groups) do
    vim.api.nvim_set_hl(0, group, styles)
  end
end

M.custom_hl_groups = {
  -- status line
  StatuslineNC    = { fg = dark3,   bg = status },
  AltToBg         = { fg = status2, bg = status },
  AltToCh         = { fg = status2, bg = green2 },
  StatusLineAlt   = { fg = blue55,  bg = status2 },
  StatusLineNCAlt = { fg = status2, bg = status },
  FileMods        = { fg = status,  bg = green2, bold = true },
  FileModsInv     = { fg = green2,  bg = status },

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

  -- plugins --

  -- indent_blankline
  IndentBlanklineContextChar = { fg = c.blue },

  -- lightspeed
  LightspeedOneCharMatch    = { fg = bg_hi,   bg = violet2 },
  LightspeedPendingOpArea   = { fg = bg_hi,   bg = violet2 },
  LightspeedShortcut        = { fg = bg_hi,   bg = violet2 },
  LightspeedLabel           = { fg = violet1, bg = bg_hi,   bold = true, underline = true },
  LightspeedLabelOverlapped = { fg = violet1, bg = bg_hi,   bold = true, underline = true },

}

M.apply_highlight(M.custom_hl_groups)
