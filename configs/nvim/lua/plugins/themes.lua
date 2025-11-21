return {
	{
		"neanias/everforest-nvim",
		enabled = true,
		version = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("everforest").setup({})
			vim.cmd([[colorscheme everforest]])
		end,
	},

	-- Dracula
	{
		"Mofiqul/dracula.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("dracula").setup({
				transparent_bg = true,
			})
			vim.cmd([[colorscheme dracula]])
		end,
	},
}
