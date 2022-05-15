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
function M.isVimNotesEnabled()
  return os.getenv("VIM_NOTES_ENABLED") == "1"
end

-- Check if terminal is Unix or PowerShell
function M.isNotVimNotesEnabled()
  return os.getenv("VIM_NOTES_ENABLED") ~= "1"
end

return M
