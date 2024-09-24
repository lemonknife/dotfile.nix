-- Copyied from LazyVim
local lazy_utils = require("lazy.core.util")

local M = {}

M.spec = { "lsp", { ".git", "lua" }, "cwd" }

M.detectors = {}

function M.detectors.cwd()
	return { vim.uv.cwd() }
end

function M.get_clients(opts)
	local ret = {}
	if vim.lsp.get_clients then
		ret = vim.lsp.get_clients(opts)
	else
		ret = vim.lsp.get_active_clients(opts)
		if opts and opts.method then
			ret = vim.tbl_filter(function(client)
				return client.supports_method(opts.method, { bufnr = opts.bufnr })
			end, ret)
		end
	end
	return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

function M.detectors.lsp(buf)
	local bufpath = M.bufpath(buf)
	if not bufpath then
		return {}
	end
	local roots = {}
	for _, client in pairs(M.get_clients({ bufnr = buf })) do
		local workspace = client.config.workspace_folders
		for _, ws in pairs(workspace or {}) do
			roots[#roots + 1] = vim.uri_to_fname(ws.uri)
		end
		if client.root_dir then
			roots[#roots + 1] = client.root_dir
		end
	end
	return vim.tbl_filter(function(path)
		path = lazy_utils.norm(path)
		return path and bufpath:find(path, 1, true) == 1
	end, roots)
end

function M.detectors.pattern(buf, patterns)
	patterns = type(patterns) == "string" and { patterns } or patterns
	local path = M.bufpath(buf) or vim.uv.cwd()
	local pattern = vim.fs.find(function(name)
		for _, p in ipairs(patterns) do
			if name == p then
				return true
			end
			if p:sub(1, 1) == "*" and name:find(vim.pesc(p:sub(2)) .. "$") then
				return true
			end
		end
		return false
	end, { path = path, upward = true })[1]
	return pattern and { vim.fs.dirname(pattern) } or {}
end

function M.bufpath(buf)
	return M.realpath(vim.api.nvim_buf_get_name(assert(buf)))
end

function M.cwd()
	return M.realpath(vim.uv.cwd()) or ""
end
function M.realpath(path)
	if path == "" or path == nil then
		return nil
	end
	path = vim.uv.fs_realpath(path) or path
	return lazy_utils.norm(path)
end

function M.detect(opts)
	opts = opts or {}
	opts.spec = opts.spec or type(vim.g.root_spec) == "table" and vim.g.root_spec or M.spec
	opts.buf = (opts.buf == nil or opts.buf == 0) and vim.api.nvim_get_current_buf() or opts.buf

	local ret = {}
	for _, spec in ipairs(opts.spec) do
		local paths = M.resolve(spec)(opts.buf)
		paths = paths or {}
		paths = type(paths) == "table" and paths or { paths }
		local roots = {}
		for _, p in ipairs(paths) do
			local pp = M.realpath(p)
			if pp and not vim.tbl_contains(roots, pp) then
				roots[#roots + 1] = pp
			end
		end
		table.sort(roots, function(a, b)
			return #a > #b
		end)
		if #roots > 0 then
			ret[#ret + 1] = { spec = spec, paths = roots }
			if opts.all == false then
				break
			end
		end
	end
	return ret
end

function M.resolve(spec)
	if M.detectors[spec] then
		return M.detectors[spec]
	elseif type(spec) == "function" then
		return spec
	end
	return function(buf)
		return M.detectors.pattern(buf, spec)
	end
end

-- deleted the check of normalize
function M.get(opts)
	opts = opts or {}
	local buf = opts.buf or vim.api.nvim_get_current_buf()
	local ret = M.cache[buf]
	if not ret then
		local roots = M.detect({ all = false, buf = buf })
		ret = roots[1] and roots[1].paths[1] or vim.uv.cwd()
		M.cache[buf] = ret
	end
	return ret
end

M.cache = {}

-- Comments from LazyVim:
-- FIX: doesn't properly clear cache in neo-tree `set_root` (which should happen presumably on `DirChanged`),
-- probably because the event is triggered in the neo-tree buffer, therefore add `BufEnter`
-- Maybe this is too frequent on `BufEnter` and something else should be done instead??
vim.api.nvim_create_autocmd({ "LspAttach", "BufWritePost", "DirChanged", "BufEnter" }, {
	group = vim.api.nvim_create_augroup("lazyvim_root_cache", { clear = true }),
	callback = function(event)
		M.cache[event.buf] = nil
	end,
})

return M
