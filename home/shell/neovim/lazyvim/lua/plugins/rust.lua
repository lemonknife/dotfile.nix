return {
  { import = "lazyvim.plugins.extras.lang.rust" },

  { "mrcjkb/rustaceanvim", version = "^5" },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        rust = { "rustfmt", lsp_format = "fallback" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        taplo = {
          mason = false,
        },
      },
    },
  },
}
