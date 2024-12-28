-- load defaults i.e lua_lsp
dofile(vim.g.base46_cache .. "lsp")
require("nvchad.lsp").diagnostic_config()

local lspconfig = require "lspconfig"
local map = vim.keymap.set

local servers = { "lua_ls", "clangd", "nixd", "basedpyright", "ruff" }
local nvlsp = require "nvchad.configs.lspconfig"

local function on_attach(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end
  require("configs.lsp").on_attach(client, bufnr)
  map("n", "<leader>la", vim.lsp.buf.code_action, opts "Code action")
end

local function safe_require(module_name)
  local success, settings = pcall(require, module_name)
  if success then
    return settings
  else
    return {}
  end
end

local has_blink, blink = pcall(require, "blink.cmp")

local capabilities =
  vim.tbl_deep_extend("force", {}, nvlsp.capabilities, has_blink and blink.get_lsp_capabilities() or {})

for _, lsp in ipairs(servers) do
  local server_config = {
    on_attach = on_attach,
    on_init = nvlsp.on_init,
    capabilities = capabilities,
  }

  for k, v in pairs(safe_require("configs.lsp." .. lsp)) do
    server_config[k] = v
  end

  lspconfig[lsp].setup(server_config)
end
