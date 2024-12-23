vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

local options = {
  formatters = {
    stylua = {
      prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    },
    rustfmt = {
      prepend_args = { "--config", "imports_granularity=Module,group_imports=StdExternalCrate" },
    },
  },

  formatters_by_ft = {
    lua = { "stylua" },
    cpp = { "clang-format" },
    c = { "clang-format" },
    nix = { "nixfmt" },
    python = { "ruff_organize_imports", "ruff_format" },
    rust = { "rustfmt" },
    java = { "google-java-format" },
  },

  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
}

return options
