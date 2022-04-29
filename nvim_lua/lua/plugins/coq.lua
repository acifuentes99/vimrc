local lsp = require('lspconfig')
local g = vim.g

-- Settings
g.coq_settings = {
  auto_start = 'shut-up',
  display = {
    preview = {
      border = "rounded"
    },
    icons = {
      mode = 'long'
    },
    ghost_text = {
      enabled = true
    },
  },
  keymap = {
    --recommended = false,
    jump_to_mark = '<C-A-j>',
    pre_select = true,
  },
}

      --recommended = false
-- LSP Activation
-- lsp.apexcode.setup(coq.lsp_ensure_capabilities{})
local coq = require('coq')
