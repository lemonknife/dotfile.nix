local configs = function(_, opts)
	require("project_nvim").setup(opts)
	local ok, err = pcall(require("telescope").load_extension, "projects")
	if not ok then
		vim.notify("Failed to load `project-nvim.lua`:\n" .. err, vim.log.levels.ERROR)
	end
end

return configs
