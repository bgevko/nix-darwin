---@diagnostic disable: undefined-global

-- Leaders
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Globals (LazyVim-style)
vim.g.markdown_recommended_style = 0

-- Options
vim.opt.autowrite = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.conceallevel = 2
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.expandtab = true

-- vim.opt.fillchars = {
-- 	foldopen = "",
-- 	foldclose = "",
-- 	fold = " ",
-- 	foldsep = " ",
-- 	diff = "╱",
-- 	eob = " ",
-- }
-- vim.opt.foldlevel = 99
-- vim.opt.foldmethod = "indent"
-- vim.opt.foldtext = ""
vim.opt.formatexpr = "v:lua.vim.lsp.formatexpr()"
vim.opt.formatoptions = "jcroqlnt"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.jumpoptions = "view"
vim.opt.laststatus = 3
vim.opt.linebreak = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.pumblend = 10
vim.opt.pumheight = 10
vim.opt.ruler = false
vim.opt.scrolloff = 4

vim.opt.sessionoptions = {
	"buffers",
	"curdir",
	"tabpages",
	"winsize",
	"help",
	"globals",
	"skiprtp",
	"folds",
}

vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.showmode = false
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smoothscroll = true
vim.opt.spelllang = { "en" }
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200
vim.opt.virtualedit = "block"
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.winminwidth = 5
vim.opt.wrap = false
