-----------------------------------------------------------
-- Neovim LSP configuration file
-----------------------------------------------------------

-- Configured LSP Servers
--local servers = { 'bashls', 'pyright', 'clangd', 'html', 'tsserver', 'jsonls', 'apex-lsp' }
local lspconfig     = require "lspconfig"
local configs       = require "lspconfig.configs"
local servers       = require "nvim-lsp-installer.servers"
local server        = require "nvim-lsp-installer.server"
local path          = require "nvim-lsp-installer.core.path"
local git           = require "nvim-lsp-installer.core.managers.git"

local cmp_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_status_ok then
  return
end

-----------------------------------------------------------
-- Custom Salesforce Apex LSP Installer
-----------------------------------------------------------

local apex_lsp_name = "apex-lsp"

-- Add Apex to LSP Configs
configs[apex_lsp_name] = {
    default_config = {
        filetypes = { "apexcode" },
        root_dir = lspconfig.util.root_pattern "sfdx-project.json",
    },
}

local root_dir = server.get_server_root_path(apex_lsp_name)

local apex_lsp_server = server.Server:new {
    name = apex_lsp_name,
    root_dir = root_dir,
    homepage = "https://developer.salesforce.com/tools/vscode/en/apex/language-server",
    languages = { "apexcode" },
    installer = function(ctx)
        ctx.fs:mkdir "salesforcedx-vscode-git"
        ctx:chdir("salesforcedx-vscode-git", function()
            git.clone({ "https://github.com/forcedotcom/salesforcedx-vscode", recursive = true })
        end)
        ctx.fs:rename(
          path.concat {
            "salesforcedx-vscode-git",
            "packages",
            "salesforcedx-vscode-apex",
            "out",
          },
          "out"
        )
        ctx.fs:rmrf "salesforcedx-vscode-git"
    end,
    default_options = {
        cmd = {
            "java",
            "-cp",
            path.concat { root_dir, "out/apex-jorje-lsp.jar" },
            "-Ddebug.internal.errors=true",
            "apex.jorje.lsp.ApexLanguageServerLauncher",
        },
    },
}

servers.register(apex_lsp_server)

-----------------------------------------------------------
-- Load LSP Installer before LSP Config
-----------------------------------------------------------

require("nvim-lsp-installer").setup {}

-----------------------------------------------------------
-- Neovim LSP configuration file
-----------------------------------------------------------

-- Diagnostic options, see: `:help vim.diagnostic.config`
vim.diagnostic.config({ virtual_text = true })

-- Show line diagnostics automatically in hover window
vim.cmd([[
  autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })
]])

-- Add additional capabilities supported by nvim-cmp
-- See: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

-- TODO : Fix this, returning actually "needed 5 Arguments"
-- its a bug, or needs more stablished lua debugging

---- Use an on_attach function to only map the following keys
---- after the language server attaches to the current buffer
--local on_attach = function(client, bufnr)
--  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
--
--  -- Highlighting references
--  if client.resolved_capabilities.document_highlight then
--    vim.api.nvim_exec([[
--      augroup lsp_document_highlight
--        autocmd! * <buffer>
--        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--      augroup END
--    ]], false)
--  end
--
--  -- Enable completion triggered by <c-x><c-o>
--  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
--
--  -- Mappings.
--  local opts = { noremap = true, silent = true }
--
--  -- See `:help vim.lsp.*` for documentation on any of the below functions
--  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
--  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
--  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
--  buf_set_keymap("n", "<leader>aa", [[<cmd>lua vim.diagnostic.setqflist()<CR>]]) -- all workspace diagnostics
--  buf_set_keymap("n", "<leader>ae", [[<cmd>lua vim.diagnostic.setqflist({severity = "E"})<CR>]]) -- all workspace errors
--  buf_set_keymap("n", "<leader>aw", [[<cmd>lua vim.diagnostic.setqflist({severity = "W"})<CR>]]) -- all workspace warnings
--  buf_set_keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.setloclist()<CR>") -- buffer diagnostics only
--end

-----------------------------------------------------------
-- Language Server Configuration
-----------------------------------------------------------
local servers = { 'html', 'tsserver', 'jsonls', 'apex_ls' }

-- Call setup
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      -- default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end
