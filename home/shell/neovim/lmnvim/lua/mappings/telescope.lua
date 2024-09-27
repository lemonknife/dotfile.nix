local map = vim.keymap.set

map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope help page" })

map("n", "<leader>fF", "<cmd>Telescope find_files<CR>", { desc = "telescope find files (cwd)" })
map("n", "<leader>fW", "<cmd>Telescope live_grep<CR>", { desc = "telescope find files (cwd)" })
map("n", "<leader>ff", LazyVim.pick("files"), { desc = "telescope find files (root)" })
map("n", "<leader>fw", LazyVim.pick("live_grep"), { desc = "Telescope find word (root)" })
