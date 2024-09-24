local utils = require("utils")

local configs = function(plugin)
	utils.on_load("telescope.nvim", function()
		local ok, err = pcall(require("telescope").load_extension, "fzf")
		if not ok then
			local lib = plugin.dir .. "/build/libfzf.so"
			if not vim.uv.fs_stat(lib) then
				vim.api.nvim_echo({
					{ "`telescope-fzf-native.nvim` not built. Rebuilding...", "WarningMsg" },
				}, false, {})
				require("lazy").build({ plugins = { plugin }, show = false }):wait(function()
					vim.api.nvim_echo({
						{
							"Rebuilding `telescope-fzf-native.nvim` done.\nPlease restart Neovim.",
							"InfoMsg",
						},
					}, false, {})
				end)
			else
				vim.api.nvim_echo({
					{
						"Failed to load `telescope-fzf-native.nvim`:\n" .. err,
						"ErrorMsg",
					},
				}, false, {})
			end
		end
	end)
end

return configs
