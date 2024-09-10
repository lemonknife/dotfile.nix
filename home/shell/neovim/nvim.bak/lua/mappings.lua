local map = vim.keymap.set
local delmap = vim.keymap.del

---@param mode string|string[] Mode short-name, see |nvim_set_keymap()|.
---@param lhs string Left-hand side |{lhs}| of the unmapping.
local function unmap(mode, lhs)
  map(mode, lhs, "")
end

---@param mode string|string[] Mode short-name, see |nvim_set_keymap()|.
---@param lhs string           Left-hand side |{lhs}| of the mapping.
---@param rhs string           Right-hand side |{rhs}| of the mapping, cannot be a Lua function.
---@param opts? vim.keymap.set.Opts
---@see |nvim_set_keymap()|
---@see |maparg()|
---@see |mapcheck()|
---@see |mapset()|
local function remap(mode, lhs, rhs, opts)
  map(mode, lhs, rhs, opts)
  unmap(mode, rhs)
end

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General Clear highlights" })

map("n", "<leader>s", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>Q", "<cmd>q!<CR>", { desc = "Force quit" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "General Copy whole file" })

-- map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle line number" })
-- map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Toggle relative number" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "Toggle nvcheatsheet" })

-- LSP
map("n", "<leader>l", "", { desc = "LSP" })
map("n", "<leader>lf", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "LSP Format file" })

-- global lsp mappings
map("n", "<leader>ll", vim.diagnostic.setloclist, { desc = "LSP Diagnostic loclist" })

-- tabufline
map("n", "<leader>b", "", { desc = "Buffer" })

map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "buffer new" })

map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>bx", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "Toggle Comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- Telescope
map("n", "<leader>f", "", { desc = "Telescope" })

map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
-- map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "telescope nvchad themes" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

-- Terminal
map("n", "<leader>t", "", { desc = "Terminal" })

-- new terminals
map("n", "<leader>th", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })

map("n", "<leader>tv", function()
  require("nvchad.term").new { pos = "vsp" }
end, { desc = "terminal new vertical window" })

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
map("n", "<leader>tb", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })

-- toggleable
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal new horizontal term" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

-- Git
map("n", "<leader>g", "", { desc = "Git" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Telescope git status" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

-- blankline
map("n", "<leader>cc", function()
  local config = { scope = {} }
  config.scope.exclude = { language = {}, node_type = {} }
  config.scope.include = { node_type = {} }
  local node = require("ibl.scope").get(vim.api.nvim_get_current_buf(), config)

  if node then
    local start_row, _, end_row, _ = node:range()
    if start_row ~= end_row then
      vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start_row + 1, 0 })
      vim.api.nvim_feedkeys("_", "n", true)
    end
  end
end, { desc = "blankline jump to current context" })

map("n", ";", ":", { desc = "CMD enter command mode" })

remap("n", "<leader>-", "<c-w>s", { desc = "Split window horizontally" })
remap("n", "<leader>\\", "<c-w>v", { desc = "Split window vertically" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
