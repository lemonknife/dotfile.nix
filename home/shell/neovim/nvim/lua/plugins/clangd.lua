return {
  { import = "lazyvim.plugins.extras.lang.clangd" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          mason = false,
        },
      },
    },
  },
}
