local M = {}

M.on_attach = function(client, bufnr)
  local map = vim.keymap.set
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

  if client.server_capabilities.inlayHintProvider then
    local inlay_hints_group = vim.api.nvim_create_augroup("InlayHints", { clear = false })

    local mode = vim.api.nvim_get_mode().mode
    vim.lsp.inlay_hint.enable(mode == "n" or mode == "v", { bufnr = bufnr })

    vim.api.nvim_create_autocmd("InsertEnter", {
      group = inlay_hints_group,
      buffer = bufnr,
      callback = function()
        vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
      end,
    })
    vim.api.nvim_create_autocmd("InsertLeave", {
      group = inlay_hints_group,
      buffer = bufnr,
      callback = function()
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end,
    })
  end
end

return M
