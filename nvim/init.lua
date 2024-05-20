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

local alpha = function()
  return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
end

if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here
    vim.g.neovide_cursor_animation_length = 0
    vim.opt.winblend = 30
    vim.opt.pumblend = 30
    vim.g.neovide_transparency = 0.8
    vim.g.transparency = 0.8
    vim.g.neovide_background_color = "#0f1117" .. alpha()

    vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
    vim.keymap.set('v', '<D-c>', '"+y') -- Copy
    vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
    vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
    vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
    vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

    vim.g.neovide_scale_factor = 1.0
    local change_scale_factor = function(delta)
      vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-=>", function()
      change_scale_factor(1.1)
    end)
    vim.keymap.set("n", "<C-->", function()
      change_scale_factor(1/1.1)
    end)
end

vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})

require("lazy").setup("plugins")
require('configs')
require('keymaps')
require('core/colors')
require('core/autocmds')
require('core/functions')
