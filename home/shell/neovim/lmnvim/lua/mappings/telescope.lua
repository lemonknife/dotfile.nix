local keys = {
	{ "<leader>fw", "<cmd>Telescope live_grep<CR>", mode = { "n" }, desc = "Telescope find word" },
	{ "<leader>fb", "<cmd>Telescope buffers<CR>", mode = { "n" }, desc = "Telescope find buffers" },
	{ "<leader>fh", "<cmd>Telescope help_tags<CR>", mode = { "n" }, desc = "Telescope help page" },
	{ "<leader>fF", "<cmd>Telescope find_files<cr>", mode = { "n" }, desc = "telescope find files (cwd)" },
}

return keys
