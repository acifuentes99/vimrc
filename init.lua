--[[

Neovim init file
Version: 0.59.2 - 2022/04/19
Maintainer: brainf+ck
Website: https://github.com/brainfucksec/neovim-lua

--]]
--local isNotPowershell = require('utils').isNotPowershell
local utils = require('utils')

-- Import Lua modules
require('packer_init')
require('core/options')
require('core/functions')
require('core/autocmds')
require('core/keymaps')
require('interface/colors')
require('interface/statusline')
require('interface/linenumber')
require('interface/tabs')
--require('plugins/nvim-tree')
require('plugins/nvim-cmp')
require('plugins/fuzzy-finder')
--require('plugins/indent-blankline')
--if (utils.isNotVimNotesEnabled) then
--  require('plugins/nvim-lspconfig')
--  require('plugins/nvim-metals')
--end
require('plugins/nvim-treesitter')
require('plugins/alpha-nvim')
--require('plugins/vimwiki')
--if (isNotPowershell) then require('plugins/nvim-tmux') end
