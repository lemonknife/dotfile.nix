return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          mason = false,
        },
        ruff = {
          mason = false,
        },
        lua_ls = {
          mason = false,
        },
        clangd = {
          mason = false,
        },
      },
    },
  },
}
