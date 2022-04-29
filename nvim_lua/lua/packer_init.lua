-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README:
-- neovim-lua/README.md
-- https://github.com/brainfucksec/neovim-lua#readme


-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

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
  -- File explorer
  use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons', } }
  -- Indent line
  use 'lukas-reineke/indent-blankline.nvim'
  -- Icons
  use 'kyazdani42/nvim-web-devicons'
  -- Tag viewer
  use 'preservim/tagbar'
  -- Treesitter interface
  use 'nvim-treesitter/nvim-treesitter'
  -- Color schemes
  use 'navarasu/onedark.nvim'
  use 'tanvirtin/monokai.nvim'
  use { 'rose-pine/neovim', as = 'rose-pine' }
  use { 'Shatur/neovim-ayu' }
  -- LSP
  use 'neovim/nvim-lspconfig'
  use({'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap" }})
  -- Autocomplete - COQ Nvim
  --use { 'ms-jpq/coq_nvim' }
  --use 'ms-jpq/coq.artifacts'
  -- Statusline
  use { 'famiu/feline.nvim', requires = { 'kyazdani42/nvim-web-devicons' }, }
  -- Vim Tabs
  use 'nanozuki/tabby.nvim'
  -- Marks on line number
  use 'chentau/marks.nvim'
  -- Diff View (like VS Code)
  use 'sindrets/diffview.nvim'
  -- git labels
    use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup()
    end
  }
  -- Vim Clap - Fuzzy Finding
  use 'liuchengxu/vim-clap'
  -- Vim FZF (In case of missing functions in Clap)
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  -- Dashboard (start screen)
  use { 'goolord/alpha-nvim', requires = { 'kyazdani42/nvim-web-devicons' }, }
  -- Tmux and Vim integration
  use({ "aserowy/tmux.nvim",
    config = function()
      require("tmux").setup({
        copy_sync = {
          enable = false,
        },
        navigation = {
          enable_default_keybindings = true,
        },
        resize = {
          -- enables default keybindings (A-hjkl) for normal mode
          enable_default_keybindings = true,
        }
      })
    end
  })
  use 'preservim/vimux'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
