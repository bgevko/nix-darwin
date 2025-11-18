return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			explorer = { enabled = true },
			indent = { enabled = true },
			quickfile = { enabled = true },
			picker = { enabled = true }, -- Telescope-like picker

			notifier = { enabled = false }, -- Enabled as a separate plug (nvim-notify)
			statuscolumn = { enabled = false },
			input = { enabled = false },
			scope = { enabled = false },
			scroll = { enabled = false },
			words = { enabled = false },
			dashboard = { enabled = true },
		},

		config = function(_, opts)
			local Snacks = require("snacks")
			Snacks.setup(opts)
			local picker = Snacks.picker
			local map = vim.keymap.set

			-- Files
			map("n", "<leader>ff", function()
				picker.files()
			end, { desc = "Find Files" })

			-- Live Grep
			map("n", "<leader>/", function()
				picker.grep()
			end, { desc = "Grep Text" })

			-- Buffers
			map("n", "<leader>,", function()
				picker.buffers()
			end, { desc = "Buffers" })

			-- Recent files (oldfiles)
			map("n", "<leader>fr", function()
				picker.recent()
			end, { desc = "Recent Files" })

			-- Help
			map("n", "<leader>fh", function()
				picker.help()
			end, { desc = "Help Tags" })

			-- Diagnostics
			map("n", "<leader>sd", function()
				picker.diagnostics()
			end, { desc = "Diagnostics" })

			-- Keymaps
			map("n", "<leader>sk", function()
				picker.keymaps()
			end, { desc = "Keymaps" })

			-- Commands
			map("n", "<leader>sc", function()
				picker.commands()
			end, { desc = "Commands" })

			-- Highlights
			map("n", "<leader>sh", function()
				picker.highlights()
			end, { desc = "Highlights" })

			-- Colorschemes
			map("n", "<leader>uc", function()
				picker.colorschemes()
			end, { desc = "Colorschemes" })

			-- Todo scratch file
			vim.keymap.set("n", "<leader>td", function()
				local root = vim.fn.expand("~/notes")
				vim.fn.mkdir(root, "p")
				local file = root .. "/todo.md"
				Snacks.scratch.open({
					ft = "markdown",
					file = file,
				})
			end, { desc = "Toggle Scratch Todo" })
		end,
	},
}
