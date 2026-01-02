------------------------------------
-- FILTER DIAGNOSTICS
------------------------------------
local M = {
	ts_codes_to_ignore = nil,
}

M.set_ts_codes_to_ignore = function(codes_to_ignore)
	M.ts_codes_to_ignore = codes_to_ignore or {2305,2307,7045,7044}
end

M.filter_diagnostics = function(diagnostics,)
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

------------------------------------
-- DIAGNOSTICS MESSAGE IN LUALINE
------------------------------------

M.diagnostics_message = function()
  local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
  local diagnostics = vim.diagnostic.get(0, { lnum = lnum })

  if #diagnostics > 0 then
    local diag = diagnostics[1]
    for _, d in ipairs(diagnostics) do
      if d.severity < diag.severity then
        diag = d
      end
    end

    local icons = {'󰅙 ',' ','󰋼 ',' '}
    local severity_map = {
      [vim.diagnostic.severity.ERROR] = 1,
      [vim.diagnostic.severity.WARN] = 2,
      [vim.diagnostic.severity.INFO] = 3,
      [vim.diagnostic.severity.HINT] = 4,
    }
    local serverity_index = severity_map[diag.severity] or 4

    local hl_group = "LspDiagnosticDefault" .. vim.diagnostic.severity[diag.severity]:gsub("*-", function(c) return c:upper() end)
    return "%#" .. hl_group .. "#" .. icons[serverity_index] .. "" .. diag.message .. "%*"
  else
    return ""
  end
end

------------------------------------
-- RETURN
------------------------------------
return M
