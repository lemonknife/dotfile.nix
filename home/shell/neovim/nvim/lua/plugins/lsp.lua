return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          mason = false,
        },
        lua_ls = {
          mason = false,
        },
      },
    },
  },
}
