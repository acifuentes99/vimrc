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
lsp_utils.set_ts_codes_to_ignore({2305,2307,7045,7044})

vim.lsp.config("*", {
  capabilities = {capabilities, vim.lsp.protocol.make_client_capabilities()},
})

vim.lsp.config("ts_ls", {
  handlers = {
    ['textDocument/publishDiagnostics'] = lsp_utils.filter_tsserver_diagnostics
  }
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
          globals = { "vim" },
      },
      telemetry = {
          enable = false,
      },
      -- runtime = {
      --     version = "LuaJIT",
      -- },
      -- workspace = {
      --     library = vim.api.nvim_get_runtime_file("", true),
      -- },
    }
  }
})

vim.lsp.config('apex_ls', {
  apex_jar_path = vim.fn.stdpath('data') .. '/mason/share/apex-language-server/apex-jorje-lsp.jar',
  apex_enable_semantic_errors = false, -- Whether to allow Apex Language Server to surface semantic errors
  apex_enable_completion_statistics = false, -- Whether to allow Apex Language Server to collect telemetry on code completion usage
  filetypes = { 'apexcode', 'apex' },
})

vim.lsp.enable({ 'apex_ls', 'basedpyright', 'ts_ls' })

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
