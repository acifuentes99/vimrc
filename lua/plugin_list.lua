local utils = require('utils')
local plugs = {

  colors = {
    -- Color schemes
    { 'navarasu/onedark.nvim' },
    { 'tanvirtin/monokai.nvim' },
    { 'rose-pine/neovim', as = 'rose-pine'  },
    { 'Shatur/neovim-ayu' },
  },

  interface = {
    -- Icons
    { 'kyazdani42/nvim-web-devicons' },
    -- Dashboard (start screen)
    { 'goolord/alpha-nvim',
      requires = { 'kyazdani42/nvim-web-devicons' }, },
    -- File explorer
    { 'kyazdani42/nvim-tree.lua',
      requires = { 'kyazdani42/nvim-web-devicons', },
      config   = function() require("plugins/nvim-tree") end },
    -- Statusbar
    { 'feline-nvim/feline.nvim',
    requires   = { 'kyazdani42/nvim-web-devicons' }, },
    -- Indent line view on editor
    { 'lukas-reineke/indent-blankline.nvim',
      cond     = utils.isNotVimNotesEnabled,
      config   = function() require("plugins/indent-blankline") end },
    -- Vim Tabs
    { 'nanozuki/tabby.nvim' },
    -- Marks on line number
    { 'chentoast/marks.nvim' },
  },

  helpers = {
    { "nvim-lua/plenary.nvim", opt = false },
    -- Debugger
    { "mfussenegger/nvim-dap" },
    -- Tree Sitter
    { 'nvim-treesitter/nvim-treesitter' },
    -- Fuzzy find
    { 'liuchengxu/vim-clap' },
    { 'junegunn/fzf' },
    { 'junegunn/fzf.vim' },
    -- Tmux
    { "aserowy/tmux.nvim", cond = utils.isNotPowershell },
    { 'preservim/vimux',   cond = utils.isNotPowershell },
    -- Tag viewer
    { 'preservim/tagbar', },
    -- Easy Align
    { 'junegunn/vim-easy-align' },
    -- Surround, pair character
    { 'tpope/vim-surround' },
    -- Autocompletion & snippets
    { 'L3MON4D3/LuaSnip', },
    { 'hrsh7th/nvim-cmp',
    config = function() require('plugins/nvim-cmp') end,
    requires = {
      { 'hrsh7th/cmp-path',         after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer',       after = 'nvim-cmp' },
      { 'hrsh7th/cmp-cmdline',      after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp',     after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua',     after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
    }}
  },

  git = {
    -- Git labels
    { 'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      cond     = utils.isNotVimNotesEnabled,
      config   = function() require('gitsigns').setup() end },
    -- Git Diff View (like VS Code)
    { 'sindrets/diffview.nvim',
      cond     = utils.isNotVimNotesEnabled },
  },

  ide = {
  -- LSP
    { 'neovim/nvim-lspconfig' },
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
      cond   = utils.isVimNotesEnabled },
  },
}
return plugs
