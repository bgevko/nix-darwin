local save_autocmds = vim.api.nvim_get_autocmds({ event = "BufWritePre" })

for _, autocmd in ipairs(save_autocmds) do
	assert(
		not (autocmd.group_name == "Conform" and autocmd.desc == "Format on save"),
		"Conform must not install an unconditional format-on-save autocmd"
	)
end

local conform = package.loaded.conform
local calls = {}
package.loaded.conform = {
	format = function(opts)
		table.insert(calls, opts)
	end,
}

local buffer = vim.api.nvim_create_buf(true, false)
vim.g.autoformat = false
vim.api.nvim_exec_autocmds("BufWritePre", { buffer = buffer })
assert(#calls == 0, "autoformat toggle must skip formatting")

vim.g.autoformat = true
vim.api.nvim_exec_autocmds("BufWritePre", { buffer = buffer })
assert(#calls == 1, "autoformat must format once when enabled")
assert(calls[1].bufnr == buffer and calls[1].lsp_fallback, "save formatting must retain LSP fallback")

package.loaded.conform = conform
