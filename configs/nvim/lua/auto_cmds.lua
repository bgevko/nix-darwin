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
local project_on_save = augroup("project_on_save", { clear = true })
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

-- Format on save (respects global autoformat toggle)
autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		if vim.g.autoformat == false then
			return
		end
		require("conform").format({ bufnr = args.buf, lsp_fallback = true })
	end,
})

-- ──────────────────────────────────────────────────────────────
-- Project-local save hook
-- ──────────────────────────────────────────────────────────────
autocmd("BufWritePost", {
	group = project_on_save,
	pattern = "*",
	callback = function(event)
		if vim.bo[event.buf].buftype ~= "" then
			return
		end

		local file = vim.uv.fs_realpath(event.match) or event.match
		local dir = vim.fs.dirname(file)
		if not dir then
			return
		end

		local hook = vim.fs.find(".nvim/on-save", {
			path = dir,
			upward = true,
			type = "file",
		})[1]
		if not hook or vim.fn.executable(hook) ~= 1 then
			return
		end

		local project_root = vim.fs.dirname(vim.fs.dirname(hook))
		local patterns_file = project_root .. "/.nvim/on-save.patterns"
		if vim.uv.fs_stat(patterns_file) then
			local rel_file = vim.fs.relpath(project_root, file) or file
			local matched = false

			for _, pattern in ipairs(vim.fn.readfile(patterns_file)) do
				pattern = vim.trim(pattern)
				if pattern ~= "" and not vim.startswith(pattern, "#") then
					local regex = vim.fn.glob2regpat(pattern)
					if vim.fn.match(rel_file, regex) >= 0 or vim.fn.match(file, regex) >= 0 then
						matched = true
						break
					end
				end
			end

			if not matched then
				return
			end
		end

		local function find_output_buf()
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_is_valid(buf) and vim.b[buf].on_save_output then
					return buf
				end
			end
			return nil
		end

		local function close_output_window()
			local buf = find_output_buf()
			if not buf then
				return
			end

			for _, win in ipairs(vim.fn.win_findbuf(buf)) do
				if vim.api.nvim_win_is_valid(win) then
					vim.api.nvim_win_close(win, true)
				end
			end
		end

		local function open_output_buffer(lines)
			local buf = find_output_buf()
			if not buf then
				buf = vim.api.nvim_create_buf(false, true)
				vim.api.nvim_buf_set_name(buf, "[on-save]")
				vim.b[buf].on_save_output = true
				vim.bo[buf].buftype = "nofile"
				vim.bo[buf].bufhidden = "hide"
				vim.bo[buf].swapfile = false
				vim.bo[buf].filetype = "on-save-log"
				vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true, desc = "Close on-save output" })
			end

			vim.bo[buf].modifiable = true
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
			vim.bo[buf].modifiable = false

			local win = vim.fn.win_findbuf(buf)[1]
			if win and vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_set_current_win(win)
			else
				vim.cmd("botright 12split")
				vim.api.nvim_win_set_buf(0, buf)
			end

			vim.cmd("normal! G")
		end

		local function notify_hook(message, level)
			local highlight = level == vim.log.levels.ERROR and "ErrorMsg" or "MoreMsg"
			vim.api.nvim_echo({ { ".nvim/on-save: " .. message, highlight } }, true, {})
		end

		local result = vim.system({
			hook,
			file,
			project_root,
		}, {
			cwd = project_root,
			text = true,
			env = {
				NVIM_SAVE_FILE = file,
				NVIM_PROJECT_ROOT = project_root,
				NVIM_FILETYPE = vim.bo[event.buf].filetype,
			},
		}):wait()

		if result.code == 0 then
			close_output_window()
			notify_hook("completed", vim.log.levels.INFO)
			return
		end

		local msg = vim.trim((result.stderr or "") .. "\n" .. (result.stdout or ""))
		if msg == "" then
			msg = "failed with exit code " .. result.code
		end

		local output_lines = {
			".nvim/on-save failed",
			"file: " .. file,
			"hook: " .. hook,
			"exit: " .. tostring(result.code),
			"",
		}
		vim.list_extend(output_lines, vim.split(msg, "\n", { plain = true }))

		open_output_buffer(output_lines)
		notify_hook("failed", vim.log.levels.ERROR)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

vim.api.nvim_create_user_command("OnSaveHookStatus", function()
	local file = vim.uv.fs_realpath(vim.api.nvim_buf_get_name(0)) or vim.api.nvim_buf_get_name(0)
	local dir = vim.fs.dirname(file)
	local hook = dir
			and vim.fs.find(".nvim/on-save", {
				path = dir,
				upward = true,
				type = "file",
			})[1]
		or nil

	local autocmds = vim.api.nvim_get_autocmds({ group = "project_on_save", event = "BufWritePost" })
	local lines = {
		"buffer: " .. (file ~= "" and file or "<none>"),
		"hook: " .. (hook or "<not found>"),
		"hook executable: " .. ((hook and vim.fn.executable(hook) == 1) and "yes" or "no"),
		"autocmds: " .. tostring(#autocmds),
	}

	vim.api.nvim_echo({ { table.concat(lines, "\n"), "MoreMsg" } }, true, {})
end, { desc = "Show project .nvim/on-save hook status" })

-- Restore LspInfo command, which was removed in nvim 0.12
vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", { desc = "Show LSP Info" })
