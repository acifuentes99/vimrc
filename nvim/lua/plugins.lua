local utils = require("utils")
local themes = {
    { 'gruvbox-community/gruvbox' },
}
 
local plugins = {
    ["obsidian"] = { "epwalsh/obsidian.nvim",
        dependencies = { "nvim-cmp" },
        lazy = true,
        ft = "markdown",
        event = {
            "BufReadPre /storage/emulated/0/Notes/**/**.md",
            "BufNewFile /storage/emulated/0/Notes/**/**.md",
        },
        config = function() require("pluginsconfig/obsidian").setConfig() end,
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = "/storage/emulated/0/Notes"
                }
            }
        }
    },
    ["autosession"] = { 'rmagatti/auto-session',
        name = "autosession",
        config = function()
            require("auto-session").setup {
                log_level = "error",
                --auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
                auto_session_suppress_dirs = { "~/", "~/Downloads", "/"},
            }
        end
    },
    ["vim-markdown-syntax"] = { "preservim/vim-markdown",
        ft = "markdown",
        config = function() vim.g.vim_markdown_folding_disabled = 1 end,
    },
    ["vimux"] = { 'preservim/vimux' },
    ["tmux"] = { "aserowy/tmux.nvim",
        config = function() require("pluginsconfig/nvim-tmux") end,
    },
    ["nvimtree"] = { "nvim-tree/nvim-tree.lua",
        -- lazy = true,
        dependencies = { 'kyazdani42/nvim-web-devicons', 'RRethy/nvim-base16'},
        config = function() require("pluginsconfig/nvim-tree") end
    },
    ["fzflua"]   = { "ibhagwan/fzf-lua" },
    ["marks"]    = { "chentoast/marks.nvim",
        --event = "InsertEnter",
        config = function() require("pluginsconfig/marks") end, },
    ["gitsigns"] = { 'lewis6991/gitsigns.nvim',-- Git labels
        dependencies = { 'nvim-lua/plenary.nvim' },
        --cond     = utils.isNotVimNotesEnabled,
        config   = function() require('pluginsconfig/gitsigns') end
    },
    ["nvim-cmp"] = { event = "InsertEnter", 'hrsh7th/nvim-cmp',
        name = "nvim-cmp",
        dependencies = {
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip',
            'nvim-lua/plenary.nvim',
            'L3MON4D3/LuaSnip'
        },
        config = function() require("pluginsconfig/nvim-cmp") end,
    },
    ["mason"] = { 'williamboman/mason.nvim',
        name = "mason",
        config = function() require('mason').setup() end,
    },
    ["mason-lspconfig"] = { 'williamboman/mason-lspconfig.nvim',
        name = "mason-lspconfig",
        dependencies = {
            'mason',
        },
        config = function() require('mason-lspconfig').setup {
            ensure_installed = { "apex_ls" }
        } end,
    },
    ["lspconfig"] = { 'neovim/nvim-lspconfig',
        name = "lspconfig",
        dependencies = {
            'mason-lspconfig',
        }
    },
    ["luasnip"] = { 'L3MON4D3/LuaSnip', }, -- Autocompletion & snippets,
    ["spectre"] = { 'nvim-pack/nvim-spectre',
        lazy = true,
        config = function() require('pluginsconfig/spectre').setConfig() end,
    },
    ["aerial"] = { 'stevearc/aerial.nvim',
        event = { "BufNewFile","BufRead" },
        config = function() require('pluginsconfig/aerial') end,
    },
    ["satellite"] = { 'lewis6991/satellite.nvim',
        config = function() require('satellite').setup() end,
    },
    ["lualine"] = { 'nvim-lualine/lualine.nvim', ---- Statusbar
        requires   = { 'kyazdani42/nvim-web-devicons', 'RRethy/nvim-base16' },
        config = function() require("pluginsconfig/lualine") end
    },
    ["gitblame"] = { 'f-person/git-blame.nvim',
        event = {"BufNewFile","BufRead"},
        config = function() require('pluginsconfig/git-blame') end,
        --other option: f-person/git-blame.nvim , great perfomance, but very fast that could be annoying
    },
    ["highlighter"] = { 'azabiong/vim-highlighter',
        event = {"BufNewFile","BufRead"},
        --other option: f-person/git-blame.nvim , great perfomance, but very fast that could be annoying
    },
    ["focus"] = { 'nvim-focus/focus.nvim',
        event = {"BufNewFile","BufRead"},
        config = function() require('pluginsconfig/focus') end,
    },
    ["comment"] = { 'numToStr/Comment.nvim',
        config = function() require('pluginsconfig/comment') end,
    },
    -- ["nvim-http"] = { 'BlackLight/nvim-http',
    ["rest-nvim"] = { 'rest-nvim/rest.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function() require('pluginsconfig/rest-nvim') end,
        event = {
            "BufReadPre **/**.http",
            "BufNewFile **/**.http",
        },
    },
    ["text-case"] = { 'johmsalas/text-case.nvim',
        event = {"BufNewFile","BufRead"},
    },
 
}
 
local tablet = {"nvim-cmp", "highstr", "nvimtree", "fzflua", "marks", "vim-markdown-syntax", "obsidian"}
local mac = {
    "aerial",
    "autosession",
    "comment",
    "focus",
    "fzflua",
    "gitblame",
    "gitsigns",
    "highlighter",
    "lspconfig",
    "lualine",
    "marks",
    "mason",
    "mason-lspconfig",
    "nvim-cmp",
    "nvimtree",
    "obsidian",
    "rest-nvim",
    "satellite",
    "spectre",
    "text-case",
    "tmux",
    "vim-markdown-syntax",
    "vimux",
}
 
local pluginList = {}
local tabletPlugins = utils.filterTableByKeys(plugins, mac)
utils.tableMerge(pluginList, themes, tabletPlugins)
 
return pluginList
