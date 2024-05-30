return {
	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				-- 'pattern   -> exact match
				-- ^pattern   -> prefix match
				-- .pattern   -> suffix match
				-- !pattern   -> inverse match
				-- !^pattern  -> inverse prefix match
				-- !.pattern  -> inverse suffix match
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},

			-- allows neovim core stuff to to fill telescope picker
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },

			-- intelligent prioritization when selecting files from editing history
			{ "nvim-telescope/telescope-frecency.nvim" },
		},

		config = function()
			require("telescope").setup({
				defaults = {

					-- determines how file paths are sorted
					path_display = {},

					-- direction results are sorted
					sorting_strategy = "ascending",

					-- determines default layout
					layout_strategy = "bottom_pane",

					layout_config = {
						width = 0.90,
						height = 0.50,
					},

					mappings = {
						i = { ["<c-enter>"] = "to_fuzzy_refine" },
					},
				},

				-- pickers = {}

				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension("frecency"))
			pcall(require("telescope").load_extension, "ui-select")

			local builtin = require("telescope.builtin")
			local map = vim.keymap.set

			-- search [F]iles --
			--------------------
			map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			map("n", "<leader>s.", builtin.oldfiles, { desc = "[S]earch Recent [.] Files" })
			map("n", "<leader>sm", builtin.man_pages, { desc = "[S]earch [M]an pages" })

			-- search all files, including hidden files
			map("n", "<leader>sa", function()
				builtin.find_files({
					hidden = true,
					no_ignore = true,
					no_ignore_parent = true,
				})
			end, { desc = "[S]earch [A]ll files" })

			-- search pattern in all open buffers
			map("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- search neovim config
			map("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })

			-- search neovim pluglins
			map("n", "<leader>sp", function()
				builtin.find_files({ cwd = vim.fn.stdpath("data") .. "/lazy/" })
			end, { desc = "[S]earch neovim [P]lugins" })

			-- search prev opened files
			map("n", "<leader>so", function()
				require("telescope").extensions.frecency.frecency()
			end, { desc = "[S]earch prev [O]pen files" })

			-- search [N]eovim --
			---------------------
			map("n", "<leader>nh", builtin.help_tags, { desc = "[N]eovim [H]elp" })
			map("n", "<leader>nk", builtin.keymaps, { desc = "[N]eovim [K]eymaps" })
			map("n", "<leader>nt", builtin.builtin, { desc = "[N]eovim [T]elescope" })
			map("n", "<leader>no", builtin.vim_options, { desc = "[N]eovim [O]ptions" })
			map("n", '<leader>n"', builtin.registers, { desc = '[N]eovim ["] registers' })
			map("n", "<leader>n'", builtin.marks, { desc = "[N]eovim ['] marks" })
			map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
			map("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "[/] Fuzzy search in current buffer" })

			-- search [L]SP --
			------------------
			-- map('n', '<leader>le', builtin.diagnostics, { desc = '[L]SP diags [E]rrors' })
			-- map('n', '<leader>ld', builtin.lsp_definitions, { desc = '[L]SP [D]efinitions' })
			-- map('n', '<leader>lr', builtin.lsp_references, { desc = '[L]SP [R]eferences' })
			-- map('n', '<leader>li', builtin.lsp_implementations, { desc = '[L]SP [I]mplementations' })
			-- map('n', '<leader>ls', builtin.lsp_dynamic_workspace_symbols, { desc = '[L]SP workspace [S]ymbols' })
		end,
	},
}
-- vim: ts=2 sts=2 sw=2 et
