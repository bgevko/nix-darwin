return {
	"bngarren/checkmate.nvim",
	enabled = false,
	config = function()
		require("checkmate").setup({
			files = {
				vim.fn.expand("~/notes/todo.md"),
				"**/.todo.md",
				"**/todo.md",
			},
		})

		local cm = require("checkmate")
		local map = vim.keymap.set

		-- Toggle a single todo
		map("n", "<leader>tt", cm.toggle, { desc = "Todo: Toggle checkbox" })

		-- Cycle between states (e.g. `[ ]` → `[~]` → `[x]`)
		map("n", "<leader>tc", cm.cycle, { desc = "Todo: Cycle state" })

		-- Expand "- " into "- [ ] " in markdown files
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "markdown",
			callback = function()
				vim.keymap.set("i", "- ", function()
					local col = vim.fn.col(".")
					local line = vim.api.nvim_get_current_line()

					-- Only expand if typing "- " at the beginning of a list item
					local before = line:sub(1, col - 1)

					-- Match either "^" (start of line) or whitespace before "-"
					if before:match("^%s*%-?$") then
						return "- [ ] "
					end

					-- Otherwise keep normal "- "
					return "- "
				end, { buffer = true, expr = true })
			end,
		})
	end,
}
