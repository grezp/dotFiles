local o = vim.opt
local g = vim.g
local file_exists = require("core.utils").file_exists
local home = vim.fn.expand("$HOME")

-- Neovim options --
--------------------
-- map leader
g.mapleader = " "
g.maplocalleader = " "

-- use filetype.lua instead of filetype.vim
g.did_load_filetypes = false
g.do_filetype_lua = true
o.filetype = "on"

-- misc settings
o.encoding = "utf-8"
o.hidden = true -- change buffer w/o saving
o.history = 1000 -- save cmd history
o.dictionary = "/usr/share/dict/words" -- dictionary file
o.ruler = false
o.clipboard = "unnamedplus" -- sync clipboard between OS and Neovim

-- misc behavior
o.backspace = "indent,eol,start" -- backspace works on every char in insert mode
o.mouse = "n" -- enable mouse
o.shortmess = "asWF"

-- display settings
o.wrap = false -- do not wrap long lines onto next
o.breakindent = true -- wrapped lines will are visually indented (wrap = true)
o.scrolloff = 2 -- leave lines above & below cursor
o.synmaxcol = 300 -- stop syntax highlight after x lines for performance
o.laststatus = 2 -- always show status line
o.splitbelow = true -- open horiz splits below
o.splitright = true -- open vert splits to the right
o.termguicolors = true -- 24 bit colors
o.signcolumn = "yes"
g.have_nerd_font = true -- enables nerd fonts

-- setup cursor
o.cursorline = true -- show cursor line
o.guicursor = {
	"n-v-c:block",
	"i-ci-ve:ver35",
	"r-cr-o:hor35",
	"i-ci-ve-r-cr-o:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
}

-- status line
o.showmode = false -- always display mode (insert, visual, etc.)
o.showcmd = true -- show cmd on bottom line

-- auto completion
o.wildmenu = true -- cmd line completion
o.wildignorecase = true -- auto complete w/o case sensitivity
o.wildmode = "longest:full" -- complete longest string, then start wildmenu
o.wildignore = "*/build/*,*.bak" -- don't auto complete these patters
o.completeopt = "menu,menuone,noselect" -- use popup menu, use popup for 1 match, don't select match in menu

-- mapping timeout
o.timeout = true
o.timeoutlen = 300

-- searching
o.incsearch = true -- find pattern as you type
o.ignorecase = true -- ignore case when searching
o.smartcase = true -- stop ignorecase when caps are used
o.hlsearch = true -- highlight all prev and next search patterns
o.inccommand = "split" -- preview substitutions

-- white characters
o.autoindent = true
o.smartindent = true
o.expandtab = true -- convert tabs to spaces
o.tabstop = 4 -- set tab space to 4
o.shiftwidth = 4 -- shift line by 4 spaces (<< and >>)
o.showbreak = "↪" -- character to show when line is broken
o.list = false -- show tab, eol, & trail chars
o.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- char to show for tab and trail

-- backup files
o.backup = true -- use backup files
o.swapfile = false -- no swap files created
o.undodir = home .. "/.vim/tmp/undo//" -- undo file location
o.backupdir = home .. "/.vim/tmp/backup//" -- backup location

-- folding
o.foldenable = false -- don't auto fold when file is opened
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.fillchars = "fold:-"
o.foldnestmax = 10
-- o.foldtext = "v:lua.custom_fold_text()"

-- Setup Global Tags --
-----------------------
if file_exists(home .. "/tags/tags-unison") then
	o.tags = o.tags + { home .. "/tags/tags-unison" }
end
if file_exists(home .. "/tags/tags-methods") then
	o.tags = o.tags + { home .. "/tags/tags-methods" }
end
if file_exists(home .. "/tags/tags-plugins") then
	o.tags = o.tags + { home .. "/tags/tags-plugins" }
end

-- Startup Perfomance Options --
---------------------------------
g.ruby_path = "" -- set ruby path
o.updatetime = 250 -- TODO: is this actually doing something?

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
	g["loaded_" .. plugin] = true
end

local default_providers = {
	"node",
	"perl",
	"python3",
	"ruby",
}

for _, provider in ipairs(default_providers) do
	g["loaded_" .. provider .. "_provider"] = false
end

-- set shada path
vim.schedule(function()
	vim.opt.shadafile = vim.fn.expand("$HOME") .. "/.local/share/nvim/shada/main.shada"
	vim.cmd([[ silent! rsh ]])
end)

-- configure uno/una files to behave like cpp filetypes
-- used for commenting
vim.filetype.add ({
	extension = {
		["uno"] = "cpp",
		["una"] = "cpp",
	},
})
