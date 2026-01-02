local devicons = require('nvim-web-devicons')
local theme = require('utils/lualine-colors/tomorrow_night')

require('lualine').setup {
  options = {
    icons_enabled = true,
    -- theme = 'auto',
    theme = theme,
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
    lualine_b = {{'tabs', mode = 2, max_length = vim.o.columns,
      fmt = function(name, context)
        -- Show + if buffer is modified in tab
        local text = ""
        local buflist = vim.fn.tabpagebuflist(context.tabnr)
        local winnr = vim.fn.tabpagewinnr(context.tabnr)
        local bufnr = buflist[winnr]

        -- file = io.open("/home/acifuentes/vim_log.txt", "a")
        -- file:write("in lualine.lua", "\n")
        -- file:write(vim.inspect(context.tabnr), "\n")
        -- file:write(vim.inspect(vim.api.nvim_tabpage_is_valid(context.tabnr)), "\n")

        local tabIndex = vim.api.nvim_list_tabpages()[context.tabnr]

        if (not vim.api.nvim_tabpage_is_valid(tabIndex)) then
          return "not working"
        end

        for _, w in ipairs(vim.api.nvim_tabpage_list_wins(tabIndex)) do
            local b = vim.api.nvim_win_get_buf(w)
            -- filetype = vim.api.nvim_buf_get_option(b, "filetype")
            filetype = vim.api.nvim_buf_get_name(b)
            icon = devicons.get_icon(filetype)
            if (icon ~= nil) then
              mod = vim.fn.getbufvar(b, '&mod')
              text = text .. devicons.get_icon(filetype) .. (mod == 1 and ' +' or '') .. " "
              -- text = text .. devicons.get_icon(filetype) .. " "
            end
        end

        return text
      end
    }},
    -- lualine_c = { 'aerial' },
    lualine_c = { {'navic',
      color_correction = "static",
      navic_opts={highlight = true}
    } },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
        require("utils").get_last_folder
    }
      -- { require('auto-session.lib').current_session_name}
    -- lualine_z = { '󰉋' .. require('auto-session.lib').current_session_name}
  },
  extensions = {'nvim-tree', 'quickfix'},
}


--constant update on tabbar
--tablar only updates, on buffer or winloaddow change
-- if _G.Tabline_timer == nil then
--   _G.Tabline_timer = vim.loop.new_timer()
-- else
--   _G.Tabline_timer:stop()
-- end
-- _G.Tabline_timer:start(0,             -- never timeout
-- 1000,          -- repeat every 1000 ms
-- vim.schedule_wrap(function() -- updater function
--   vim.api.nvim_command('redrawtabline')
-- end))
