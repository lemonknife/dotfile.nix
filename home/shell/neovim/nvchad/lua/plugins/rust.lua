return {
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    opts = {
      server = {
        on_attach = function(client, bufnr)
          local map = vim.keymap.set
          local function opts(desc)
            return { buffer = bufnr, desc = "Rust LSP " .. desc }
          end
          require("configs.lsp").on_attach(client, bufnr)
          map("n", "<leader>la", function()
            vim.cmd.RustLsp "codeAction"
          end, opts "Code action")
        end,
        default_settings = require "configs.lsp.rust",
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
      if vim.fn.executable "rust-analyzer" == 0 then
        vim.notify("BAKA! You haven't installed rust-analyzer!", "error")
      end
    end,
  },
}
