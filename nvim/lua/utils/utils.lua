-- File to store "luaish" utility functions
-- This with the intention, to make configurations file simpler to understand, and extend
local M = {}

-- Idea : Merge multiples tables into 1
-- Input : ({}, {a, b}, {e}, {c, d})
-- Output : {a, b, e, c, d}
function M.tableMerge(result, ...)
    for _, t in ipairs({...}) do
        for _, v in ipairs(t) do
            table.insert(result, v)
            --result[counter] = v
        end
    end
end

-- Idea : Simplify mapping keybindings in nvim with this function, making int more readable in code
-- Input : mapKey('n', '<leader>1', '1gt')
-- Output : none (map keybiding, according to what is on input
function M.map_key(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
	options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Idea : create new table, based on a Associative Table, without the keys, and only the values
-- Input : ({ a = asd, b = qwe, c = xd}, {a, c})
-- Output : {asd, xd}
function M.filter_table_by_keys(inputTable, keyTable)
    local resultTable = {}
    for _, key in ipairs(keyTable) do
        local value = inputTable[key]
        if value then
            table.insert(resultTable, value)
        end
    end
    return resultTable
end


function M.get_last_folder()
    local current_dir = vim.fn.getcwd()
    local last_folder = current_dir:match("[^/]+$") -- Extracts the last folder using regex pattern
    return last_folder
end

return M
