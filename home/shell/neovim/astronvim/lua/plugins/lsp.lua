return {

  { import = "astrocommunity.recipes.astrolsp-no-insert-inlay-hints" },

  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(plugin, opts)
      opts.servers = opts.servers or {}
      vim.list_extend(opts.servers, {
        "lua_ls",
        "nixd",
        "clangd",
        "basedpyright",
        "ruff"
      })
      opts.formatting = { format_on_save = false }
    end
  },

}
