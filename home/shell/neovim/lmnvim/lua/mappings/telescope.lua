local keys = {
	{ "<leader>fw", "<cmd>Telescope live_grep<CR>", mode = { "n" }, desc = "Telescope find word" },
	{ "<leader>fb", "<cmd>Telescope buffers<CR>", mode = { "n" }, desc = "Telescope find buffers" },
	{ "<leader>fh", "<cmd>Telescope help_tags<CR>", mode = { "n" }, desc = "Telescope help page" },
	{ "<leader>ff", "<cmd>Telescope find_files<CR>", mode = { "n" }, desc = "telescope find files (root)" },
	{
		"<leader>fF",
		function()
			require("telescope.builtin").find_files({
				cwd = require("telescope.utils").buffer_dirs(),
			})
		end,
		mode = { "n" },
		desc = "telescope find files (cwd)",
	},
}

return keys
