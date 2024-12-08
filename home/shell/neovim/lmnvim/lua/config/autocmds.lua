local autocmd = vim.api.nvim_create_autocmd

local buflist_cache = {}
local get_bufs = function()
	return vim.tbl_filter(function(bufnr)
		return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
	end, vim.api.nvim_list_bufs())
end

autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete" }, {
	callback = function()
		vim.schedule(function()
			local buffers = get_bufs()
			for i, v in ipairs(buffers) do
				buflist_cache[i] = v
			end
			for i = #buffers + 1, #buflist_cache do
				buflist_cache[i] = nil
			end

			-- check how many buffers we have and set showtabline accordingly
			if #buflist_cache > 1 then
				vim.o.showtabline = 2 -- always
			elseif vim.o.showtabline ~= 1 then -- don't reset the option if it's already at default value
				vim.o.showtabline = 1 -- only when #tabpages > 1
			end
		end)
	end,
})
