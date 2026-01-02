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
