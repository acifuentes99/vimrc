local M = {}

function M.setConfig()
  require("obsidian").setup({
    dir = "~/gdrive/Notes",
    completion = {
      nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
    }
  })
end

return M
