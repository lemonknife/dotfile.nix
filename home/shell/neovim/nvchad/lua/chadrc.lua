-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

local spec = {
  ["lazy"] = "Lazy",
  ["NvimTree"] = "NvimTree",
  ["noice"] = "Noice",
}

M.base46 = {
  theme = "tokyonight",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { link = "Comment" },
  },
}

M.ui = {
  telescope = { style = "borderless" },
  statusline = {
    theme = "default",
    order = { "mode", "root", "path", "git", "%=", "diagnostics", "cursor" },
    modules = {
      path = function()
        local path = vim.fn.expand "%:p"

        if path == "" or spec[vim.bo.filetype] then
          return ""
        end
        path = LazyVim.norm(path)

        local root = LazyVim.root.get { normalize = true }
        local cwd = LazyVim.root.cwd()

        if path:find(cwd, 1, true) == 1 then
          path = path:sub(#cwd + 2)
        elseif path:find(root, 1, true) == 1 then
          path = path:sub(#root + 2)
        end

        local sep = package.config:sub(1, 1)
        local parts = vim.split(path, "[\\/]")
        local length = 3

        if #parts > length then
          parts = { parts[1], "…", unpack(parts, #parts - length + 2, #parts) }
        end

        local dir = " "
        if #parts > 1 then
          dir = " " .. table.concat({ unpack(parts, 1, #parts - 1) }, sep) .. sep
        end

        return "%#Comment#" .. dir .. "%#Bold#" .. parts[#parts]
      end,
      root = function()
        local icon = "󰉋 "

        local function get()
          local root = LazyVim.root.get { normalize = true }
          local name = vim.fs.basename(root)
          return spec[vim.bo.filetype] or (icon .. name)
        end

        local sep_r = ""
        local name = " " .. get()

        name = (name:match "([^/\\]+)[/\\]*$" or name) .. " "
        return (vim.o.columns > 85 and ("%#St_cwd_text#" .. name .. "%#St_file_sep#" .. sep_r)) or ""
      end,
    },
  },
}

M.lsp = {
  signature = false,
}

return M
