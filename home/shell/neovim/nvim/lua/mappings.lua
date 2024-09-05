require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local unmap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<c-w>s", "<leader>-", { desc = "Split window horizontally" })
map("n", "<c-w>v", "<leader>\\", { desc = "Split window vertically" })

unmap("n", "<c-w>s")
unmap("n", "<c-w>v")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
