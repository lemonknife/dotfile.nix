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

  hl_add = {
    NoiceNormalFloat = { fg = "white", bg = "black2" },
    NoiceFloatBorder = { fg = "black2", bg = "black2" },
    NoiceCmdlineIcon = { fg = "red", bg = "black2" },

    NoicePopupNormal = { bg = "darker_black" },
    NoicePopupFloatBorder = { fg = "darker_black", bg = "darker_black" },
    NoicePopupmenuBorder = { link = "NoicePopupFloatBorder" },

    NoiceFloatTitle = { fg = "black", bg = "red" },
    NoiceCmdlinePopupTitle = { link = "NoiceFloatTitle" },
    NoiceCmdlinePopupTitleLua = { link = "NoiceCmdlinePopupTitle" },
    NoiceCmdlinePopupTitleCalculator = { link = "NoiceCmdlinePopupTitle" },
    NoiceCmdlinePopupTitleCmdline = { link = "NoiceCmdlinePopupTitle" },
    NoiceCmdlinePopupTitleFilter = { link = "NoiceCmdlinePopupTitle" },
    NoiceCmdlinePopupTitleHelp = { link = "NoiceCmdlinePopupTitle" },
    NoiceCmdlinePopupTitleIncRename = { link = "NoiceCmdlinePopupTitle" },
    NoiceCmdlinePopupTitleInput = { link = "NoiceCmdlinePopupTitle" },

    NoicePopupmenuMatch = { bg = "one_bg", fg = "blue" },
    NoicePopupmenuSelected = { bg = "black2", fg = "white" },

    BlinkCmpGhostText = { fg = "light_grey" },
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

        local icon, icon_hl = require("nvim-web-devicons").get_icon(path)
        if icon == nil then
          icon = ""
        end
        if icon_hl ~= nil then
          icon_hl = "%#" .. icon_hl .. "# "
        else
          icon_hl = ""
        end

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

        return icon_hl .. icon .. "%#Comment#" .. dir .. "%#Bold#" .. parts[#parts]
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
