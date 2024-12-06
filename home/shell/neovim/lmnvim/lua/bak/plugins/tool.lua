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

  {
    "akinsho/toggleterm.nvim",
    config = true,
    version = "*",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<leader>tt", "<Cmd>ToggleTerm direction=float<CR>", desc = "ToggleTerm float" },
      {
        "<Leader>th",
        "<Cmd>ToggleTerm size=15 direction=horizontal<CR>",
        desc = "ToggleTerm horizontal split",
      },
      { "<Leader>tv", "<Cmd>ToggleTerm size=70 direction=vertical<CR>", desc = "ToggleTerm vertical split" },
    },
    opts = {
      on_open = function(term)
        vim.cmd.startinsert()
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,
      -- function to run on closing the terminal
      on_close = function(term)
        vim.cmd.startinsert()
      end,
      shade_terminals = false,
      float_opts = { border = "rounded" },
      highlights = {
        Normal = { link = "NormalFloat" },
        NormalNC = { link = "NormalFloat" },
        NormalFloat = { link = "NormalFloat" },
        FloatBorder = { link = "FloatBorder" },
        StatusLine = { link = "StatusLine" },
        StatusLineNC = { link = "StatusLineNC" },
        WinBar = { link = "WinBar" },
        WinBarNC = { link = "WinBarNC" },
      },
      size = 10,
    },
  },

  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Go to Left Window", remap = true },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Go to Lower Window", remap = true },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Go to Upper Window", remap = true },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Go to Right Window", remap = true },
    },
  },
}
