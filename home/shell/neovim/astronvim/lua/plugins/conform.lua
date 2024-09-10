return {

  "stevearc/conform.nvim",
  event = "BufWritePre",
  branch = "nvim-0.9",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      cpp = { "clang-format" },
      nix = { "nixfmt" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
