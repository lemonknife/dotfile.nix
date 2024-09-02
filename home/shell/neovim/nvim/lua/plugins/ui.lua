return {
  -- HomePage
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      opts.section.header.val = {
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
      }
      return opts
    end,
  },

  -- Icon
  {
    "onsails/lspkind.nvim",
    opts = function(_, opts)
      -- use codicons preset
      opts.preset = "codicons"
      -- set some missing symbol types
      opts.symbol_map = {
        Array = "",
        Boolean = "",
        Snippet = "",
        Key = "",
        Namespace = "",
        Null = "",
        Number = "",
        Object = "",
        Package = "",
        String = "",
      }
    end,
  },

  -- StatusBar
  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.recipes.heirline-nvchad-statusline" },
  {
    "AstroNvim/astroui",
    opts = {
      -- NOTE: Use FiraCode Nerd Font to show LSPLoadng icons
      icons = {
        LSPLoading1 = "",
        LSPLoading2 = "",
        LSPLoading3 = "",
        LSPLoading4 = "",
        LSPLoading5 = "",
        LSPLoading6 = "",
      },
    },
  },

  -- Theme
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.color.twilight-nvim" },
  { import = "astrocommunity.color.modes-nvim" },
  {
    "AstroNvim/astroui",
    opts = {
      colorscheme = "tokyonight-moon",
    },
  },
}
