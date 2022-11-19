-----------------------------------------------------------
-- Nvim Spectre
-----------------------------------------------------------
local M = {}

function M.getFloatingWin()
  local winDimensions = require('core/callables').getWindowDimensions()
  local windowOpts = {
    relative = "win",
    row = winDimensions.offset_y,
    col = winDimensions.offset_x,
    width = winDimensions.width,
    height = winDimensions.height,
    style = "minimal",
    border = "rounded"
  }

  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, windowOpts)
  vim.api.nvim_win_set_option(win, "winhl", "Normal:MyHighlight")
end

function M.setConfig()
  require('spectre').setup({
    color_devicons = true,
    open_cmd = 'lua require("plugins/spectre").getFloatingWin()',
    live_update = false, -- auto excute search again when you write any file in vim
    line_sep_start = '┌-----------------------------------------',
    result_padding = '¦  ',
    line_sep       = '└-----------------------------------------',
    highlight = {
      ui = "String",
      search = "DiffChange",
      replace = "DiffDelete"
    },
})
end

return M
