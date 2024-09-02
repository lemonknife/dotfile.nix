return {
  { import = "astrocommunity.lsp.inc-rename-nvim" },
  { import = "astrocommunity.lsp.lsp-lens-nvim" },
  {
    "AstroNvim/astrolsp",
    opts = {
      features = {
        inlay_hints = true,
      },
      config = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              rustfmt = {
                extraArgs = {
                  "--config",
                  "tab_spaces=2",
                },
              },
            },
          },
        },
      },
    },
  },
}
