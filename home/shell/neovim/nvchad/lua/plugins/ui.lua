return {
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require "configs.gitsigns"
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
    },
  },

  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },

  { "j-hui/fidget.nvim", event = "VeryLazy", opts = {} },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      views = {
        cmdline_popup = {
          border = {
            style = "solid",
          },
          win_options = {
            winhighlight = {
              Normal = "NoiceNormalFloat",
              FloatBorder = "NoiceFloatBorder",
            },
          },
        },
        cmdline_popupmenu = {
          border = {
            style = "solid",
          },
          scrollbar = false,
          win_options = {
            winhighlight = {
              Normal = "NoicePopupNormal",
              FloatBorder = "NoicePopupFloatBorder",
            },
          },
        },
      },
      lsp = {
        progress = {
          enabled = false,
        },
        signature = {
          enabled = false,
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
    -- stylua: ignore
    -- keys = {
    --   { "<leader>sn", "", desc = "+noice"},
    --   { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    --   { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    --   { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
    --   { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
    --   { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    --   { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
    --   { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
    --   { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
    -- },
    config = function(_, opts)
      -- HACK: noice shows messages from before it was enabled,
      -- but this is not ideal when Lazy is installing plugins,
      -- so clear the messages in this case.
      if vim.o.filetype == "lazy" then
        vim.cmd [[messages clear]]
      end
      require("noice").setup(opts)
    end,
  },

  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      winopts = {
        border = "rounded",
      },
      timeout = 1,
      maxkeys = 5,
      position = "top-right",
      -- more opts
    },
  },

  {
    "snacks.nvim",
    opts = {
      -- indent = { enabled = true },
      -- input = { enabled = true },
      notifier = { enabled = true },
      -- scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = false }, -- we set this in options.lua
      -- toggle = { map = LazyVim.safe_keymap_set },
      -- words = { enabled = true },
    },
    -- stylua: ignore
    keys = {
      -- { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    },
  },
}
