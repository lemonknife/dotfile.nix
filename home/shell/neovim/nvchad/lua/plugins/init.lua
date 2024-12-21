-- load LazyVim utils
_G.LazyVim = require "lazyvim.util"
LazyVim.root.setup()

return {
  { "folke/lazy.nvim", version = "*" },
  {
    "williamboman/mason.nvim",
    enabled = false,
  },
}
