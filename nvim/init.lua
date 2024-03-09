----[[
--
--Neovim init file
--Version: 0.59.2 - 2022/04/19
--Maintainer: brainf+ck
--Website: https://github.com/brainfucksec/neovim-lua
--
----]]
--local utils = require('utils')
--
---- Import Lua modules
--require('packer_init')
--require('core/options')
--require('core/functions')
--require('core/autocmds')
--require('core/keymaps')
--require('interface/colors')
----require('interface/statusline')
--require('interface/linenumber')
----require('interface/tabs')
--require('plugins/fuzzy-finder')
--require('plugins/nvim-treesitter')
--require('plugins/alpha-nvim')
--

vim.g.mapleader = ','

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
require('configs')
require('keymaps')
require('core/colors')
require('core/autocmds')
require('core/functions')
