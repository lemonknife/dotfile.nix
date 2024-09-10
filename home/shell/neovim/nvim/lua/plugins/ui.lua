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

  { import = "astrocommunity.recipes.heirline-nvchad-statusline" }
}
