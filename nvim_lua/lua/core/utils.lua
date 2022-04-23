local api = vim.api

local M = {}

function M.tabNewWithScratchBuffer()
  api.nvim_command('tabnew') -- equivalent to :enew
  vim.bo.buftype='nofile' -- set the current buffer's (buffer 0) buftype to nofile
  vim.bo.bufhidden='hide'
  vim.bo.swapfile=false
end

vim.api.nvim_create_user_command('TabNewWithScratchBuffer', function()
  api.nvim_command('tabnew') -- equivalent to :enew
  vim.bo.buftype='nofile' -- set the current buffer's (buffer 0) buftype to nofile
  vim.bo.bufhidden='hide'
  vim.bo.swapfile=false
end, { nargs = 0 })
-- :command! -nargs=1 Upper echo toupper(<q-args>)

-- VISUAL SELECTION
-- Press Search, then highlight all matches in file
-- TODO : Migrate to Lua
vim.cmd [[
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
]]

return M
