---@diagnostic disable: undefined-doc-name, assign-type-mismatch
return {
	{
		"chrisgrieser/nvim-origami",
		event = "VeryLazy",
		opts = {
			useLspFoldsWithTreesitterFallback = {
				enabled = true,
			},
			pauseFoldsOnSearch = true,
			foldtext = {
				enabled = true,
				padding = 3,
				lineCount = {
					template = "%d lines", -- `%d` is replaced with the number of folded lines
					hlgroup = "Purple",
				},
				diagnosticsCount = true, -- uses hlgroups and icons from `vim.diagnostic.config().signs`
				gitsignsCount = false, -- requires `gitsigns.nvim`
				disableOnFt = { "snacks_picker_input" }, ---@type string[]
			},
			autoFold = {
				enabled = true,
				kinds = { "comment", "imports" }, ---@type lsp.FoldingRangeKind[]
			},
			foldKeymaps = {
				setup = true, -- modifies `h`, `l`, and `$`
				hOnlyOpensOnFirstColumn = false,
			},
		},

		-- recommended: disable vim's auto-folding
		init = function()
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
		end,
		config = function(_, opts)
			require("origami").setup(opts)
			vim.keymap.set("n", "<leader>ua", "zR", { desc = "Unfold all" })
			vim.keymap.set("n", "<leader>h", function()
				require("origami").h()
			end)
			-- vim.keymap.set("n", "l", function() require("origami").l() end)
			-- vim.keymap.set("n", "<End>", function() require("origami").dollar() end)
		end,
	},
}
