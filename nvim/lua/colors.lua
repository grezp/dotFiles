vim.o.termguicolors = true              -- 24 bit colors
-- vim.g.fugitive_dynamic_colors = 1

require('doom-one').setup({
    cursor_coloring = true,
    terminal_colors = true,
    italic_comments = true,
    enable_treesitter = true,
    transparent_background = false,
    pumblend = {
        enable = true,
        transparency_amount = 20,
    },
    plugins_integrations = {
        neorg = false,
        barbar = false,
        bufferline = false,
        gitgutter = false,
        gitsigns = true,
        telescope = true,
        neogit = true,
        nvim_tree = false,
        dashboard = false,
        startify = false,
        whichkey = true,
        indent_blankline = true,
        vim_illuminate = false,
        lspsaga = false,
    },
})

local M = {}
local utils = require('doom-one.utils')

local fg_def = '#bbc2cf'
local bg_def = '#282c34'
-- local base0 = '#1B2229'
-- local base1 = '#1c1f24'
local base2 = '#202328'
local base3 = '#23272e'
local base4 = '#3f444a'
local base5 = '#5B6268'
local base6 = '#73797e'
local base7 = '#9ca0a4'
-- local base8 = '#DFDFDF'
-- local base9 = '#E6E6E6'
-- local bg_popup = '#3E4556'
local bg_highlight = '#21252a'
local base4_darken = utils.Darken(base4, 0.1)

-- local grey = base4
local red = '#ff6c6b'
local dark_red = utils.Darken(red, 0.3)
local orange = '#da8548'
local green = '#98be65'
local yellow = '#ECBE7B'
local blue = '#51afef'
-- local dark_blue = '#2257A0'
local magenta = '#c678dd'
local dark_magenta = utils.Darken(magenta, 0.3)
-- local light_magenta = utils.Lighten(magenta, 0.4)
local violet = '#a9a1e1'
local dark_violet = '#4e4f67'
-- local cyan = '#46D9FF'
local white = '#efefef'

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
  Cursor = { fg = 'NONE', bg = 'NONE', gui = 'reverse' },

  -- status line
  StatusLineNC    = { fg = base7, bg = base3 },
  AltToBg         = { fg = base4, bg = base3 },
  AltToCh         = { fg = base4, bg = magenta },
  StatusLineAlt   = { fg = base7, bg = base4 },
  StatusLineNCAlt = { fg = base4, bg = base3 },
  FileMods        = { fg = base3, bg = magenta, gui = 'bold' },
  FileModsInv     = { fg = magenta, bg = base3 },

  -- mode colors
  NormalModeStatus  = { fg = violet, bg = base3 },
  InsertModeStatus  = { fg = green,  bg = base3 },
  VisualModeStatus  = { fg = blue,   bg = base3 },
  ReplaceModeStatus = { fg = red,    bg = base3 },
  OtherModeStatus   = { fg = orange, bg = base3 },

  -- inverted mode colors
  NormalModeInvStatus  = { fg = base3, bg = violet },
  InsertModeInvStatus  = { fg = base3, bg = green },
  VisualModeInvStatus  = { fg = base3, bg = blue },
  ReplaceModeInvStatus = { fg = base3, bg = red },
  OtherModeInvStatus   = { fg = base3, bg = orange },

  -- mode colors
  NormalModeAltStatus  = { fg = violet, bg = base4 },
  InsertModeAltStatus  = { fg = green,  bg = base4 },
  VisualModeAltStatus  = { fg = blue,   bg = base4 },
  ReplaceModeAltStatus = { fg = red,    bg = base4 },
  OtherModeAltStatus   = { fg = orange, bg = base4 },

  -- stock comments are too dark
  Comment = { fg = base6, gui = 'italic' },

  -- change search colors to differ from visual select
  IncSearch = { fg = fg_def, bg = dark_magenta, gui = 'bold' },
  Search    = { fg = white, bg = dark_violet,  gui = 'bold' },

  -- brighten number line, def are too dark
  LineNr       = { fg = base5, bg = bg_def },
  CursorLineNr = { fg = blue,  bg = bg_highlight },

  -- plugins --

  -- fugitive
  diffAdded     = { fg = green },
  diffRemoved   = { fg = red },
  DiffAdd       = { fg = green,  bg = base4_darken, gui = 'bold' },
  DiffDelete    = { fg = red,    bg = base4_darken, gui = 'bold' },
  DiffChange    = { fg = fg_def, bg = base4_darken, gui = 'bold' },
  DiffText      = { fg = yellow, bg = base4_darken, gui = 'bold' },

  -- WhichKey
  WhichKey          = { fg = blue },
  WhichKeyGroup     = { fg = red },
  WhichKeySeparator = { fg = base6 },
  WhichKeyDesc      = { fg = violet },
  WhichKeyValue     = { fg = green },
  WhichKeyFloat     = { bg = base2 },

  -- lightspeed
  LightspeedLabel                  = { fg = red,       gui = 'bold,underline' },
  LightspeedLabelDistant           = { fg = blue,      gui = 'bold' },
  LightspeedLabelDistantOverlapped = { fg = violet,    gui = 'bold' },
  LightspeedShortcut               = { fg = white,     gui = 'bold', bg = dark_red },
  LightspeedOneCharMatch           = { fg = white,     gui = 'bold', bg = dark_red },

  -- hlslens
  HlSearchNear     = { fg = white, bg = dark_magenta, gui = 'bold' },
  HlSearchLensNear = { fg = base3, bg = dark_magenta, gui = 'bold' },
  HlSearchLens     = { fg = base3, bg = dark_violet,  gui = 'bold' },
}

M.apply_highlight(M.custom_hl_groups)

