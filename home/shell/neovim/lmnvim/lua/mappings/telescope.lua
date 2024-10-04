return {
	{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Telescope find buffers" },
	{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Telescope help page" },
	{ "<leader>fF", "<cmd>Telescope find_files<CR>", desc = "telescope find files (cwd)" },
	{ "<leader>fW", "<cmd>Telescope live_grep<CR>", desc = "telescope find word (cwd)" },
	{ "<leader>ff", LazyVim.pick("files"), desc = "telescope find files (root)" },
	{ "<leader>fw", LazyVim.pick("live_grep"), desc = "Telescope find word (root)" },
}
