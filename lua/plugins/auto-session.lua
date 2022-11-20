  config = function()
    require("auto-session").setup {
      log_level = "error",
      --auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
      auto_session_allowed_dirs = { "~/gdrive/Notes/", "~/Projects", "~/Downloads" },
    }
  end
