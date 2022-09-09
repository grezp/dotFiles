local o = vim.opt
local g = vim.g
local file_exists = require('core.utils').file_exists
local home = vim.fn.expand('$HOME')

-- Neovim options --
--------------------
g.mapleader = ' '

-- use filetype.lua instead of filetype.vim
g.did_load_filetypes = 0
g.do_filetype_lua = 1

-- misc settings
o.encoding = 'utf-8'
o.hidden = true                           -- change buffer w/o saving
o.history = 1000                          -- save cmd history
o.dictionary = '/usr/share/dict/words'    -- dictionary file
o.ruler = false

-- misc behavior
o.backspace = 'indent,eol,start'          -- backspace works on every char in insert mode
o.mouse = 'n'                             -- enable mouse
o.shortmess = 'asSWF'

-- display settings
o.wrap = false              -- do not wrap long lines onto next
o.scrolloff = 2             -- leave lines above & below cursor
o.synmaxcol = 300           -- stop syntax highlight after x lines for performance
o.laststatus = 2            -- always show status line
o.splitbelow = true         -- open horiz splits below
o.splitright = true         -- open vert splits to the right
o.termguicolors = true      -- 24 bit colors
o.signcolumn = "yes"

-- setup cursor
o.guicursor = {
  'n-v-c:block',
  'i-ci-ve:ver35',
  'r-cr-o:hor35',
  'i-ci-ve-r-cr-o:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor'
}

-- status line
o.showmode = false       -- always display mode (insert, visual, etc.)
o.showcmd = true         -- show cmd on bottom line

-- auto completion
o.wildmenu = true                         -- cmd line completion
o.wildignorecase = true                   -- auto complete w/o case sensitivity
o.wildmode = 'longest:full'               -- complete longest string, then start wildmenu
o.wildignore = '*/build/*,*.bak'          -- don't auto complete these patters
o.completeopt = 'menu,menuone,noselect'   -- use popup menu, use popup for 1 match, don't select match in menu

-- mapping timeout
o.timeout = true
o.timeoutlen = 500

-- searching
o.incsearch = true      -- find pattern as you type
o.ignorecase = true     -- ignore case when searching
o.smartcase = true      -- stop ignorecase when caps are used
o.hlsearch = true       -- highlight all prev and next search patterns

-- white characters
o.autoindent = true
o.smartindent = true
o.expandtab = true              -- convert tabs to spaces
o.tabstop = 4                   -- set tab space to 4
o.shiftwidth = 4                -- shift line by 4 spaces (<< and >>)
o.list = false                   -- show tab, eol, & trail chars
o.listchars = 'tab:▸ ,trail:●'  -- char to show for tab and trail
o.showbreak= '↪'                -- character to show when line is broken

-- backup files
o.backup = true                              -- use backup files
o.swapfile = false                           -- no swap files created
o.undodir = home .. '/.vim/tmp/undo//'       -- undo file location
o.backupdir = home .. '/.vim/tmp/backup//'   -- backup location

-- folding
o.foldenable = false             -- don't auto fold when file is opened
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'
o.fillchars = 'fold:-'
o.foldnestmax = 10
o.foldtext = 'v:lua.custom_fold_text()'

-- setup global tags
if file_exists(home .. '/tags/tags-unison')  then o.tags = o.tags + {home .. '/tags/tags-unison' } end
if file_exists(home .. '/tags/tags-methods') then o.tags = o.tags + {home .. '/tags/tags-methods'} end
if file_exists(home .. '/tags/tags-plugins') then o.tags = o.tags + {home .. '/tags/tags-plugins'} end

-- set ruby path -> improves startup time
g.ruby_path = ''

-- disable some builtin vim plugins
local default_plugins = {
   "2html_plugin",
   "getscript",
   "getscriptPlugin",
   "gzip",
   "logipat",
   "netrw",
   "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   "matchit",
   "tar",
   "tarPlugin",
   "rrhelper",
   "spellfile_plugin",
   "vimball",
   "vimballPlugin",
   "zip",
   "zipPlugin",
   "tutor",
   "rplugin",
   "syntax",
   "synmenu",
   "optwin",
   "compiler",
   "bugreport",
   "ftplugin",
}

for _, plugin in pairs(default_plugins) do
   g["loaded_" .. plugin] = 1
end

local default_providers = {
   "node",
   "perl",
   "python3",
   "ruby",
}

for _, provider in ipairs(default_providers) do
   vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- set shada path
vim.schedule(function()
   vim.opt.shadafile = vim.fn.expand "$HOME" .. "/.local/share/nvim/shada/main.shada"
   vim.cmd [[ silent! rsh ]]
end)

