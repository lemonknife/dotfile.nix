return {
  { import = "lazyvim.plugins.extras.lsp.neoconf" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          mason = false,
        },
      },
    },
  },
}
