local M = {}

function M.setConfig()
    require("obsidian").setup({
        completion = {
            nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
        },
        disable_frontmatter = true,
    })
end

return M
