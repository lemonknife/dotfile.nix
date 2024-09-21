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
              disableOrganizeImports = true, -- managed by ruff
              analysis = {
                typeCheckingMode = "standard",
              },
            },
          },
        },
        ruff = {
          mason = false,
        },
      },
    },
  },

  {
    "linux-cultist/venv-selector.nvim",
    opts = {
      settings = {
        search = {
          micromamba_base = {
            command = "$FD 'bin/python$' ~/micromamba/bin --full-path --color never",
            type = "anaconda",
          },
          micromamba_envs = {
            command = "$FD 'bin/python$' ~/micromamba/envs --full-path --color never",
            type = "anaconda",
          },
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        python = { "ruff_organize_imports", "ruff_format" },
      },
    },
  },
}
