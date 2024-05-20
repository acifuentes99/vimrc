local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'                       -- Enable mouse support
opt.clipboard = 'unnamedplus'         -- Copy/paste to system clipboard
opt.swapfile = false                  -- Don't use swapfile
opt.completeopt = 'menuone,noselect'  -- Autocomplete options

-----------------------------------------------------------                                    21 -- Neovim UI
-----------------------------------------------------------
opt.number = true           -- Show line number
opt.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
opt.ignorecase = true       -- Ignore case letters when search
opt.smartcase = true        -- Ignore lowercase for the whole pattern
opt.linebreak = true        -- Wrap on word boundary
--opt.termguicolors = true    -- Enable 24-bit RGB colors
opt.laststatus = 3            -- Set global statusline
--opt.laststatus = 2            -- Set global statusline
opt.signcolumn = 'number'            -- Set global statusline

-----------------------------------------------------------
-- Tabs, indent, breakindent
-----------------------------------------------------------
opt.expandtab = true            -- Use spaces instead of tabs
opt.shiftwidth = 4              -- Shift 4 spaces when tab
opt.tabstop = 4                 -- 1 tab == 4 spaces
opt.smartindent = true          -- Autoindent new lines
opt.breakindent = true          -- indent for breaklines
opt.breakindentopt = 'shift:2'  -- set a space of 2, next line of breakident                   46
opt.showbreak = '↳'             -- Character before breaklines

----------------------------------------------------------
-- Memory, CPU
----------------------------------------------------------
opt.hidden = true           -- Enable background buffers
opt.history = 100           -- Remember N lines in history
opt.lazyredraw = true       -- Faster scrolling
opt.synmaxcol = 240         -- Max column for syntax highlight
opt.updatetime = 250        -- ms to wait for trigger an event

opt.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
