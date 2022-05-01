-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- Automatically install packer
local fn = vim.fn
local utils = require('utils')
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local tmux_conf = require('plugins/nvim-tmux')

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost packer_init.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Install plugins
return packer.startup(function(use)
  -- Add you plugins here:
  use 'wbthomason/packer.nvim' -- packer can manage itself
  -- Treesitter interface
  use 'nvim-treesitter/nvim-treesitter'

  -- Color schemes
  use {
    { 'navarasu/onedark.nvim' },
    { 'tanvirtin/monokai.nvim' },
    { 'rose-pine/neovim', as = 'rose-pine'  },
    { 'Shatur/neovim-ayu' },
  }

  -- Interface
  use {
    -- Icons
    { 'kyazdani42/nvim-web-devicons' },
    -- Dashboard (start screen)
    { 'goolord/alpha-nvim', requires = { 'kyazdani42/nvim-web-devicons' }, },
    -- File explorer
    { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons', } },
    --use { 'famiu/feline.nvim', requires = { 'kyazdani42/nvim-web-devicons' }, }
    { 'famiu/feline.nvim', requires = { 'kyazdani42/nvim-web-devicons' }, },
    -- Indent line
    { 'lukas-reineke/indent-blankline.nvim' },
    -- Vim Tabs
    { 'nanozuki/tabby.nvim' },
    -- Marks on line number
    { 'chentau/marks.nvim' },
    -- Git labels
    { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = function() require('gitsigns').setup() end },
  }

  -- LSP
  use {
    { 'neovim/nvim-lspconfig' },
    { 'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap" } }
  }

  -- Autocompletion & snippets
  use {
    { 'L3MON4D3/LuaSnip', },
    { 'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
    }}
  }

  -- Helpers (Owns UI)
  use {
    -- Tag viewer
    { 'preservim/tagbar' },
    -- Git Diff View (like VS Code)
    { 'sindrets/diffview.nvim' },
    -- Easy Align
    { 'junegunn/vim-easy-align' },
    -- Surround, pair character
    { 'tpope/vim-surround' },
  }

  -- Fuzzy Finding
  use {
    -- Vim Clap
    { 'liuchengxu/vim-clap' },
    -- Vim FZF (In case of missing functions in Clap)
    { 'junegunn/fzf' },
    { 'junegunn/fzf.vim' },
  }

  -- Tmux and Vim integration
  use {
    { "aserowy/tmux.nvim", cond = utils.isNotPowershell, config = tmux_conf.conf },
    { 'preservim/vimux', cond = utils.isNotPowershell}
  }

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
  require('packer').sync()
end
end)
