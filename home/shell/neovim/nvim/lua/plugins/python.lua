return {
  { import = "lazyvim.plugins.extras.lang.python" },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
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
