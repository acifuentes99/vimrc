-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a comma
vim.g.mapleader = ','

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Disable arrow keys
map('', '<up>',    '<nop>')
map('', '<down>',  '<nop>')
map('', '<left>',  '<nop>')
map('', '<right>', '<nop>')

-- Map Esc to kk
map('i', 'kk', '<Esc>')

-- Clear search highlighting with <space>
map('n', '<space>', ':nohl<CR>')

-- Change split orientation
map('n', '<leader>tk', '<C-w>t<C-w>K') -- change vertical to horizontal
map('n', '<leader>th', '<C-w>t<C-w>H') -- change horizontal to vertical

-- Move around splits, and zoom
map('n', '<A-h>', '<C-w>h<C-W>_|<C-W>|')
map('n', '<A-j>', '<C-w>j<C-W>_|<C-W>|')
map('n', '<A-k>', '<C-w>k<C-W>_|<C-W>|')
map('n', '<A-l>', '<C-w>l<C-W>_|<C-W>|')

-- Move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Reload configuration without restart nvim
map('n', '<leader>r', ':so %<CR>')

-- Fast saving with <leader> and s
map('n', '<leader>s', ':w<CR>')
map('i', '<leader>s', '<C-c>:w<CR>')

-- Close all windows and exit from Neovim with <leader> and q
map('n', '<leader>q', ':qa!<CR>')

-- Tab and Buffer management
map('n', '<A-t>',        ':TabNewWithScratchBuffer<CR>')
map('n', '<A-x>',        ':close<CR>')
map('n', '<A-C-x>',      ':tabclose<CR>')
map('n', '<C-Y>',        ':bprevious<CR>')
map('n', '<C-O>',        ':bnext<CR>')
map('n', '<C-PageUp>',   'gT')
map('n', '<C-PageDown>', 'gt')
map('n', '<A-1>',        '1gt')
map('n', '<A-2>',        '2gt')
map('n', '<A-3>',        '3gt')
map('n', '<A-4>',        '4gt')
map('n', '<A-5>',        '5gt')
map('n', '<A-6>',        '6gt')
map('n', '<A-7>',        '7gt')
map('n', '<A-8>',        '8gt')
map('n', '<leader>z',    '<C-W>_|<C-W>|')  -- zoom current buffer
map('n', '<leader>=',    '<C-W>=')         -- reset zooms

-- Quickfix
map('n', '<A-C-j>', ':cn<CR>')
map('n', '<A-C-k>', ':cp<CR>')

-- Quick settings
map('n', '<leader>n', ':set invnumber<CR>') -- toggle line numbers

vim.g.mapleader = '-'

--- Filename Simplifications to Clipboard
map('n', '<leader>8', [[:let @+ = expand("%")<CR>]])      -- Copy absolute path to clipboard
map('n', '<leader>9', [[:let @+ = expand("%:t:r")<CR>]])  -- Copy file name to clipboard
map('n', '<leader>0', [[:echo @%<CR>]])                   -- Print file path

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Visual Selection Search
map('v', '*', ":<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>")
map('v', '#', ":<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>")

-- Terminal mappings
map('n', '<C-t>', ':Term<CR>', { noremap = true })  -- open
map('t', '<Esc>', '<C-\\><C-n>')                    -- exit

-- NvimTree
map('n', '<leader>t', ':NvimTreeToggle<CR>')            -- open/close
map('n', '<leader>f', ':NvimTreeRefresh<CR>')       -- refresh
map('n', '<A-e>',     ':NvimTreeFindFile<CR>')      -- search file

-- Tagbar
map('n', '<leader>z', ':TagbarToggle<CR>')          -- open/close

---- Vim clap - Fuzzy Search
--map('n',   '<A-p>',   ':Clap files<CR>')
--map('n',   '<leader>h',   ':Clap history<CR>')
--map('n',   '<A-b>',   ':Clap buffers<CR>')
--map('n',   '<A-w>',   ':Clap windows<CR>')
--map('n',   '<A-f>',   ':Clap grep<CR>')
--map('n',   '<A-C-f>', ':GFiles?<CR>')
--map('n',   '<A-c>',   ':Clap command<CR>')
--map('n',   '<A-y>',   ':Clap yanks<CR>')
--map('n',   '<A-q>',   ':Clap quickfix<CR>')
--map('n',   '<A-m>',   ':Clap maps<CR>')
-- Vim clap - Fuzzy Search
map('n', '<A-p>',   ':Files<CR>')
--map('n', '<A-h>',   ':History<CR>')
map('n', '<A-b>',   ':Buffers<CR>')
map('n', '<A-w>',   ':Windows<CR>')
map('n', '<A-f>',   ':Rg<CR>')
map('n', '<A-C-f>', ':GFiles?<CR>')
map('n', '<A-c>',   ':Commands<CR>')
map('n', '<A-y>',   ':Clap yanks<CR>')
map('n', '<A-q>',   ':Clap quickfix<CR>')
map('n', '<A-m>',   ':Maps<CR>')

-- LSP mappings
-- ** On file "nvim-lspconfig.lua" **

-- Example mappings for usage with nvim-dap. If you don't use that, you can skip these
map("n",   "<leader>dc",  [[<cmd>lua require"dap".continue()<CR>]])
map("n",   "<leader>dr",  [[<cmd>lua require"dap".repl.toggle()<CR>]])
map("n",   "<leader>dK",  [[<cmd>lua require"dap.ui.widgets".hover()<CR>]])
map("n",   "<leader>dt",  [[<cmd>lua require"dap".toggle_breakpoint()<CR>]])
map("n",   "<leader>dso", [[<cmd>lua require"dap".step_over()<CR>]])
map("n",   "<leader>dsi", [[<cmd>lua require"dap".step_into()<CR>]])
map("n",   "<leader>dl",  [[<cmd>lua require"dap".run_last()<CR>]])

-- Vimux
map("n",   "<Leader>p",   [[:call VimuxRunCommand("sfdx force:source:legacy:push")<CR>]])
--map("n", "<Leader>o",   [[:call VimuxRunCommand(open_org_command)<CR>]])

-- Vim LSP
-- TODO : Temporal Keybindings
-- Will stay, as TODO of nvim-lsp is not resolved
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
