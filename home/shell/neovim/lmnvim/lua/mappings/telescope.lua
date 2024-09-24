local keys = {
	{ "<leader>fb", "<cmd>Telescope buffers<CR>", mode = { "n" }, desc = "Telescope find buffers" },
	{ "<leader>fh", "<cmd>Telescope help_tags<CR>", mode = { "n" }, desc = "Telescope help page" },
	{
		"<leader>ff",
		"<cmd>ProjectRoot<CR><cmd>Telescope find_files<CR>",
		mode = { "n" },
		desc = "telescope find files (root)",
	},
	{
		"<leader>fw",
		"<cmd>ProjectRoot<CR><cmd>Telescope live_grep<CR>",
		mode = { "n" },
		desc = "Telescope find word (root)",
	},
}

return keys
