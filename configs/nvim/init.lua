-- Disable experimental Lua module loader (prevents cache_loader poisoning)
if vim.loader and vim.loader.enable then
	vim.loader.enable(false)
end
require("_lazy")
