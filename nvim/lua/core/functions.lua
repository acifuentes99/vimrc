----------------------------------------------------------
-- Utilitary Vim Funcions
-- Customized functions and commands
-----------------------------------------------------------

-- Use Vim Api, to register functions, then use them on keymaps.lua, or
-- other parts of code
local api = vim.api

----------------------------------------------------------
-- New tab: Scratch Buffer
-----------------------------------------------------------
api.nvim_create_user_command('TabNewWithScratchBuffer', function()
  api.nvim_command('tabnew') -- equivalent to :enew
  vim.bo.buftype='nofile' -- set the current buffer's (buffer 0) buftype to nofile
  vim.bo.bufhidden='hide'
  vim.bo.swapfile=false
end, { nargs = 0 })
-- :command! -nargs=1 Upper echo toupper(<q-args>)

----------------------------------------------------------
-- Visual Selection search highlight
-- TODO : Migrate to Lua
-----------------------------------------------------------
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


----------------------------------------------------------
-- NOT USED: List sessions in FzfLua
-----------------------------------------------------------
api.nvim_create_user_command('ListSessionsLegacy', function()
    require("fzf-lua").fzf_exec("ls", {
      prompt="Sessions> ",
      cwd="$HOME/.local/share/nvim/sessions",
      actions = {
        ['default'] = function(selected, opts)
          require("auto-session").SaveSession()

          local bufs=vim.api.nvim_list_bufs()
          local current_buf=vim.api.nvim_get_current_buf()
          for _,i in ipairs(bufs) do
              if i~=current_buf then
                  vim.api.nvim_buf_delete(i,{})
              end
          end
          vim.cmd("SessionRestoreFromFile $HOME/.local/share/nvim/sessions/" .. selected[1])
        end
      }})
end, { nargs = 0 })


api.nvim_create_user_command('ListSessions', function()
    local sessionUtils = require("session-mamanger.utils")
    originalTable = sessionUtils.get_sessions()
    newTable = {}
    for _, v in ipairs(originalTable) do
      item = sessionUtils.shorten_path(item.dir)
      table.insert(newTable, v)
    end


    require("fzf-lua").fzf_exec(newTable, {
      prompt="Sessions> ",
      actions = {
        ['default'] = function(selected)
          require("auto-session").SaveSession()

          local bufs=vim.api.nvim_list_bufs()
          local current_buf=vim.api.nvim_get_current_buf()
          for _,i in ipairs(bufs) do
              if i~=current_buf then
                  vim.api.nvim_buf_delete(i,{})
              end
          end
          vim.cmd("SessionRestoreFromFile $HOME/.local/share/nvim/sessions/" .. selected[1])
        end
      }})
end, { nargs = 0 })

----------------------------------------------------------
-- Util commands
-----------------------------------------------------------
api.nvim_create_user_command('ClearUnwantedSpaces', function()
  api.nvim_command('%s/\\s\\+S//e')
end, { nargs = 0 })

-- Find a component in other casing to camel case
-- (useful for searching in frontend components)
api.nvim_create_user_command('FzfLuaFindFrontend', function()
  local registerValue = vim.api.nvim_eval('expand("%:t:r")')
  local rgExpression = textcase.to_dash_case(registerValue) .. '|' .. textcase.to_camel_case(registerValue)
  require('fzf-lua').grep_project({ search = rgExpression, no_esc = true })
end, { nargs = 0 })

----------------------------------------------------------
-- Lua function to delete all buffers that are not currently in a window
-----------------------------------------------------------
local function clear_not_attached_buffers()
  local buffers = vim.api.nvim_list_bufs()

  for _, bufnr in ipairs(buffers) do
    if vim.api.nvim_buf_is_valid(bufnr) and vim.fn.bufwinnr(bufnr) == -1 then
      pcall(vim.cmd, "silent! bwipeout! " .. bufnr)
    end
  end
end

vim.api.nvim_create_user_command('ClearUnusedBuffers', clear_not_attached_buffers, {
  desc = 'Clear all buffers not attached to a window'
})
