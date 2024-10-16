vim.g.base46_cache = vim.fn.stdpath("data") .. "/nvchad/base46/"
vim.g.mapleader = " "
vim.opt.laststatus = 3 -- for bufferline

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

local lazy_options = require("options.lazy")

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = true,
    branch = "v2.5",
  },

  {
    "LazyVim/LazyVim",
    lazy = true,
  },

  { import = "plugins" },
  { import = "extras" },
}, lazy_options)

require("options")
require("autocmds")

vim.schedule(function()
  require("mappings")
end)
