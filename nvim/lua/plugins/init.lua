-- [[ Install `lazy.nvim` plugin manager ]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	print("installing lazy.nvim")
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require("lazy").setup({

	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",

	-- "gc" to comment visual regions/lines
	require("plugins.comment"),

	-- git wrapper for vim
	require("plugins.fugitive"),

	-- stage/reset git hunks & show changed/added/deleted lines
	require("plugins.gitsigns"),

	-- a magit (emacs) clone
	require("plugins.magit"),

	-- display popup key bindings
	require("plugins.which-key"),

	-- extendable fuzzy finder
	require("plugins.telescope"),

	-- LSP Configuration & Plugins
	require("plugins.lspconfig"),

	-- auto format text
	require("plugins.conform"),

	-- auto completion
	require("plugins.cmp"),

	-- colorscheme
	require("plugins.tokyonight"),

	-- highlight & search TODO comments
	require("plugins.todo-comments"),

	-- nvim hl based on syntax
	require("plugins/treesitter"),

	-- create indent line for spaces
	require("plugins.indent-blankline"),

	-- deletes buffer w/o closing/changing panes
	require("plugins.bufdelete"),

	-- add/delete/change surrounding pairs
	require("plugins.nvim-surround"),

	-- auto completes pairs: {}, (), [], "", ''
	require("plugins.nvim-autopairs"),

	-- browse file system
	require("plugins.neo-tree"),

	-- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart

	-- require 'kickstart.plugins.debug',
	-- require 'kickstart.plugins.lint',
	-- require 'kickstart.plugins.neo-tree',

	-- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
	--    This is the easiest way to modularize your config.
	--
	--  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
	--    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
	-- { import = 'custom.plugins' },
}, {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- vim: ts=2 sts=2 sw=2 et
