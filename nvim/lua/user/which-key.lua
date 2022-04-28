local status_ok,  wk   = pcall(require, 'which-key')
if not status_ok then
  vim.notify('which-key not found!')
  return
end

wk.setup {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    ["<80>"] = "<space>",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = '<c-d>', -- binding to scroll down inside the popup
    scroll_up = '<c-u>', -- binding to scroll up inside the popup
  },
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
    winblend = 0
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 6, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}


-- leader keymaps
wk.register({
  ['<leader>'] = {
    name = 'custom maps',

    -- telescope
    f = {
      name = 'fuzzy find',

      -- neovim files
      n = 'find Neovim files',
      p = 'fild installed Plugins',

      -- grep
      g = 'Grep files',
      w = 'grep Word on cursor',
      l = 'grep Last word',

      -- files
      f = 'find Files',
      a = 'find All files',
      c = 'find Certain file',
      o = 'find Old files',

      -- neovim
      b = 'find opened Buffers',
      h = 'find neovim Help',
      v = 'find neovim Options',
      m = 'find Man pages',
      ["'"] = 'find Marks',
      ['"'] = 'find Registers',
      ['/'] = 'find pattern in buffer',

      -- misc
      ['<leader>'] = 'telescope Builtins',
      s = 'find Safari bookmarks',
    },

    -- LSP
    l = {
      name = 'LSP',

      d = 'go to Definition',
      r = 'find References',
      i = 'find Implementation',
      g = 'find Global symbols',
      n = 'reName references',
      k = 'display symbol infomation',
      K = 'display symbol signature help',
    },

    -- LSP Diagnostics
    e = {
      name = 'Error Diagnostics',

      e = 'show Errow Diagnostics',
      k = 'go to next error',
      j = 'go to prev error',
      l = 'List all errors',
    },

    -- gitsigns
    h = {
      name = 'Gitsigns',
      s = 'Stage hunk',
      u = 'Unstage hunk',
      r = 'Reset hunk',
      S = 'Stage entire buffer',
      R = 'Reset entire buffer',
      p = 'Preview hunk',
      b = 'Blame hunk',
      d = 'Diff this',
      D = 'Diff against last commit'
    },

    -- NrrwRng
    n = {
      name = 'NrrwRng',
      n = 'narrow region to new buffer',
      r = 'narrow region to split',
      s = 'save narrow region',
    },

    -- git
    g = { name = 'git' },

    -- toggle
    t = {
      name = 'toggle',

      e = 'toggle Error Diagnostics',
      b = 'toggle gitsigns Blame',
      d = 'toggle gitsigns Deleted lines',
      i = 'toggle indent-blankline',
      u = 'toggle aUto pairs',
    },

    -- buffers
    b = {
      name = 'buffers',

      b = 'select Buffer',
      l = 'List buffers',
      n = 'Next buffer',
      p = 'Prev buffer',
      d = 'Delete buffer w/o closing',
      D = 'Delete buffer w/ closing',
    },

    ['*'] = 'highligth word',
    o = 'blank line v cursor',
    O = 'blank line ^ cursor',

  },
})

wk.register({

  -- hlslens
  n = 'hlslens Next pattern',
  N = 'hlslens Prev pattern',
  ['*'] = 'hlslens Next word on cursor',
  ['#'] = 'hlslens Prev word on cursor',

  --gitsigns
  [ [[]c]] ] = 'gitsigns Next hunk',
  [ [[[c]] ] = 'gitsigns Prev hunk',
})

