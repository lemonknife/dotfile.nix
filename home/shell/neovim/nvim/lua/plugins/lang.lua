return {
  { import = "lazyvim.plugins.extras.lsp.none-ls" },

  -- NixOS
  { import = "lazyvim.plugins.extras.lang.nix" },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.code_actions.statix,
        nls.builtins.diagnostics.deadnix,
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        nix = { "statix", "deadnix" },
      },
    },
  },

  -- Cpp
  { import = "lazyvim.plugins.extras.lang.clang" },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "clangd" } },
  },

  -- Python
  { import = "lazyvim.plugins.extras.lang.python" },

  -- Rust
  { import = "lazyvim.plugins.extras.lang.rust" },

  -- Lua
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        lua = { "shfmt" },
      },
    },
  },

  -- Lang for config
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.toml" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
}
