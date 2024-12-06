local configs = function(plugin)
	LazyVim.on_load("telescope.nvim", function()
		local ok, err = pcall(require("telescope").load_extension, "fzf")
		if not ok then
			local lib = plugin.dir .. "/build/libfzf.so"
			if not vim.uv.fs_stat(lib) then
				vim.notify("`telescope-fzf-native.nvim` not built. Rebuilding...", vim.log.levels.WARN)
				require("lazy").build({ plugins = { plugin }, show = false }):wait(function()
					vim.notify(
						"Rebuilding `telescope-fzf-native.nvim` done.\nPlease restart Neovim.",
						vim.log.levels.INFO
					)
				end)
			else
				vim.notify("Failed to load `telescope-fzf-native.nvim`:\n" .. err, vim.log.levels.ERROR)
			end
		end
	end)
end

return configs
