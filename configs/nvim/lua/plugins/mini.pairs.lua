return {
	"nvim-mini/mini.nvim",
	version = "*",
	config = function()
		local MiniPairs = require("mini.pairs")
		MiniPairs.setup()
		MiniPairs.unmap("i", '"', '"')
		-- markdown-only disabling of backtick pairing
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "markdown",
			callback = function()
				MiniPairs.unmap("i", "`", "`")
			end,
		})
	end,
}
