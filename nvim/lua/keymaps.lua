local map = require("utils").mapKey

-- Disable arrow keys
map('', '<up>',    '<nop>')
map('', '<down>',  '<nop>')
map('', '<left>',  '<nop>')
map('', '<right>', '<nop>')

-- Map Esc to kk
map('i', 'kk', '<Esc>')

-- Clear search highlighting with <space>
map('n', '<space>', ':nohl<CR>')

-----------------------------------------------------------
---  CONTROL KEY ( C )
-----------------------------------------------------------

-- Close opened window
map('n', '<C-q>',        ':close<CR>')

-- Move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h<CR>')
map('n', '<C-j>', '<C-w>j<CR>')
map('n', '<C-k>', '<C-w>k<CR>')
map('n', '<C-l>', '<C-w>l<CR>')


map('n', '<C-d>', '<C-d>zz')        -- Mapping to C-d and C-u, center line on window
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzz')                -- Highlight searchs
map('n', 'N', 'Nzz')

-----------------------------------------------------------
--- OPTION/ALT KEY ( M
-----------------------------------------------------------

-- Quickfix
map('n', '<M-j>', ':cn<CR>')
map('n', '<M-k>', ':cp<CR>')

-----------------------------------------------------------
--- SIDEBAR
-----------------------------------------------------------
map('n', '-S', ':lua require("core/callables").toggle_sidebar()<CR>')

-----------------------------------------------------------
--- LEADER " , "
-----------------------------------------------------------

-- Fzf Lua - Fuzzy Search
map('n', ',p',   ':FzfLua files resume=true<CR>')
map('n', ',h',   ':FzfLua oldfiles resume=true<CR>')
map('n', ',b',   ':FzfLua buffers resume=true<CR>')
map('n', ',w',   ':FzfLua tabs<CR>')
map('n', ',s',   ':SessionManager load_session<CR>')
-- map('n', ',f',   ':FzfLua grep_project resume=true<CR>')
map('n', ',f',   ':FzfLua live_grep_glob resume=true<CR>')
map('n', ',g',   ':FzfLua git_status resume=true<CR>')
map('n', ',c',   ':FzfLua command_history resume=true<CR>')
map('n', ',y',   ':FzfLua yanks<CR>')
map('n', ',q',   ':FzfLua quickfix<CR>')
map('n', ',k',   ':luafile /Users/C305249/Repositories/nvim-jump-to-mark/nvim-jump-to-mark.lua<CR>')
map('n', ',m', ':lua require("core/callables").fzf_macro_selector()<CR>')
map('n', ',l', ':lua require\'fzf-lua\'.live_grep({ cmd = "rg -l" })<CR>')

map('n', '-s',   ':SessionManager available_commands<CR>')

-- Spectre
map('n', ',r',   ':lua require("spectre").open()<CR>')
--map('n', ',s',   ':lua require("spectre").search_resume()<CR>')

-- NvimTree
map('n', ',t', ':lua require("core/callables").nvimTreeOpen()<CR>')            -- open/close
map('n', ',e',     ':NvimTreeFindFile<CR>')      -- search file
--map('n', '-f', ':NvimTreeRefresh<CR>')       -- refresh
--map('n', '-t', ':NvimTreeToggle<CR>')            -- open/close
--map('n', '<M-e>', ':lua require("core/callables").nvimTreeFindFile()<CR>')            -- open/close

-----------------------------------------------------------
--- LEADER " - "
-----------------------------------------------------------

-- Reload configuration without restart nvim
map('n', '-r', ':so %<CR>')

-- Fast saving with <leader> and s
-- map('n', '-w', ':w<CR>')
--map('i', '-s', '<C-c>:w<CR>')

--- Filename Simplifications to Clipboard
map('n', '-8', ':let @+ = expand("%")<CR>')      -- Copy absolute path to clipboard
map('n', '-9', ':let @+ = expand("%:t:r")<CR>')  -- Copy file name to clipboard
map('n', '-0', ':echo @%<CR>')                   -- Print file path

-- Change split orientation
-- map('n', '-tk', '<C-w>t<C-w>K') -- change vertical to horizontal
-- map('n', '-th', '<C-w>t<C-w>H') -- change horizontal to vertical

-- Vim Commands shortcuts
map('n', '-w',        ':windo :set wrap!<CR>')
map('n', '-o',        ':only<CR>')
map('n', '-1', '1gt')
map('n', '-2', '2gt')
map('n', '-3', '3gt')
map('n', '-4', '4gt')
map('n', '-5', '5gt')
map('n', '-6', '6gt')
map('n', '-7', '7gt')
map('n', '-t', ':tabnew<CR>')
map('n', '-x', ':tabclose<CR>')

-- GitBlame
map('n', '-b', ':GitBlameToggle<CR>')

-- Aerial
map('n', '-a', ':AerialToggle!<CR>')

-- Focus
map('n', '-f', ':FocusToggle<CR>')

-- Tagbar
map('n', '-z', ':TagbarToggle<CR>')          -- open/close

-- Vimux
--map("n",   "-p",   [[:call VimuxRunCommand("sf project deploy start --ignore-conflicts")<CR>]])
map("n",   "-p",   [[:call VimuxRunLastCommand()<CR>]])

-- Change Colorscheme
map('n', '-cl', ':call LightTheme()<CR>')
map('n', '-cd', ':call DarkTheme()<CR>')

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Visual Selection Search
map('v', '*', ":<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>")
map('v', '#', ":<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>")

-- LSP mappings
-- ** On file "nvim-lspconfig.lua" **
map('n', 'gs',   '<Plug>(leap-cross-window)')
map('n', 's',   '<Plug>(leap-forward-to)')
map('n', 'S',   '<Plug>(leap-backward-to)')

-- Example mappings for usage with nvim-dap. If you don't use that, you can skip these
map("n",   "-dc",  [[<cmd>lua require"dap".continue()<CR>]])
map("n",   "-dr",  [[<cmd>lua require"dap".repl.toggle()<CR>]])
map("n",   "-dK",  [[<cmd>lua require"dap.ui.widgets".hover()<CR>]])
map("n",   "-dt",  [[<cmd>lua require"dap".toggle_breakpoint()<CR>]])
map("n",   "-dso", [[<cmd>lua require"dap".step_over()<CR>]])
map("n",   "-dsi", [[<cmd>lua require"dap".step_into()<CR>]])
map("n",   "-dl",  [[<cmd>lua require"dap".run_last()<CR>]])

-- Vim LSP
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')

-- SpellChecker
map('i', '<F7>', '1z=')
map('i', '<F8>', ']s')
map('i', '<F9>', '[s')
map('n', '<F7>', '1z=')
map('n', '<F8>', ']s')
map('n', '<F9>', '[s')
map('n', '<F20>', '1z=')
map('n', '<F21>', ']s')
map('n', '<F22>', '[s')
map('n', '<F5>', ':setlocal spell! spelllang=en,es<CR>')
