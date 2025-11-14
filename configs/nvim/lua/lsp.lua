---@diagnostic disable: undefined-global
return {

	---------------------------------------------------------------------------
	-- TREESITTER
	---------------------------------------------------------------------------
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
							hint = { enable = true },
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
		end,
	},

	---------------------------------------------------------------------------
	-- BLINK CMP
	---------------------------------------------------------------------------
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"zbirenbaum/copilot.lua",
			"giuxtaposition/blink-cmp-copilot", -- copilot source for blink
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
				enabled = true,
			},

			-- Extend sources and add copilot provider
			sources = {
				providers = {
					copilot = {
						async = true,
						module = "blink-cmp-copilot",
						name = "copilot",
						score_offset = 100,
					},
				},

				default = { "lsp", "path", "snippets", "buffer", "copilot" },
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

					-- Lua
					lua = { "stylua" },

					-- Shell / Bash
					sh = { "shfmt" },
					bash = { "shfmt" },

					-- Python
					python = { "isort", "black" },

					-- JavaScript / TypeScript
					javascript = { "prettierd", "prettier", stop_after_first = true },
					javascriptreact = { "prettierd", "prettier", stop_after_first = true },
					typescript = { "prettierd", "prettier", stop_after_first = true },
					typescriptreact = { "prettierd", "prettier", stop_after_first = true },

					-- Nix
					nix = { "nixfmt" },

					-- C / C++ / Obj-C
					c = { "clang_format" },
					cpp = { "clang_format" },

					-- CMake
					cmake = { "cmake_format" },

					-- Rust
					rust = { "rustfmt" },

					-- HTML
					html = { "prettierd", "prettier", stop_after_first = true },

					-- Tailwindcss (same as HTML/JS)
					astro = { "prettierd", "prettier", stop_after_first = true },
					svelte = { "prettierd", "prettier", stop_after_first = true },
					templ = { "prettierd", "prettier", stop_after_first = true },

					-- JSON
					json = { "prettierd", "prettier", stop_after_first = true },
					jsonc = { "prettierd", "prettier", stop_after_first = true },

					-- Markdown
					markdown = { "prettierd", "prettier", stop_after_first = true },

					-- Docker
					dockerfile = { "dockfmt" },

					-- YAML
					yaml = { "yamlfmt" },

					-- CSS / SCSS / LESS
					css = { "prettierd", "prettier", stop_after_first = true },
					scss = { "prettierd", "prettier", stop_after_first = true },
					less = { "prettierd", "prettier", stop_after_first = true },

					-- Fallback
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
					lsp_format = "fallback",
					timeout_ms = 1000,
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
				suggestion = { enabled = true },
				panel = { enabled = false },
				filetypes = {
					["*"] = true,
				},
			})
		end,
	},

	-------------------------------------------------------------------------
	--COPILOT → BLINK SOURCE INTEGRATION
	-------------------------------------------------------------------------
	{
		"giuxtaposition/blink-cmp-copilot",
	},
}
