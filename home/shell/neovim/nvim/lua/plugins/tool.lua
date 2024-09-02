local prefix = "<leader>s"
return {
  { import = "astrocommunity.editing-support.ultimate-autopair-nvim" },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    dependencies = {
      { "AstroNvim/astroui", opts = { icons = { Surround = "" } } },
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n[prefix] = { desc = require("astroui").get_icon("Surround", 1, true) .. "Surround" }
          maps.x[prefix] = { desc = require("astroui").get_icon("Surround", 1, true) .. "Surround" }
        end,
      },
    },
    keys = {
      {
        prefix .. "a",
        "<Plug>(nvim-surround-normal)",
        desc = "Add surrounding",
        mode = "n",
      },
      {
        prefix .. "aa",
        "<Plug>(nvim-surround-normal-cur)",
        desc = "Add surrounding on current line",
        mode = "n",
      },
      { prefix .. "d", "<Plug>(nvim-surround-delete)", desc = "Delete surrounding", mode = "n" },
      { prefix .. "c", "<Plug>(nvim-surround-change)", desc = "Change surrounding", mode = "n" },
      { prefix .. "a", "<Plug>(nvim-surround-visual)", desc = "Add surrounding", mode = "x" },
    },
    opts = {
      keymaps = {
        insert = false,
        insert_line = false,
        normal = false,
        normal_cur = false,
        normal_line = false,
        normal_cur_line = false,
        visual = false,
        visual_line = false,
        delete = false,
        change = false,
        change_line = false,
      },
    },
  },

  -- Toggle
  { import = "astrocommunity.utility.nvim-toggler" },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {
      default_mappings = false,
      mappings = {
        i = {
          j = {
            j = "<Esc>",
          },
        },
      },
    },
  },

  -- LeetCode
  { import = "astrocommunity.game.leetcode-nvim" },
  {
    "kawre/leetcode.nvim",
    opts = {
      lang = "rust",
      cn = { -- leetcode.cn
        enabled = true,
      },
    },
  },
}
