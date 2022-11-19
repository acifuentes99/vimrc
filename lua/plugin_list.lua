-- vim: shiftwidth=4
local utils = require('utils')
local plugs = {

    colors = { -- Color schemes
        { 'navarasu/onedark.nvim' },
        { 'tanvirtin/monokai.nvim' },
        { 'rose-pine/neovim', as = 'rose-pine'  },
        { 'Shatur/neovim-ayu' },
        { 'gruvbox-community/gruvbox' },
        { 'RRethy/nvim-base16' },
    },

    interface = {
        { 'kyazdani42/nvim-web-devicons' }, -- Icons
        { 'goolord/alpha-nvim', -- Dashboard (start screen)
            requires = { 'kyazdani42/nvim-web-devicons' },
        },
        { 'nvim-tree/nvim-tree.lua', -- File explorer
            requires = { 'kyazdani42/nvim-web-devicons', },
            config   = function() require("plugins/nvim-tree").setConfig() end
        },
        { 'nvim-lualine/lualine.nvim', ---- Statusbar
            requires   = { 'kyazdani42/nvim-web-devicons', 'RRethy/nvim-base16'
        },
            config = function() require("interface/lualine") end
        },
        { 'lukas-reineke/indent-blankline.nvim', -- Indent line view on editor
            cond     = utils.isNotVimNotesEnabled,
            config   = function() require("plugins/indent-blankline") end
        },
        --{ 'nanozuki/tabby.nvim' }, -- Vim Tabs
        { 'chentoast/marks.nvim' }, -- Marks on line number
    },

    helpers = {
        { "nvim-lua/plenary.nvim", opt = false },
        { "mfussenegger/nvim-dap" },-- Debugger
        { 'nvim-treesitter/nvim-treesitter' }, -- Tree Sitter
        { 'junegunn/fzf' },
        { 'junegunn/fzf.vim' },
        { 'ibhagwan/fzf-lua',
            config = function() require('plugins/fzf-lua') end,
        },
        { "aserowy/tmux.nvim", cond = utils.isNotPowershell }, -- Tmux
        { 'preservim/vimux',   cond = utils.isNotPowershell },
        { 'preservim/tagbar', }, -- Tag viewer
        { 'junegunn/vim-easy-align' }, -- Easy Align
        { 'tpope/vim-surround' }, -- Surround, pair character
        { 'L3MON4D3/LuaSnip', }, -- Autocompletion & snippets
        { 'hrsh7th/nvim-cmp',
            config = function() require('plugins/nvim-cmp') end,
            requires = {
                { 'hrsh7th/cmp-path',         after = 'nvim-cmp' },
                { 'hrsh7th/cmp-buffer',       after = 'nvim-cmp' },
                { 'hrsh7th/cmp-cmdline',      after = 'nvim-cmp' },
                { 'hrsh7th/cmp-nvim-lsp',     after = 'nvim-cmp' },
                { 'hrsh7th/cmp-nvim-lua',     after = 'nvim-cmp' },
                { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
            }
        }
    },

    git = {
        { 'lewis6991/gitsigns.nvim',-- Git labels
            requires = { 'nvim-lua/plenary.nvim' },
            cond     = utils.isNotVimNotesEnabled,
            config   = function() require('plugins/gitsigns') end
        },
        { 'sindrets/diffview.nvim',-- Git Diff View (like VS Code)
            requires = { 'nvim-lua/plenary.nvim' },
            cond     = utils.isNotVimNotesEnabled
        },
    },

    ide = {
        { 'neovim/nvim-lspconfig' },-- LSP
        { 'williamboman/nvim-lsp-installer',
            config   = function() require('plugins/nvim-lsp') end,
            after    = { 'nvim-lspconfig' } },
        { 'scalameta/nvim-metals',
            requires = { 'nvim-lua/plenary.nvim', 'mfussenegger/nvim-dap' },
            config   = function() require("plugins/nvim-metals") end },
        },

    vimnotes = {
        { 'vimwiki/vimwiki',
            config = function() require('plugins/vimwiki') end,
            cond   = utils.isVimNotesEnabled
        },
    },

    newplugins = {
        { 'echasnovski/mini.nvim',
        --    config = function() require('plugins/vimwiki') end,
        },
        --{ 'rmagatti/auto-session',
        --    config = function() require('plugins/vimwiki') end,
        --},
        { 'beauwilliams/focus.nvim',
            config = function() require('focus').setup() end,
        },
        { 'c60cb859/bufMov.nvim',
        --    config = function() require('plugins/vimwiki') end,
        },
        { 'DanilaMihailov/beacon.nvim',
        --    config = function() require('plugins/vimwiki') end,
        },
        { 'Pocco81/HighStr.nvim',
        --    config = function() require('plugins/vimwiki') end,
        },
        { 'nvim-pack/nvim-spectre',
            config = function() require('plugins/spectre').setConfig() end,
        },
        { 'APZelos/blamer.nvim',
        --    config = function() require('plugins/vimwiki') end,
        },
        { 'andythigpen/nvim-coverage',
        --    config = function() require('plugins/vimwiki') end,
        },
        { 'stevearc/aerial.nvim',
        --    config = function() require('plugins/vimwiki') end,
        },
        --{ 'lewis6991/satellite.nvim', --Not working, maybe needs nightly
        --    config = function() require('satellite').setup() end,
        --},
        --{ 'https://gitlab.com/madyanov/svart.nvim', --Not working, maybe needs nightly
        --    config = function() require('satellite').setup() end,
        --},
    }
}
return plugs
