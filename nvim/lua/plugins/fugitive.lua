return {
	{ -- git wrapper for vim
		"tpope/vim-fugitive",

		keys = {
			{
				"<leader>gg",
				":Git<CR>",
				mode = "",
				desc = "fu[g]itive",
			},
			{
				"<leader>gl",
				":GcLog<CR>",
				mode = "",
				desc = "[l]og",
			},
		},
	},
}

-- vim: ts=2 sts=2 sw=2 et
