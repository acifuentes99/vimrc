local M = {
	ts_codes_to_ignore = nil,
}

M.set_ts_codes_to_ignore = function(diagnostics, codes_to_ignore)
	M.ts_codes_to_ignore = codes_to_ignore or {2305,2307,7045,7044}
end

M.filter_diagnostics = function(diagnostics, codes_to_ignore)
	local filtered = {}
	local ignore = {}
	for _, code in ipairs(M.ts_codes_to_ignore) do 
		ignore[code] = true
	end
	for _, diagnostic in ipairs(diagnostics) do 
		if not ignore[diagnostic.code] then
			table.insert(filtered, diagnostic)
		end
	end
	return filtered
end

M.filter_tsserver_diagnostics = function(_, result, ctx, config)
	if result and result.diagnostics then
		result.diagnostics = M.filter_diagnostics(result.diagnostics, M.ts_codes_to_ignore)
	end
	return vim.lsp.handlers["textDocument/publishDiagnostics"](_, result, ctx, config)
end

return M
