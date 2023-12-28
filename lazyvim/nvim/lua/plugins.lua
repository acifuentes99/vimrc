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
    ["vim-markdown-syntax"] = { "preservim/vim-markdown",
        config = function() vim.g.vim_markdown_folding_disabled = 1 end,
    },
    ["highstr"]  = { "pocco81/high-str.nvim" },
    ["nvimtree"] = { "nvim-tree/nvim-tree.lua",
        dependencies = { 'kyazdani42/nvim-web-devicons', 'RRethy/nvim-base16'},
        --config = function() require("pluginsconfig/nvim-tree").setConfig() end 
    },
    ["fzflua"]   = { "ibhagwan/fzf-lua" },
    ["marks"]    = { event = "InsertEnter", "chentoast/marks.nvim", 
        -- marks in code, for jumping
        config = function() require("pluginsconfig/marks") end, },
    --["nvim-cmp-buffer"]  = { "hrsh7th/cmp-buffer" },
    ["nvim-cmp"] = { event = "InsertEnter", 'hrsh7th/nvim-cmp',
        -- Autocomplete with tab (not working on tablet... dont know why
        -- lazy = true,
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
    --["luasnip"] = { 'L3MON4D3/LuaSnip', }, -- Autocompletion & snippets
}

local tablet = {"nvim-cmp", "highstr", "nvimtree", "fzflua", "marks", "vim-markdown-syntax", "obsidian"}

local pluginList = {}
local tabletPlugins = utils.filterTableByKeys(plugins, tablet)
utils.tableMerge(pluginList, themes, tabletPlugins)

return pluginList
