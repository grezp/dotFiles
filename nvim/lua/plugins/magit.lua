return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			"nvim-telescope/telescope.nvim", -- optional
		},
		config = true,
		keys = {
			{
				"<leader>gn",
				":Neogit<CR>",
				mode = "",
				desc = "[n]eogit",
			},
		},
	},
}
-- vim: ts=2 sts=2 sw=2 et