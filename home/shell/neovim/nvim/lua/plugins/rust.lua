return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    lazy = false,
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
        vim.notify("BAKA! You haven't installed rust-analyzer!", vim.log.levels.ERROR)
      end
    end,
  },
}
