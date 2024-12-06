local configs = function(_, opts)
	LazyVim.lsp.on_attach(function(client, buffer)
		require("mappings.lsp").on_attach(client, buffer)
	end)

	LazyVim.lsp.setup()
	LazyVim.lsp.on_dynamic_capability(require("mappings.lsp").on_attach)
	LazyVim.lsp.words.setup(opts.document_highlight)

	if opts.inlay_hints.enabled then
		LazyVim.lsp.on_supports_method("textDocument/inlayHint", function(client, buffer)
			if
				vim.api.nvim_buf_is_valid(buffer)
				and vim.bo[buffer].buftype == ""
				and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
			then
				vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
			end
		end)
	end

	if opts.codelens.enabled and vim.lsp.codelens then
		LazyVim.lsp.on_supports_method("textDocument/codeLens", function(client, buffer)
			vim.lsp.codelens.refresh()
			vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
				buffer = buffer,
				callback = vim.lsp.codelens.refresh,
			})
		end)
	end

	if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
		opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
			or function(diagnostic)
				local icons = LazyVim.config.icons.diagnostics
				for d, icon in pairs(icons) do
					if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
						return icon
					end
				end
			end
	end

	vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

	local servers = opts.servers
	local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	local capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		has_cmp and cmp_nvim_lsp.default_capabilities() or {},
		opts.capabilities or {}
	)

	local function setup(server)
		local server_opts = vim.tbl_deep_extend("force", {
			capabilities = vim.deepcopy(capabilities),
		}, servers[server] or {})
		if server_opts.enabled == false then
			return
		end

		if opts.setup[server] then
			if opts.setup[server](server, server_opts) then
				return
			end
		elseif opts.setup["*"] then
			if opts.setup["*"](server, server_opts) then
				return
			end
		end
		require("lspconfig")[server].setup(server_opts)
	end

	for server, server_opts in pairs(servers) do
		if server_opts then
			server_opts = server_opts == true and {} or server_opts
			if server_opts.enabled ~= false then
				setup(server)
			end
		end
	end
end

return configs
