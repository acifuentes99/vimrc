require("auto-session").setup {
  log_level = "error",
  --auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
  auto_session_allowed_dirs = { "~/gdrive/Notes/", "~/Projects", "~/Downloads" },
  pre_restore_cmds = {
    function()
      -- require("auto-session").SaveSession
      return [[echo "session changed"]]
    end
  },
  post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
    require("lualine").refresh() -- refresh lualine so the new session name is displayed in the status bar
  end,
}
