return {

  {
    "gbprod/yanky.nvim",
    dependencies = {
      { "kkharji/sqlite.lua" },
    },
    opts = require("options.yanky"),
    keys = require("mappings.yanky"),
  },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      modes = {
        lsp = {
          win = { position = "right" },
        },
      },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>ls", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
      { "<leader>lS", "<cmd>Trouble lsp toggle<cr>", desc = "References/Definitions/... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
  },

  {
    "kawre/neotab.nvim",
    event = "InsertEnter",
    opts = {
      tabkey = "",
    },
  },

  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6",
    opts = {},
  },
}
