-- load defaults i.e lua_lsp
dofile(vim.g.base46_cache .. "lsp")
require("nvchad.lsp").diagnostic_config()

local lspconfig = require "lspconfig"
local map = vim.keymap.set

local servers = { "html", "cssls", "clangd", "nixd", "pylsp" }
local nvlsp = require "nvchad.configs.lspconfig"
local function custom_attach(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end
  require("configs.lspsetup").on_attach(client, bufnr)
  map("n", "<leader>la", vim.lsp.buf.code_action, opts "Code action")
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = custom_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.lua_ls.setup {
  on_attach = custom_attach,
  capabilities = nvlsp.capabilities,
  on_init = nvlsp.on_init,

  settings = {
    Lua = {
      hint = {
        enable = true,
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
          vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/luv/library",
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

-- configuring single server, example: typescript
-- lspconfig.tsserver.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
