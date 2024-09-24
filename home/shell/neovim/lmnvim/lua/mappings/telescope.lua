local map = vim.keymap.set
local path = require("utils.path")

map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope help page" })

map("n", "<leader>fF", "<cmd>Telescope find_files<CR>", { desc = "telescope find files (cwd)" })
map("n", "<leader>fW", "<cmd>Telescope live_grep<CR>", { desc = "telescope find files (cwd)" })
map("n", "<leader>ff", function()
	require("telescope.builtin").find_files({
		cwd = path.get(),
	})
end, { desc = "telescope find files (root)" })
map(
	"n",
	"<leader>fw",function()

	require("telescope.builtin").live_grep({
		cwd = path.get(),
	})end,
	{ desc = "Telescope find word (root)" }
)
