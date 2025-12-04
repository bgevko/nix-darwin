return {
	"LudoPinelli/comment-box.nvim",
	config = function()
		local map = vim.keymap.set

		map("n", "<leader>cl", "<Cmd>CBline<CR>", { desc = "Comment Box: Line" })
		map({ "n", "v" }, "<Leader>cb", "<Cmd>CBccbox<CR>", { desc = "Comment Box: Custom Centered Box" })
		map({ "n", "v" }, "<Leader>cd", "<Cmd>CBd<CR>", { desc = "Comment Box: Delete Box" })
		map({ "n", "v" }, "<Leader>cm", "<Cmd>CBllbox15<CR>", { desc = "Comment Box: Marked Comments" })
		map({ "n", "v" }, "<Leader>ct", "<Cmd>CBllline6<CR>", { desc = "Comment Box: Title Line" })
	end,
}
