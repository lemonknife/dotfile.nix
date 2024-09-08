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
          require("configs.lspsetup").on_attach(client, bufnr)
          map("n", "<leader>la", function()
            vim.cmd.RustLsp "codeAction"
          end, opts "Code action")
        end,
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            checkOnSave = true,
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
          },
        },
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
