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

    SnacksNotifierInfo = { fg = "white" },
    SnacksNotifierWarn = { fg = "white" },
    SnacksNotifierDebug = { fg = "white" },
    SnacksNotifierError = { fg = "white" },
    SnacksNotifierTrace = { fg = "white" },
    SnacksNotifierIconInfo = { fg = "green" },
    SnacksNotifierIconWarn = { fg = "orange" },
    SnacksNotifierIconDebug = { fg = "grey" },
    SnacksNotifierIconError = { fg = "red" },
    SnacksNotifierIconTrace = { fg = "purple" },
    SnacksNotifierTitleInfo = { fg = "green" },
    SnacksNotifierTitleWarn = { fg = "orange" },
    SnacksNotifierTitleDebug = { fg = "grey" },
    SnacksNotifierTitleError = { fg = "red" },
    SnacksNotifierTitleTrace = { fg = "purple" },
    SnacksNotifierBorderInfo = { fg = "green" },
    SnacksNotifierBorderWarn = { fg = "orange" },
    SnacksNotifierBorderDebug = { fg = "grey" },
    SnacksNotifierBorderError = { fg = "red" },
    SnacksNotifierBorderTrace = { fg = "purple" },
    SnacksNotifierFooterInfo = { fg = "green" },
    SnacksNotifierFooterWarn = { fg = "orange" },
    SnacksNotifierFooterDebug = { fg = "grey" },
    SnacksNotifierFooterError = { fg = "red" },
    SnacksNotifierFooterTrace = { fg = "purple" },
    SnacksIndent = { fg = "line" },
    SnacksIndentScope = { fg = "grey" },

    TabuflineOffSet = { fg = "blue", bg = "darker_black", bold = true, italic = true },
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

        return icon_hl .. icon .. "%#Comment#" .. dir .. "%#@markup.strong#" .. parts[#parts]
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
  tabufline = {
    order = { "offSets", "buffers", "tabs", "btns" },
    modules = {
      offSets = function()
        local function getNvimTreeWidth()
          for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.bo[vim.api.nvim_win_get_buf(win)].ft == "NvimTree" then
              return vim.api.nvim_win_get_width(win) + 1
            end
          end
          return 0
        end
        local function addPadding(str, length)
          local padding = length - #str
          if padding < 0 then
            return string.rep(" ", length)
          end
          return string.rep(" ", math.floor(padding / 2)) .. str .. string.rep(" ", math.ceil(padding / 2))
        end
        return "%#TabuflineOffSet#" .. addPadding("Nvim Tree", getNvimTreeWidth())
      end,
    },
  },
}

M.lsp = {
  signature = false,
}

return M
