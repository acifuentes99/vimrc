require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")
local navic = require("nvim-navic")
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lsp_utils = require("core/lsp-utils")
mason_lspconfig.setup()

-----------------------------------------
-- LSP SPECIFIC LANGUAGE CONFIGURATION
-----------------------------------------
-- lsp_utils.set_ts_codes_ignores({})

vim.lsp.config("*", {
  capabilities = {capabilities, vim.lsp.protocol.make_client_capabilities()},
})

-- vim.lsp.config("ts_ls", {
--   handlers = {
--     ['textDocument/publishDiagnostics'] = lsp_utils.filter_tsserver_diagnostics
--   }
-- })

-- vim.lsp.config()

-----------------------------------------
-- PLUGIN INTEGRATIONS WITH LSP
-----------------------------------------
local on_attach_navic = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    if client then
      on_attach_navic(client, bufnr)
    end
  end
})

vim.lsp.handlers["textDocument/references"] = vim.lsp.with(
  vim.lsp.handlers.references, {
    on_result = function(err, result, ctx, config)
      if err then return end
      require("fzf-lua").lsp_references({
        results = result,
        uri = ctx.uri,
        bufnr = vim.uri_to_bufnr(ctx.uri)
      })
    end
  }
)
