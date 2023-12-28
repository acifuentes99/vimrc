----------------------------------------------------------
-- Callable Functions
-- Custom lua function for beign call inside vim with commands
-----------------------------------------------------------
local M = {}

function M.nvimTreeOpen()
  require("plugins/nvim-tree").setSetup()
  require("nvim-tree.api").tree.open()
end

function M.nvimTreeFindFile()
  require("plugins/nvim-tree").setSetup()
  require("nvim-tree.api").tree.find_file()
end

function M.getWindowDimensions()
  local height_percent = '60'
  local width_percent = '80'
  local height_unit = (vim.o.lines / 100)
  local width_unit = (vim.o.columns / 100)
  local offset_x = math.floor((100 - width_percent) * width_unit / 2)
  local offset_y = math.floor((90 - height_percent) * height_unit / 2) --el 90, es para mover la ventana hacia arriba
  local win_height = math.floor(height_percent * height_unit)
  local win_width = math.floor(width_percent * width_unit)

  local dimensions = {
    height = win_height,
    width = win_width,
    offset_y = offset_y,
    offset_x = offset_x,
  }

  return dimensions
end

return M
