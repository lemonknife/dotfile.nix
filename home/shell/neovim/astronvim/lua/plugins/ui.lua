return {
  {
    "folke/tokyonight.nvim",
    specs = {
      "AstroNvim/astroui",
      ---@type AstroUIOpts
      opts = {
        colorscheme = "tokyonight-moon",
      },
    },
  },

  { import = "astrocommunity.recipes.heirline-nvchad-statusline" },

  { import = "astrocommunity.utility.noice-nvim" },

  {
    "hrsh7th/nvim-cmp",
    dependencies = { "onsails/lspkind.nvim" },

    opts = function(_, opts)
      local cmp = require "cmp"
      local colors = require("tokyonight.colors").setup()
      local lspkind = require "lspkind"
      local lspkind_opts = {
        mode = "symbol_text",
        symbol_map = {
          Namespace = "󰌗",
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰆧",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈚",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "󰊄",
          Table = "",
          Object = "󰅩",
          Tag = "",
          Array = "[]",
          Boolean = "",
          Number = "",
          Null = "󰟢",
          Supermaven = "",
          String = "󰉿",
          Calendar = "",
          Watch = "󰥔",
          Package = "",
          Copilot = "",
          Codeium = "",
          TabNine = "",
        },
      }
      vim.api.nvim_set_hl(0, "CmpNormalBorder", { fg = colors.border_highlight, bg = colors.bg })
      lspkind.init(lspkind_opts)
      opts.formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(entry, vim_item)
          vim_item.kind = lspkind.symbolic(vim_item.kind, lspkind_opts)
          -- Disable menu:
          -- vim_item.menu = ""
          if lspkind_opts.menu ~= nil then
            vim_item.menu = (lspkind_opts.menu[entry.source.name] ~= nil and lspkind_opts.menu[entry.source.name] or "")
              .. ((lspkind_opts.show_labelDetails and vim_item.menu ~= nil) and vim_item.menu or "")
          end
          return vim_item
        end,
      }
      opts.window = {
        completion = cmp.config.window.bordered {
          maxwidth = 30,
          side_padding = 0,
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          winhighlight = "Normal:Normal,FloatBorder:CmpNormalBorder,CursorLine:PmenuSel,Search:None",
          scrollbar = false,
        },
      }
    end,
  },
}
