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

local cursor_bg = '#bb9af7'
local cursor_fg = '#1f2335'

function M.highlight(group, styles)
  local bg = styles.bg and 'guibg=' .. styles.bg or 'guibg=NONE'
  local fg = styles.fg and 'guifg=' .. styles.fg or 'guifg=NONE'
  local sp = styles.sp and 'guisp=' .. styles.sp or 'guisp=NONE'
  local gui = styles.gui and 'gui=' .. styles.gui or 'gui=NONE'

  vim.api.nvim_command(
    'hi! ' .. group .. ' ' .. bg .. ' ' .. fg .. ' ' .. sp .. ' ' .. gui
  )
end

function M.apply_highlight(groups)
  for group, styles in pairs(groups) do
    M.highlight(group, styles)
  end
end

M.custom_hl_groups = {
  -- status line
  StatuslineNC    = { fg = dark3,   bg = status },
  AltToBg         = { fg = status2, bg = status },
  AltToCh         = { fg = status2, bg = green2 },
  StatusLineAlt   = { fg = blue55,  bg = status2 },
  StatusLineNCAlt = { fg = status2, bg = status },
  FileMods        = { fg = status,  bg = green2,  gui = 'bold' },
  FileModsInv     = { fg = green2,  bg = status },

  -- mode colors
  NormalModeStatus  = { fg = status, bg = purple },
  InsertModeStatus  = { fg = status, bg = green },
  VisualModeStatus  = { fg = status, bg = blue },
  ReplaceModeStatus = { fg = status, bg = red },
  OtherModeStatus   = { fg = status, bg = orange },

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
}

M.apply_highlight(M.custom_hl_groups)
