-- load defaults i.e lua_lsp
dofile(vim.g.base46_cache .. "lsp")
require("nvchad.lsp").diagnostic_config()

local lspconfig = require "lspconfig"
local map = vim.keymap.set

local servers = { "html", "cssls", "clangd", "nixd", "pylsp" }
local nvlsp = require "nvchad.configs.lspconfig"
local custom_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end
  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", "gr", vim.lsp.buf.references, opts "Show references")

  map("n", "<leader>lr", function()
    require "nvchad.lsp.renamer"()
  end, opts "NvRenamer")
  map("n", "<leader>ls", vim.lsp.buf.signature_help, opts "Show signature help")

  map("n", "<leader>lw", "", opts "Workspace")
  map("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>lwl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<leader>lD", vim.lsp.buf.type_definition, opts "Go to type definition")
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
