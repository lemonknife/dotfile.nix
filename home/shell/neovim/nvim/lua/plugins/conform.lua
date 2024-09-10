return {

  "stevearc/conform.nvim",
  branch = "nvim-0.9",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      cpp = { "clang-format" },
      nix = { "nixfmt" }
    },
  },

}
