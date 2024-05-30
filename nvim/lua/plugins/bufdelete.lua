return {
	{ -- deletes buffer w/o closing/changing panes
		"famiu/bufdelete.nvim",

		keys = {
			{
				"<leader>bd",
				":Bdelete<CR>",
				mode = "",
				desc = "[d]elete buffer",
			},
			{
				"<leader>bW",
				":Bwipeout<CR>",
				mode = "",
				desc = "[W]ipeout buffer",
			},
		},
	},
}
