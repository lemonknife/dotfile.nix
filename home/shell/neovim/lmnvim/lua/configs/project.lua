local configs = function(_, opts)
	require("project_nvim").setup(opts)
	local ok, err = pcall(require("telescope").load_extension, "projects")
	if not ok then
		vim.api.nvim_echo({
			{
				"Failed to load `project-nvim.lua`:\n" .. err,
				"ErrorMsg",
			},
		}, false, {})
	end
end

return configs
