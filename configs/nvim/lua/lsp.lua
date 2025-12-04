---@diagnostic disable: undefined-global
return {

	---------------------------------------------------------------------------
	-- TREESITTER
	---------------------------------------------------------------------------
	--- Parsers are installed automatically
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				highlight = {
					enable = true,
					disable = function(lang, buf)
						local max = 100 * 1024 -- 100KB
						local ok, stat = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stat and stat.size > max then
							return true
						end
					end,
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},

	---------------------------------------------------------------------------
	-- LSPCONFIG
	---------------------------------------------------------------------------
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
				docker = {},
				yamlls = {},
				cssls = {},
				gopls = {},
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

	---------------------------------------------------------------------------
	-- BLINK CMP
	---------------------------------------------------------------------------
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

	-------------------------------------------------------------------------
	-- FORMATTER → Conform
	-------------------------------------------------------------------------
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					sh = { "shfmt" },
					bash = { "shfmt" },
					python = { "isort", "black" },
					javascript = { "prettierd", "prettier", stop_after_first = true },
					javascriptreact = { "prettierd", "prettier", stop_after_first = true },
					typescript = { "prettierd", "prettier", stop_after_first = true },
					typescriptreact = { "prettierd", "prettier", stop_after_first = true },
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
					markdown = { "prettierd", "prettier", stop_after_first = true },
					dockerfile = { "dockfmt" },
					yaml = { "yamlfmt" },
					css = { "prettierd", "prettier", stop_after_first = true },
					scss = { "prettierd", "prettier", stop_after_first = true },
					less = { "prettierd", "prettier", stop_after_first = true },
					go = { "gofumpt", "gofmt", stop_after_first = true },

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

	-------------------------------------------------------------------------
	-- COPILOT BACKEND
	-------------------------------------------------------------------------
	{
		"zbirenbaum/copilot.lua",
		config = function()
			require("copilot").setup({
				suggestion = {
					panel = { enabled = false },
					enabled = true,
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
