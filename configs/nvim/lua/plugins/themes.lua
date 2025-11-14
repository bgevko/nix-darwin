return {
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("everforest").setup({
				colours_override = function(palette)
					-- palette.red = "#b86466"
				end,
			})
			vim.cmd([[colorscheme everforest]])
		end,
	},
}

-- Defaults
-- fg = "#d3c6aa",
--     red = "#e67e80",
--     orange = "#e69875",
--     yellow = "#dbbc7f",
--     green = "#a7c080",
--     aqua = "#83c092",
--     blue = "#7fbbb3",
--     purple = "#d699b6",
--     grey0 = "#7a8478",
--     grey1 = "#859289",
--     grey2 = "#9da9a0",
--     statusline1 = "#a7c080",
--     statusline2 = "#d3c6aa",
--     statusline3 = "#e67e80",
--     none = "NONE",
