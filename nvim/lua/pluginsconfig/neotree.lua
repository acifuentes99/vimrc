local function jump_to_buffer_tab(state)
    local node = state.tree:get_node()
    local bufnr = node and node.extra and node.extra.bufnr
    if not bufnr then 
        return 
    end

    for _, tabnr in ipairs(vim.api.nvim_list_tabpages()) do
        for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(tabnr)) do
            if vim.api.nvim_win_get_buf(winid) == bufnr then
                vim.api.nvim_set_current_tabpage(tabnr)
                vim.api.nvim_set_current_win(winid)
            end
        end
    end
    vim.notify("Buffer not visible in any tab", vim.log.levels.INFO)
end

require('neo-tree').setup({
    sources = {"filesystem", "buffers", "git_status"},
    filesystem = {
        hijack_netrw_behavior = "disabled",   
    },
    buffers = {
        window = {
            mappings = {
                ["<leader>jt"] = jump_to_buffer_tab,
                ["o"] = jump_to_buffer_tab,             --Should open buffer in current window
                ["<cr>"] = jump_to_buffer_tab,          --Command to jump to buffer
            }
        }
    }
})
