-- Terminal Mappings
local function term_nav(dir)
	---@param self snacks.terminal
	return function(self)
		return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
			vim.cmd.wincmd(dir)
		end)
	end
end

require("lazyvim.config").init()

return {

	{ "folke/lazy.nvim", version = "*" },
	{
		"LazyVim/LazyVim",
		priority = 10000,
		lazy = false,
		opts = {
			defaults = {
				keymaps = false,
			},
		},
		cond = true,
		version = "*",
	},

	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = function()
			---@type snacks.Config
			return {
				bigfile = { enabled = true },
				notifier = { enabled = true },
				quickfile = { enabled = true },
				words = { enabled = true },
				toggle = { map = LazyVim.safe_keymap_set },
				statuscolumn = { enabled = false }, -- we set this in options.lua
				terminal = {
					win = {
						keys = {
							nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
							nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
							nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
							nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
						},
					},
				},
				dashboard = {
					preset = {
						header = [[
	                                                                     
	       ████ ██████           █████      ██                     
	      ███████████             █████                             
	      █████████ ███████████████████ ███   ███████████   
	     █████████  ███    █████████████ █████ ██████████████   
	    █████████ ██████████ █████████ █████ █████ ████ █████   
	  ███████████ ███    ███ █████████ █████ █████ ████ █████  
	 ██████  █████████████████████ ████ █████ █████ ████ ██████ 
            ]],
						---@type snacks.dashboard.Item[]
						keys = {
							{
								icon = " ",
								key = "f",
								desc = "Find File",
								action = ":lua Snacks.dashboard.pick('files')",
							},
							{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
							{
								icon = " ",
								key = "w",
								desc = "Find Text",
								action = ":lua Snacks.dashboard.pick('live_grep')",
							},
							{
								icon = " ",
								key = "r",
								desc = "Recent Files",
								action = ":lua Snacks.dashboard.pick('oldfiles')",
							},
							{
								icon = " ",
								key = "c",
								desc = "Config",
								action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
							},
							{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
							{ icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
							{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
							{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
						},
					},
				},
			}
		end,
		keys = {
			{
				"<leader>un",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss All Notifications",
			},
		},
	},
}
