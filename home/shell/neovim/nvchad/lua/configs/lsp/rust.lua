return {
  ["rust-analyzer"] = {
    cargo = {
      allFeatures = true,
      loadOutDirsFromCheck = true,
      buildScripts = {
        enable = true,
      },
    },
    checkOnSave = true,
    procMacro = {
      enable = true,
      ignored = {
        ["async-trait"] = { "async_trait" },
        ["napi-derive"] = { "napi" },
        ["async-recursion"] = { "async_recursion" },
      },
    },
    diagnostics = {
      enable = true,
    },
    files = {
      excludeDirs = {
        ".direnv",
        ".git",
        ".github",
        ".gitlab",
        "bin",
        "node_modules",
        "target",
        "venv",
        ".venv",
      },
    },
  },
}
