--[[

Neovim init file
Version: 0.59.2 - 2022/04/19
Maintainer: brainf+ck
Website: https://github.com/brainfucksec/neovim-lua

--]]

-- Import Lua modules
require('packer_init')
require('core/options')
require('core/utils')
require('core/autocmds')
require('core/keymaps')
require('core/colors')
require('core/statusline')
require('plugins/nvim-tree')
require('plugins/vim-clap')
require('plugins/coq')
require('plugins/indent-blankline')
require('plugins/nvim-lspconfig')
require('plugins/nvim-metals')
require('plugins/nvim-treesitter')
require('plugins/alpha-nvim')
