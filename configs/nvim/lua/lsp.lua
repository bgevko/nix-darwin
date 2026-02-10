---@diagnostic disable: undefined-global
return {

	-- ╭─────────────────────────────────────────────────────────╮
	-- │                       Tree Sitter                       │
	-- ╰─────────────────────────────────────────────────────────╯
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			-- optional: auto-enable features for your languages
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"bash",
					"c",
					"cmake",
					"cpp",
					"css",
					"dockerfile",
					"go",
					"html",
					"javascript",
					"json",
					"lua",
					"markdown",
					"nix",
					"python",
					"rust",
					"scss",
					"typescript",
					"typescriptreact",
					"yaml",
					"fish",
				},
				callback = function()
					-- highlighting (Neovim built-in)
					pcall(vim.treesitter.start)

					-- folds (Neovim built-in)
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo.foldmethod = "expr"

					-- indentation (provided by nvim-treesitter)
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
	--          ╭─────────────────────────────────────────────────────────╮
	--          │                        LSPCONFIG                        │
	--          ╰─────────────────────────────────────────────────────────╯
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- 1. diagnostics
			vim.diagnostic.config({
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
				},
				signs = true,
			})

			-- 2. capabilities (blink.cmp if present)
			local ok_blink, blink = pcall(require, "blink.cmp")
			local capabilities = ok_blink and blink.get_lsp_capabilities()
				or vim.lsp.protocol.make_client_capabilities()

			-- 3. servers (single source of truth)
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							workspace = { checkThirdParty = false },
							diagnostics = { globals = { "vim" } },
						},
					},
				},
				bashls = {},
				pyright = {},
				ts_ls = {},
				nixd = {},
				clangd = {},
				cmake = {},
				rust_analyzer = {},
				html = {},
				tailwindcss = {},
				jsonls = {},
				marksman = {},
				yamlls = {},
				cssls = {},
				gopls = {},
				eslint = {},
				fish_lsp = {},
			}

			-- 4. configure + warn + enable
			for name, cfg in pairs(servers) do
				cfg.capabilities = vim.tbl_deep_extend("force", capabilities, cfg.capabilities or {})

				-- merge with builtin/nvim-lspconfig defaults
				vim.lsp.config(name, cfg)

				-- look at the *real* resolved config (from lspconfig + your overrides)
				local conf = vim.lsp.config[name]
				local cmd = conf and conf.cmd
				local bin = type(cmd) == "table" and cmd[1] or cmd

				if bin and vim.fn.executable(bin) == 0 then
					vim.notify(
						("LSP '%s' not started: command '%s' not found in PATH"):format(name, bin),
						vim.log.levels.WARN,
						{ title = "LSP missing" }
					)
				else
					-- let it fail quietly if something else is wrong
					pcall(vim.lsp.enable, name)
				end
			end

			-- 5. inlay hints on attach
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					local buf = args.buf
					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						vim.lsp.inlay_hint.enable(true, { bufnr = buf })
					end
				end,
			})

			-- Custom LSP keymaps
			local map = vim.keymap.set
			local Snacks = require("snacks")
			map("n", "<leader>lsp", Snacks.picker.lsp_config, { desc = "LSP Configurations" })
			map("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
			map("n", "gr", function()
				Snacks.picker.lsp_references()
			end, { desc = "Goto References" })
			map("n", "gi", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
			map("n", "gy", vim.lsp.buf.type_definition, { desc = "Goto Type Definition" })
			map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
			map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
			map("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
			map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
			map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename Symbol" })
			map("n", "<leader>cR", Snacks.rename.rename_file, { desc = "Rename File" })
		end,
	},

	--          ╭─────────────────────────────────────────────────────────╮
	--          │                        BLINK CMP                        │
	--          ╰─────────────────────────────────────────────────────────╯
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		version = "1.*",
		opts = {
			keymap = { preset = "enter" },
			appearance = {
				nerd_font_variant = "mono",
			},
			snippets = {
				preset = "default",
			},
			signature = {
				enabled = false,
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = {
				implementation = "prefer_rust_with_warning",
			},
		},

		-- Allows other specs to extend source lists
		opts_extend = { "sources.default" },
	},

	--          ╭─────────────────────────────────────────────────────────╮
	--          │                   FORMATTER → Conform                   │
	--          ╰─────────────────────────────────────────────────────────╯
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					sh = { "shfmt" },
					bash = { "shfmt" },
					python = { "isort", "black" },
					javascript = { "eslint_d" },
					javascriptreact = { "eslint_d" },
					typescript = { "prettierd" },
					typescriptreact = { "prettierd" },
					nix = { "nixfmt" },
					c = { "clang_format" },
					cpp = { "clang_format" },
					cmake = { "cmake_format" },
					rust = { "rustfmt" },
					html = { "prettierd", "prettier", stop_after_first = true },
					astro = { "prettierd", "prettier", stop_after_first = true },
					svelte = { "prettierd", "prettier", stop_after_first = true },
					templ = { "prettierd", "prettier", stop_after_first = true },
					json = { "prettierd", "prettier", stop_after_first = true },
					jsonc = { "prettierd", "prettier", stop_after_first = true },
					-- markdown = { "prettierd", "prettier", stop_after_first = true },
					yaml = { "yamlfmt" },
					css = { "prettierd", "prettier", stop_after_first = true },
					scss = { "prettierd", "prettier", stop_after_first = true },
					less = { "prettierd", "prettier", stop_after_first = true },
					go = { "gofumpt", "gofmt", stop_after_first = true },
					fish = { "fish_indent" },
					["_"] = { "trim_whitespace" },
				},

				formatters = {
					dockfmt = {
						command = "dockfmt",
						args = { "fmt", "-" },
						stdin = true,
					},
				},
				format_on_save = {
					lsp_fallback = true,
				},
			})
		end,
	},

	--          ╭─────────────────────────────────────────────────────────╮
	--          │                     COPILOT BACKEND                     │
	--          ╰─────────────────────────────────────────────────────────╯
	{
		"zbirenbaum/copilot.lua",
		enabled = vim.env.NIX_HOST == "home",
		config = function()
			require("copilot").setup({
				suggestion = {
					panel = { enabled = false },
					enabled = vim.env.NIX_HOST == "home",
					auto_trigger = true,
					hide_during_completion = true,
					debounce = 75,
					trigger_on_accept = true,
					keymap = {
						accept = "<C-f>",
						accept_word = false,
						accept_line = false,
					},
				},
			})
		end,
	},
}
