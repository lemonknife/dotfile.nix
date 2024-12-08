local map = vim.keymap.set

-- Buffer
map("n", "<S-h>", "<cmd>bprev<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
