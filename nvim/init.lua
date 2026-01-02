require('options')

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
    vim.g.neovide_window_blurred = true
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    -- vim.g.neovide_background_color = "#0f1117" .. alpha()

    vim.keymap.set('n', '<C-s>', ':w<CR>') -- Save
    vim.keymap.set('v', '<C-c>', '"+y') -- Copy
    --vim.keymap.set('n', '<C-v>', '"+P') -- Paste normal mode
    vim.keymap.set('v', '<C-v>', '"+P') -- Paste visual mode
    vim.keymap.set('c', '<C-v>', '<C-R>+') -- Paste command mode
    vim.keymap.set('i', '<C-v>', '<ESC>l"+Pli') -- Paste insert mode

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

function read_current_kitty_theme()
  local file = io.open("/home/acifuentes/.config/kitty/kitty.conf", "r")
  local theme_name
  for line in file:lines() do
    if string.find(line, "themes") then
      theme_name = line
    end
  end
  file:close()
  return string.sub(theme_name, 29)
end

local vim_theme_kitty_pairing = {
  ['Espresso.conf'] = 'base16-espresso',
  ['TokyoNight.conf'] = 'tokyonight-moon',
}
local match_lines = read_current_kitty_theme()
print(vim_theme_kitty_pairing[match_lines])

vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})

require("lazy").setup("plugins")
require('keymaps')
require('core/colors')
require('core/autocmds')
require('core/functions')

vim.cmd("colorscheme " .. vim_theme_kitty_pairing[match_lines])
vim.cmd("highlight Normal ctermbg=NONE guibg=NONE")
vim.cmd("highlight NormalNC ctermbg=NONE guibg=NONE")
