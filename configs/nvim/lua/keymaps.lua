---@diagnostic disable: undefined-global

-- globals
vim.g.mapleader = " "

-- keymaps
vim.keymap.set("n", "<leader>e", "<cmd>lua Snacks.explorer.open()<cr>", {
	desc = "File Explorer",
	silent = true,
})
vim.keymap.set("n", "<leader>E", "<cmd>lua Snacks.explorer.reveal()<cr>", {
	desc = "File Explorer",
	silent = true,
})

vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", {
	expr = true,
	silent = true,
})

vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", {
	expr = true,
	silent = true,
})

vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", {
	expr = true,
	silent = true,
})

vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", {
	expr = true,
	silent = true,
})

vim.keymap.set("x", "<", "<gv")

vim.keymap.set("x", ">", ">gv")

vim.keymap.set("n", "<C-h>", "<C-w>h", {
	desc = "Go to Left Window",
	remap = true,
})

vim.keymap.set("n", "<C-j>", "<C-w>j", {
	desc = "Go to Lower Window",
	remap = true,
})

vim.keymap.set("n", "<C-k>", "<C-w>k", {
	desc = "Go to Upper Window",
	remap = true,
})

vim.keymap.set("n", "<C-l>", "<C-w>l", {
	desc = "Go to Right Window",
	remap = true,
})

vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", {
	desc = "Escape and Clear hlsearch",
})

vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", {
	expr = true,
	desc = "Next Search Result",
})

vim.keymap.set("x", "n", "'Nn'[v:searchforward]", {
	expr = true,
	desc = "Next Search Result",
})

vim.keymap.set("o", "n", "'Nn'[v:searchforward]", {
	expr = true,
	desc = "Next Search Result",
})

vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", {
	expr = true,
	desc = "Prev Search Result",
})

vim.keymap.set("x", "N", "'nN'[v:searchforward]", {
	expr = true,
	desc = "Prev Search Result",
})

vim.keymap.set("o", "N", "'nN'[v:searchforward]", {
	expr = true,
	desc = "Prev Search Result",
})

vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, {
	desc = "Line Diagnostics",
})

vim.keymap.set("n", "]d", function()
	diagnostic_goto(true)
end, {
	desc = "Next Diagnostic",
})

vim.keymap.set("n", "[d", function()
	diagnostic_goto(false)
end, {
	desc = "Prev Diagnostic",
})

vim.keymap.set("n", "]e", function()
	diagnostic_goto(true, "ERROR")
end, {
	desc = "Next Error",
})

vim.keymap.set("n", "[e", function()
	diagnostic_goto(false, "ERROR")
end, {
	desc = "Prev Error",
})

vim.keymap.set("n", "]w", function()
	diagnostic_goto(true, "WARN")
end, {
	desc = "Next Warning",
})

vim.keymap.set("n", "[w", function()
	diagnostic_goto(false, "WARN")
end, {
	desc = "Prev Warning",
})

vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", {
	desc = "Quit All",
})

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", {
	desc = "Enter Normal Mode",
})

vim.keymap.set("i", "jk", "<Esc>", {
	noremap = true,
	silent = true,
	desc = "jk to exit insert mode",
})

vim.keymap.set("i", "JK", "<Esc>", {
	noremap = true,
	silent = true,
	desc = "JK to exit insert mode",
})

vim.keymap.set("v", "jk", "<Esc>", {
	noremap = true,
	silent = true,
	desc = "jk to exit visual mode",
})

-- Paste without yanking
vim.keymap.set("v", "p", '"_dP', {
	desc = "Paste without yanking",
})

-- Delete/change without yanking
vim.keymap.set("n", "dd", '"_dd', {
	desc = "Delete line without yanking",
})

vim.keymap.set("n", "d", '"_d', {
	desc = "Delete without yanking",
})

vim.keymap.set("v", "d", '"_d', {
	desc = "Delete without yanking",
})

vim.keymap.set("n", "D", '"_D', {
	desc = "Delete to end of line without yanking",
})

vim.keymap.set("n", "c", '"_c', {
	desc = "Change without yanking",
})

vim.keymap.set("n", "cc", '"_cc', {
	desc = "Change line without yanking",
})

-- Move selection up/down with capital K/J
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {
	desc = "Move selection up",
})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {
	desc = "Move selection down",
})

-- Join lines with cursor position preserved
vim.keymap.set("n", "J", "mzJ`z", {
	desc = "Join lines (keep cursor position)",
})

-- Search & Replace word under cursor
vim.keymap.set("n", "<leader>r", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", {
	desc = "Replace word under cursor",
})

vim.keymap.set("n", "<leader>;", ":!./local.sh<CR>", {
	desc = "Run local script 'local.sh'",
})

vim.keymap.set("n", "<leader>m", "<cmd>lua Snacks.dashboard()<cr>", {
	desc = "Dashboard",
	silent = true,
})

vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", {
	desc = "Switch to Other Buffer",
})

vim.keymap.set("n", "<leader>bd", "<cmd>lua Snacks.bufdelete()<cr>", {
	desc = "Delete Buffer",
})

vim.keymap.set("n", "<leader>bo", "<cmd>lua Snacks.bufdelete.other()<cr>", {
	desc = "Delete Other Buffers",
})

vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", {
	desc = "Add Comment Below",
})

vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", {
	desc = "Add Comment Above",
})

vim.keymap.set({ "n", "x" }, "<leader>sr", function()
	local grug = require("grug-far")
	local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
	grug.open({
		transient = true,
		prefills = {
			filesFilter = ext and ext ~= "" and "*." .. ext or nil,
		},
	})
end, {
	desc = "Search and Replace",
})

vim.keymap.set("n", "<leader>U", "<cmd>UndotreeToggle<cr>", {
	desc = "Undo Tree",
})

-- Toggle auto format
local function toggle_autoformat()
	vim.g.autoformat = not vim.g.autoformat
	local msg = vim.g.autoformat and "Autoformat Enabled" or "Autoformat Disabled"
	vim.notify(msg, vim.g.autoformat and vim.log.levels.INFO or vim.log.levels.WARN)
end

-- keymap like LazyVim: <leader>uf
vim.keymap.set("n", "<leader>uf", toggle_autoformat, {
	desc = "Toggle Autoformat",
})

-- code actions
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
