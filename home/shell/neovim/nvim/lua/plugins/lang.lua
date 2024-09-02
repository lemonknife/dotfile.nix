return {

  {
    "nvimtools/none-ls.nvim",
    opts = function(_, config)
      config.sources = {}
      return config -- return final config table
    end,
  },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },

  -- Java
  { import = "astrocommunity.pack.java" },
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      settings = {
        format = {
          enabled = true,
          settings = {
            url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
            profile = "GoogleStyle",
          },
        },
      },
    },
  },

  -- Rust
  { import = "astrocommunity.pack.rust" },

  -- Nix
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "nix" })
      end
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local builtins = require("null-ls").builtins
      opts.sources = require("astrocore").list_insert_unique(opts.sources, {
        builtins.code_actions.statix,
        builtins.formatting.nixfmt,
        builtins.diagnostics.deadnix,
      })
    end,
  },
  {
    "AstroNvim/astrolsp",
    optional = true,
    opts = function(_, opts) opts.servers = require("astrocore").list_insert_unique(opts.servers, { "nixd" }) end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        nix = { "nixfmt" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        nix = { "statix", "deadnix" },
      },
    },
  },

  -- JSON
  { import = "astrocommunity.pack.json" },

  -- HTML
  { import = "astrocommunity.pack.html-css" },

  -- Yuck
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "yuck" })
      end
    end,
  },
}
