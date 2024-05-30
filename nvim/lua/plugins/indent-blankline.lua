return {
	{ -- create indent line for spaces
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		-- default options
		opts = {},

		config = function()
			require("ibl").setup({
				indent = { char = "┊" },
			})

			local map = vim.keymap.set
			map("n", "<Leader>ti", "<cmd>IBLToggle<CR>", { desc = "[i]ndent-blankline" })
		end,
	},
}

-- vim: ts=2 sts=2 sw=2 et
