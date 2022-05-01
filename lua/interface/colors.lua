-----------------------------------------------------------
-- Color schemes configuration file
-----------------------------------------------------------
-- TODO : Per Theme configurations/setups, then enable for all plugins

local status_ok, color_scheme = pcall(require, 'ayu')
if not status_ok then
  return
end

color_scheme.setup({
  mirage = true,
  overrides = {}
})
color_scheme.colorscheme()

-- OneDark styles: dark, darker, cool, deep, warm, warmer, light
--require('onedark').setup {
--  style = 'darker',
--  colors = { fg = '#b2bbcc' }, --default: #a0a8b7
--}
--require('onedark').load()

-- statusline color schemes:
-- import with: require('colors').colorscheme_name
local M = {}

-- Theme : Ayu
-- Colors: https://github.com/Shatur/neovim-ayu/blob/master/lua/ayu/colors.lua
M.ayu_dark = {
  bg = '#11151C',
  fg = '#CBCCC6',
  pink = '#D2A6FF',
  green = '#AAD94C',
  cyan = '#39BAE6',
  yellow = '#FFB454',
  orange = '#FF8F40',
  red = '#F07178',
}

M.ayu_mirage = {
  bg = '#171B24',
  fg = '#CBCCC6',
  pink = '#DFBFF',
  green = '#D5FF80',
  cyan = '#5CCFE6',
  yellow = '#FFD173',
  orange = '#FFAD66',
  red = '#F28779',
}

-- Theme: OneDark (dark)
-- Colors: https://github.com/navarasu/onedark.nvim/blob/master/lua/onedark/palette.lua
M.onedark_dark = {
  bg = '#282c34',
  fg = '#b2bbcc',
  pink = '#c678dd',
  green = '#98c379',
  cyan = '#56b6c2',
  yellow = '#e5c07b',
  orange = '#d19a66',
  red = '#e86671',
}

-- Theme: Monokai (classic)
-- Colors: https://github.com/tanvirtin/monokai.nvim/blob/master/lua/monokai.lua
M.monokai = {
  bg = '#202328', --default: #272a30
  fg = '#f8f8f0',
  pink = '#f92672',
  green = '#a6e22e',
  cyan = '#66d9ef',
  yellow = '#e6db74',
  orange = '#fd971f',
  red = '#e95678',
}

-- Theme: Rosé Pine (main)
-- Colors: https://github.com/rose-pine/neovim/blob/main/lua/rose-pine/palette.lua
-- color names are adapted to the formats above
M.rose_pine = {
  bg = '#111019', --default: #191724
  fg = '#e0def4',
  pink = '#eb6f92',
  green = '#9ccfd8',
  cyan = '#31748f',
  yellow = '#f6c177',
  orange = '#2a2837',
  red = '#ebbcba',
}

return M
