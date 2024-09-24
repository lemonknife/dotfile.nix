local function find_command()
	return { "rg", "--files", "--color", "never", "-g", "!.git" }
end

require("mappings.telescope")

local options = {
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		-- open files in the first window that is an actual file.
		-- use the current window if no other window is available.
		get_selection_window = function()
			local wins = vim.api.nvim_list_wins()
			table.insert(wins, 1, vim.api.nvim_get_current_win())
			for _, win in ipairs(wins) do
				local buf = vim.api.nvim_win_get_buf(win)
				if vim.bo[buf].buftype == "" then
					return win
				end
			end
			return 0
		end,
	},
	pickers = {
		find_files = {
			find_command = find_command,
			hidden = true,
		},
	},
}

return options
