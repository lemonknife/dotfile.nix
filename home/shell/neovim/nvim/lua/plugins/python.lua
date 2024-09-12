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
                typeCheckingMode = "all",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                autoImportCompletions = true,
                diagnosticsMode = "openFilesOnly",
                diagnosticSeverityOverrides = {
                  reportUnknownMemberType = false,
                  reportUnknownArgumentType = false,
                  reportUnusedImport = false, -- ugly :(
                  reportUndefinedVariable = false,
                },
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
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        python = { "ruff_organize_imports", "ruff_format" },
      },
    },
  },
}
