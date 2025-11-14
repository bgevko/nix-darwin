return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			stages = "fade_in_slide_out",
			timeout = 3000,
			background_colour = "#343f44",
			render = "compact",
		})
		vim.notify = require("notify")
	end,
}
