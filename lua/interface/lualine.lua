require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = ' ', right = '|'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = { 'packer', 'NVimTree' },
    always_divide_middle = true,
    globalstatus = false,
    --theme = 'base16'
  },
  sections = {
    lualine_a = {'filename'},
    lualine_b = {'filetype'},
    lualine_c = {},
    lualine_x = {'progress','location'},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {'filename'},
    lualine_b = {'filetype'},
    lualine_c = {},
    lualine_x = {'progress','location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {'mode'},
    lualine_b = {'tabs'},
    lualine_c = {},
    lualine_x = {'diff','diagnostics'},
    lualine_y = {'encoding','fileformat'},
    lualine_z = {'branch'}
  },
  extensions = {'nvim-tree', 'quickfix'}
}

--constant update on tabbar
--tablar only updates, on buffer or window change
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
