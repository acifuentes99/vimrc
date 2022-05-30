require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = { 'packer', 'NVimTree' },
    always_divide_middle = true,
    globalstatus = false,
    theme = 'base16'
  },
  sections = {
    lualine_a = {'filename'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {'filename'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {'mode','tabs'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {'branch','encoding','fileformat'},
    lualine_y = {'filetype'},
    lualine_z = {'filename'}
  },
  extensions = {'nvim-tree', 'quickfix'}
}
if _G.Tabline_timer == nil then
  _G.Tabline_timer = vim.loop.new_timer()
else
  _G.Tabline_timer:stop()
end
_G.Tabline_timer:start(0,             -- never timeout
1000,          -- repeat every 1000 ms
vim.schedule_wrap(function() -- updater function
  vim.api.nvim_command('redrawtabline')
end))
