return {
  { import = "lazyvim.plugins.extras.lang.python" },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          mason = false,
          settings = {
            basedpyright = {
              analysis = {
                ignore = { "*" },
              },
              disableOrganizeImports = true,
            },
          },
        },
      },
    },
  },
}
