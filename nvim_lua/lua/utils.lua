----------------------------------------------------------
-- Utilitary Functions
-- For all Lua repo
-----------------------------------------------------------
local M = {}

-- Check if terminal is Unix or PowerShell
function M.isNotPowershell()
  return os.getenv("TERM") ~= "vtpcon"
end

-- Check if terminal is Unix or PowerShell
function M.isVimNotesMode()
  local term = os.getenv("VIM_NOTES_MODE_ON")
  return term == "xterm-256color"
end

return M
