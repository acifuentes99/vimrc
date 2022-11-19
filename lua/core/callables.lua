----------------------------------------------------------
-- Callable Functions
-- Custom lua function for beign call inside vim with commands
-----------------------------------------------------------
local M = {}

-- Check if terminal is Unix or PowerShell
function M.nvimTreeOpen()
  local height_percent = '70'
  local width_percent = '80'
  local height_unit = (vim.o.lines / 100)
  local width_unit = (vim.o.columns / 100)
  local offset_x = math.floor((100 - width_percent) * width_unit / 2)
  local offset_y = math.floor((100 - height_percent) * height_unit / 2)
  local win_height = math.floor(height_percent * height_unit)
  local win_width = math.floor(width_percent * width_unit)
  require("nvim-tree").setup({view = { float = { enable = true, open_win_config = { relative = "editor", border = "rounded", width = win_width, height = win_height, row = offset_y, col = offset_x, } }, }})
  require("nvim-tree.api").tree.open()
end

function M.nvimTreeFindFile()
  local height_percent = '70'
  local width_percent = '80'
  local height_unit = (vim.o.lines / 100)
  local width_unit = (vim.o.columns / 100)
  local offset_x = math.floor((100 - width_percent) * width_unit / 2)
  local offset_y = math.floor((100 - height_percent) * height_unit / 2)
  local win_height = math.floor(height_percent * height_unit)
  local win_width = math.floor(width_percent * width_unit)
  require("nvim-tree").setup({view = { float = { enable = true, open_win_config = { relative = "editor", border = "rounded", width = win_width, height = win_height, row = offset_y, col = offset_x, } }, }})
  require("nvim-tree.api").tree.find_file()


end

return M
