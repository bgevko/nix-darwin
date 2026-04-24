---@diagnostic disable: undefined-global

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- augroups (from autoGroups)
local highlight_yank = augroup("highlight_yank", { clear = true })
local indentscope = augroup("indentscope", { clear = true })
local restore_cursor = augroup("restore_cursor", { clear = true })
local checktime = augroup("checktime", { clear = true })
local resize_splits = augroup("resize_splits", { clear = true })
local close_with_q = augroup("close_with_q", { clear = true })
local man_unlisted = augroup("man_unlisted", { clear = true })
local wrap_spell = augroup("wrap_spell", { clear = true })
local json_conceal = augroup("json_conceal", { clear = true })
local auto_create_dir = augroup("auto_create_dir", { clear = true })
local treesitter_notify = augroup("treesitter_notify", { clear = true })

-- ──────────────────────────────────────────────────────────────
-- Highlight on yank
-- ──────────────────────────────────────────────────────────────
autocmd("TextYankPost", {
	group = highlight_yank,
	pattern = "*",
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})

-- ──────────────────────────────────────────────────────────────
-- Disable indentscope for certain filetypes
-- ──────────────────────────────────────────────────────────────
autocmd("FileType", {
	group = indentscope,
	pattern = {
		"help",
		"Startup",
		"startup",
		"neo-tree",
		"Trouble",
		"trouble",
		"notify",
	},
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})

-- ──────────────────────────────────────────────────────────────
-- Restore cursor to last position (NVChad/LazyVim-style)
-- ──────────────────────────────────────────────────────────────
autocmd("BufReadPost", {
	group = restore_cursor,
	pattern = "*",
	callback = function()
		local exclude = { "gitcommit" }
		local buf = vim.api.nvim_get_current_buf()
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- ──────────────────────────────────────────────────────────────
-- Checktime – reload files changed outside of Neovim
-- ──────────────────────────────────────────────────────────────
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = checktime,
	pattern = "*",
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- ──────────────────────────────────────────────────────────────
-- Resize splits evenly when window is resized
-- ──────────────────────────────────────────────────────────────
autocmd("VimResized", {
	group = resize_splits,
	pattern = "*",
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- ──────────────────────────────────────────────────────────────
-- Close certain filetypes with 'q'
-- ──────────────────────────────────────────────────────────────
autocmd("FileType", {
	group = close_with_q,
	pattern = {
		"PlenaryTestPopup",
		"checkhealth",
		"dbout",
		"gitsigns-blame",
		"grug-far",
		"help",
		"lspinfo",
		"neotest-output",
		"neotest-output-panel",
		"neotest-summary",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, { buffer = event.buf, silent = true, desc = "Quit buffer" })
		end)
	end,
})

-- ──────────────────────────────────────────────────────────────
-- Make man pages unlisted
-- ──────────────────────────────────────────────────────────────
autocmd("FileType", {
	group = man_unlisted,
	pattern = "man",
	callback = function(event)
		vim.bo[event.buf].buflisted = false
	end,
})

-- ──────────────────────────────────────────────────────────────
-- Enable wrap + spell checking in text filetypes
-- ──────────────────────────────────────────────────────────────
autocmd("FileType", {
	group = wrap_spell,
	pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- ──────────────────────────────────────────────────────────────
-- Disable conceal in JSON-like filetypes
-- ──────────────────────────────────────────────────────────────
autocmd("FileType", {
	group = json_conceal,
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- ──────────────────────────────────────────────────────────────
-- Auto-create directories when saving
-- ──────────────────────────────────────────────────────────────
autocmd("BufWritePre", {
	group = auto_create_dir,
	pattern = "*",
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

--Format on save (respects global autoformat toggle)
autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		if vim.g.autoformat == false then
			return
		end
		require("conform").format({ bufnr = args.buf })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

-- Restore LspInfo command, which was removed in nvim 0.12
vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", { desc = "Show LSP Info" })
