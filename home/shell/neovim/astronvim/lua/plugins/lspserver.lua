return {

  "AstroNvim/astrolsp",
  opts = function(plugin, opts)
    opts.config = {
      lua_ls = { settings = { Lua = { hint = { enable = true, arrayIndex = "Disable" } } } },
      clangd = { cmd = { "clangd", "--clang-tidy" }, capabilities = { offsetEncoding = "utf-8" } },
      basedpyright = { settings = { disableOrganizeImports = true, analysis = { ignore = { "*" } } } },
    }
  end,
}
