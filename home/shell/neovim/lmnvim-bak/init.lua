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

-- Terminal Mappings
local function term_nav(dir)
  ---@param self snacks.terminal
  return function(self)
    return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
      vim.cmd.wincmd(dir)
    end)
  end
end

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

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = function()
      ---@type snacks.Config
      return {
        toggle = { map = LazyVim.safe_keymap_set },
        statuscolumn = { enabled = false }, -- we set this in options.lua
        terminal = {
          win = {
            keys = {
              nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
              nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
              nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
              nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
            },
          },
        },
      }
    end,
  },

  { import = "plugins" },
  { import = "extras" },
}, lazy_options)

require("options")
require("autocmds")

vim.schedule(function()
  require("mappings")
end)
