return {
	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()

			-- Document existing key chains
			require("which-key").register({
				["<leader>l"] = { name = "[L]SP", _ = "which_key_ignore" },
				["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
				["<leader>b"] = { name = "[B]uffers", _ = "which_key_ignore" },
				["<leader>n"] = { name = "[N]eovim", _ = "which_key_ignore" },
				["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
				["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
				["<leader>f"] = { name = "[F]iles", _ = "which_key_ignore" },
			})
			-- visual mode
			require("which-key").register({
				["<leader>g"] = { "[G]it" },
			}, { mode = "v" })
		end,
	},
}
-- vim: ts=2 sts=2 sw=2 et
