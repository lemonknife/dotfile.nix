-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

local lazy_options = require("config.lazy")

-- load plugins
require("lazy").setup({
	{
		"LazyVim/LazyVim",
	},

	{ import = "plugins" },
	-- { import = "extras" },
}, lazy_options)

-- require("config")
-- require("autocmds")

-- vim.schedule(function()
-- require("mappings")
-- end)
