local M = {}
local devicons = require('nvim-web-devicons')

function M.test()
    currtabindx = vim.api.nvim_win_get_tabpage(0)
    buflist = vim.api.nvim_list_bufs()
    print('asdfadasf')
    print(currtabindx)
    print(vim.inspect(buflist))
    -- print(vim.inspect(vim.api.nvim_list_tabpages()))
    -- print(vim.inspect(vim.api.nvim_tabpage_list_wins(1)))
    -- buffer = vim.api.nvim_win_get_buf(1000)
    -- print(vim.api.nvim_buf_get_name(buffer))
    -- print(vim.api.nvim_buf_get_option(buffer, "filetype"))

    for i, t in ipairs(vim.api.nvim_list_tabpages()) do
        for _, w in ipairs(vim.api.nvim_tabpage_list_wins(t)) do
            local b = vim.api.nvim_win_get_buf(w)
            filetype = vim.api.nvim_buf_get_option(b, "filetype")
            print(devicons.get_icon(filetype))
        end
    end

    local buflist = vim.fn.tabpagebuflist(context.tabnr)
    local winnr = vim.fn.tabpagewinnr(context.tabnr)
    local bufnr = buflist[winnr]
    local mod = vim.fn.getbufvar(bufnr, '&mod')
end


M.test()

return M
