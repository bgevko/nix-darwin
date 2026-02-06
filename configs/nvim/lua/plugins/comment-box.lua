return {
	"LudoPinelli/comment-box.nvim",
	config = function()
		local map = vim.keymap.set

		map("n", "<leader>cl", "<Cmd>CBline<CR>", { desc = "Comment Box: Line" })
		map({ "n", "v" }, "<Leader>cb", "<Cmd>CBlcbox<CR>", { desc = "Comment Box" })
		map({ "n", "v" }, "<Leader>cD", "<Cmd>CBd<CR>", { desc = "Comment Box: Delete Box" })
		map({ "n", "v" }, "<Leader>cm", "<Cmd>CBlabox15<CR>", { desc = "Comment Box: Marked Comments" })
		map({ "n", "v" }, "<Leader>ct", "<Cmd>CBllline6<CR>", { desc = "Comment Box: Title Line" })
	end,
}
