require("nvchad.options")

require("tokyonight").load()

vim.api.nvim_set_hl(0, "NormalBorder", { fg = require("tokyonight.colors").setup().border_highlight, bg = nil })

vim.opt.relativenumber = true
vim.opt.pumblend = 10
vim.opt.winblend = 0
