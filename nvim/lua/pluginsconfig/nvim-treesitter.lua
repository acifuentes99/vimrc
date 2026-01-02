-----------------------------------------------------------
-- Treesitter configuration file
----------------------------------------------------------

-- Plugin: nvim-treesitter
-- url: https://github.com/nvim-treesitter/nvim-treesitter

local status_ok, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
    return
end

-- See: https://github.com/nvim-treesitter/nvim-treesitter#quickstart
nvim_treesitter.setup {
    -- A list of parser names, or "all"
    ensure_installed = {
        'bash', 'c', 'cpp', 'css', 'html', 'javascript', 'json', 'lua', 'python',
        'typescript', 'vim'
    },
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    highlight = {
        -- `false` will disable the whole extension
        enable = true,
        language_tree = true,
        is_supported = function()
            if vim.fn.strwidth(vim.fn.getline('.')) > 300 or vim.fn.getfsize(vim.fn.expand('%')) > 1024 * 1024 then
                return false
            else
                return true
            end
        end
    },
}
vim.treesitter.language.register('apex', 'apexcode')

