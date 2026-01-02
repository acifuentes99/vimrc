----------------------------------------------------------
-- Callable Functions
-- Custom lua function for beign call inside vim with commands
-----------------------------------------------------------
local M = {}

function M.nvimTreeOpen()
    require("pluginsconfig/nvim-tree")
    require("nvim-tree.api").tree.open()
end

function M.nvimTreeFindFile()
    require("pluginsconfig/nvim-tree")
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

--------------------------------------------
--- MACRO SELECTOR
--------------------------------------------

M.fzf_macro_selector = function(opts)
    local macrotable = require('core/macro_table')
    local fzf_lua = require('fzf-lua')
    opts = opts or {}
    opts.prompt = "Macros> "
    opts.actions = {
        ['default'] = function(selected)
            local selected_option = macrotable[selected[1]]
            setRegistersOnVim(selected_option)
        end
    }
    fzf_lua.fzf_exec(extractNameAttribute(macrotable), opts)
end

function extractNameAttribute(macrotable)
    local namesList = {}
    for key, _ in pairs(macrotable) do 
        table.insert(namesList, key)
    end
    return namesList
end

function setRegistersOnVim(selected_option)
    for key, entry in pairs(selected_option.register) do 
        vim.fn.setreg(key, entry)
    end
    vim.fn.setreg("a", selected_option.macro)
end

M.close_floating = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do 
        if vim.api.nvim_win_get_config(win).relative == "win" then 
            vim.api.nvim_win_close(win, false)
        end
    end
end


--------------------------------------------
--- MIGHTY SIDEBAR
--------------------------------------------

M.is_buffer_in_current_window = function(buffer_name)
    buffer_name = string.gsub(buffer_name, "-", "%%-")
    local wins = vim.api.nvim_tabpage_list_wins(0)
    for _, win in ipairs(wins) do 
        local buf = vim.api.nvim_win_get_buf(win)
        local name = vim.api.nvim_buf_get_name(buf)
        if string.match(name, buffer_name) ~= nil then
            return true
        end
    end
    return false
end

M.open_sidebar = function()
    vim.t.sidebar_loaded = M.is_buffer_in_current_window('neo-tree')
    if vim.t.sidebar_loaded then
        return
    end
    local saved_winid = vim.api.nvim_get_current_win()
    vim.defer_fn(function()
        vim.cmd('Neotree source=buffers position=right')
        vim.defer_fn(function()
            vim.cmd('split')
            require('aerial').open()
            vim.cmd('wincmd h')
            vim.cmd('close')
            vim.cmd('wincmd h')
            vim.api.nvim_set_current_win(saved_winid)
        end, 50)
    end, 50)
end

M.jump_to_buffer_in_window_co = function(buffer_name_substring)
    return coroutine.create(
        function()
            local tabpage = vim.api.nvim_get_current_tabpage()
            local wins = vim.api.nvim_tabpage_list_wins(tabpage)
            for _, win in ipairs(wins) do 
                local buf = vim.api.nvim_win_get_buf(win)
                local name = vim.api.nvim_buf_get_name(buf)
                if name:find('neo%-tree') then -- Hardcoded becase Im lazy
                    vim.api.nvim_set_current_win(win)
                    return
                end
            end
            coroutine.yield()
        end
    )
end

M.toggle_sidebar = function()
    local saved_winid = vim.api.nvim_get_current_win()
    vim.t.sidebar_loaded = M.is_buffer_in_current_window('neo-tree')
    if not vim.t.sidebar_loaded then
        M.open_sidebar()
        return
    end
    local co = M.jump_to_buffer_in_window_co('neo-tree')
    coroutine.resume(co)
    vim.cmd('close')
    vim.cmd('close')
    vim.api.nvim_set_current_win(saved_winid)
end

--------------------------------------------
--- RETURN
--------------------------------------------

function list_all_windows()
    local result = "Open Windows and Buffers:\n"
    local tabs = vim.api.nvim_list_tabpages()
    for _, tab in ipairs(tabs) do 
        local tab_nr = vim.api.nvim_tabpage_get_number(tab)
        result = result .. string.format("Tab %d:\n", tab_nr)

        local wins = vim.api.nvim_tabpage_list_wins(tab)
        for _, win in ipairs(wins) do 
            local win_nr = vim.api.nvim_win_get_number(win)
            local buf = vim.api.nvim_win_get_buf(win)
            local buf_name = vim.api.nvim_buf_get_name(buf)
            local buf_nr = vim.api.nvim_buf_get_number(buf)
            local display_name = buf_name:gsub("^" .. vim.env.HOME .. "/", "~/")
            result = result .. string.format(" Window %d (Buf %d): %s\n", win_nr, buf_nr, display_name)
        end
    end
end

vim.api.nvim_create_user_command('PrintSplits', list_all_windows, {})

return M
