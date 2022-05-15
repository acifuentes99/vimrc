-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- Automatically install packer
local fn = vim.fn
local utils = require('utils')
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

local plugs = require('plugin_list')
-- Install plugins
return packer.startup(function(use)
  use { 'wbthomason/packer.nvim' } -- packer can manage itself

  for key, definitions in pairs(plugs) do
    for i = #definitions, 1, -1 do
      value = definitions[i]
      --if (key == 'vimnotes') then
      --  value.cond = utils.isVimNotesEnabled
      --elseif (key == 'ide') then
      --  value.cond = utils.isNotVimNotesEnabled
      --end
      use(value)
    end
  end

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
