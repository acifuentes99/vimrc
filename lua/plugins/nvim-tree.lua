-----------------------------------------------------------
-- File manager configuration file
-----------------------------------------------------------

-- Global options
local g = vim.g
-----------------------------------------------------------
-- Nvim Dev Icons
-----------------------------------------------------------
local status_ok, nvim_web_devicons = pcall(require, 'nvim-web-devicons')
if not status_ok then
  return
end

g.nvim_tree_width_allow_resize  = 1
nvim_web_devicons.setup {
  override = {
    zsh = {
      icon = "",
      color = "#428850",
      cterm_color = "65",
      name = "Zsh"
    },
    cls = {
      icon = "",
      color = "#34a5d9",
      name = "apexcode"
    },
    xml = {
      icon = "",
      color = "#c25955",
      name = "xml"
    },
  },
  default = true
}

local keyList = {
  { key = {"<CR>", "o", "<2-LeftMouse>"}, action = "edit" },
  { key = "<C-e>",                        action = "edit_in_place" },
  { key = {"O"},                          action = "edit_no_picker" },
  { key = {"<2-RightMouse>", "<C-]>"},    action = "cd" },
  { key = "<C-v>",                        action = "vsplit" },
  { key = "<C-x>",                        action = "split" },
  { key = "<C-t>",                        action = "tabnew" },
  { key = "<",                            action = "prev_sibling" },
  { key = ">",                            action = "next_sibling" },
  { key = "P",                            action = "parent_node" },
  { key = "<BS>",                         action = "close_node" },
  { key = "<Tab>",                        action = "preview" },
  { key = "K",                            action = "first_sibling" },
  { key = "J",                            action = "last_sibling" },
  { key = "I",                            action = "toggle_ignored" },
  { key = "H",                            action = "toggle_dotfiles" },
  { key = "R",                            action = "refresh" },
  { key = "a",                            action = "create" },
  { key = "d",                            action = "remove" },
  { key = "D",                            action = "trash" },
  { key = "r",                            action = "rename" },
  { key = "<C-r>",                        action = "full_rename" },
  { key = "x",                            action = "cut" },
  { key = "c",                            action = "copy" },
  { key = "p",                            action = "paste" },
  { key = "y",                            action = "copy_name" },
  { key = "Y",                            action = "copy_path" },
  { key = "gy",                           action = "copy_absolute_path" },
  { key = "[c",                           action = "prev_git_item" },
  { key = "]c",                           action = "next_git_item" },
  --{ key = "-",                            action = "dir_up" },
  { key = "s",                            action = "system_open" },
  { key = "q",                            action = "close" },
  { key = "g?",                           action = "toggle_help" },
  { key = "W",                            action = "collapse_all" }
}

-----------------------------------------------------------
-- Nvim Tree
-----------------------------------------------------------
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- Set dimensions of window
  -- append to existing line based on
  -- available columns
  --local keymaps = {}

  --local opts = {
  --  max_height = 200,
  --  column_width = 200,
  --  column_padding = "  ",
  --}

  --local function table_append(tbl, s)
  --  local last = #tbl > 0 and tbl[#tbl]
  --  if not last or #last + #s > vim.o.columns then
  --    table.insert(tbl, s)
  --  else
  --    tbl[#tbl] = last .. s
  --  end
  --end

  --local lines = {}
  --for _, km in ipairs(keymaps) do
  --  table_append(lines, km)
  --end

  ---- calc popup height based on no. of lines
  --local height = #lines < opts.max_height and #lines or opts.max_height

  ---- rearrange lines so keymaps appear
  ---- sequential within the same column
  --lines = {}
  --for c = 0, math.floor(vim.o.columns / (opts.column_width + #opts.column_padding)) do
  --  for i = 1, height do
  --    local idx = height * c + i
  --    lines[i] = c == 0 and keymaps[idx] or
  --        lines[i] .. (keymaps[idx] or "")
  --  end
  --end

  --local winopts = {
  --  relative = "editor",
  --  style = "minimal",
  --  width = vim.o.columns,
  --  height = height,
  --  row = vim.o.lines - height - vim.o.cmdheight - 2,
  --  col = 1,
  --  -- top border only
  --  border = { " ", "─", " ", " ", " ", " ", " ", " " },
  --  -- topmost popup
  --  zindex = 999,
  --}

  local height_percent = '70'
  local width_percent = '80'
  local height_unit = (vim.o.lines / 100)
  local width_unit = (vim.o.columns / 100)
  local offset_x = math.floor((100 - width_percent) * width_unit / 2)
  local offset_y = math.floor((100 - height_percent) * height_unit / 2)
  local win_height = math.floor(height_percent * height_unit)
  local win_width = math.floor(width_percent * width_unit)

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = false,
    --see :h nvim_open_win
    float = {
        enable = true,
        open_win_config = {
              relative = "editor",
              border = "rounded",
              width = win_width,
              height = win_height,
              row = offset_y,
              col = offset_x,
            }
    },
    mappings = {
        custom_only = true,
        list = list
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

--g.nvim_tree_width_allow_resize  = 1
--
--local status_ok, nvim_tree = pcall(require, 'nvim-tree')
--if not status_ok then
--  return
--end
--
--local list = {
--  { key = {"<CR>", "o", "<2-LeftMouse>"}, action = "edit" },
--  { key = "<C-e>",                        action = "edit_in_place" },
--  { key = {"O"},                          action = "edit_no_picker" },
--  { key = {"<2-RightMouse>", "<C-]>"},    action = "cd" },
--  { key = "<C-v>",                        action = "vsplit" },
--  { key = "<C-x>",                        action = "split" },
--  { key = "<C-t>",                        action = "tabnew" },
--  { key = "<",                            action = "prev_sibling" },
--  { key = ">",                            action = "next_sibling" },
--  { key = "P",                            action = "parent_node" },
--  { key = "<BS>",                         action = "close_node" },
--  { key = "<Tab>",                        action = "preview" },
--  { key = "K",                            action = "first_sibling" },
--  { key = "J",                            action = "last_sibling" },
--  { key = "I",                            action = "toggle_ignored" },
--  { key = "H",                            action = "toggle_dotfiles" },
--  { key = "R",                            action = "refresh" },
--  { key = "a",                            action = "create" },
--  { key = "d",                            action = "remove" },
--  { key = "D",                            action = "trash" },
--  { key = "r",                            action = "rename" },
--  { key = "<C-r>",                        action = "full_rename" },
--  { key = "x",                            action = "cut" },
--  { key = "c",                            action = "copy" },
--  { key = "p",                            action = "paste" },
--  { key = "y",                            action = "copy_name" },
--  { key = "Y",                            action = "copy_path" },
--  { key = "gy",                           action = "copy_absolute_path" },
--  { key = "[c",                           action = "prev_git_item" },
--  { key = "]c",                           action = "next_git_item" },
--  --{ key = "-",                            action = "dir_up" },
--  { key = "s",                            action = "system_open" },
--  { key = "q",                            action = "close" },
--  { key = "g?",                           action = "toggle_help" },
--  { key = "W",                            action = "collapse_all" }
--}
--
---- Call setup:
----- Each of these are documented in `:help nvim-tree.OPTION_NAME`
----nvim_tree.setup {
----  open_on_setup = true,
----  open_on_setup_file = true,
----  open_on_tab = true,
----  update_cwd = true,
----  view = {
----      width = 30,
----      height = 30,
----      side = 'left',
----      preserve_window_proportions = false,
----      number = false,
----      relativenumber = false,
----      signcolumn = "yes",
----      mappings = {
----          custom_only = true,
----          list = list
----      },
----  },
----  renderer = {
----    indent_markers = {
----      enable = false,
----      icons = {
----        corner = "└ ",
----        edge = "│ ",
----        none = "  ",
----      },
----    },
----  },
----  actions = {
----    change_dir = { enable = false },
----  },
----  update_focused_file = {
----    enable = true,
----    update_cwd = true,
----  },
----  filters = {
----    dotfiles = true,
----    custom = { 'node_modules', '.cache', '.bin' },
----  }
----}
--
--nvim_tree.setup { -- BEGIN_DEFAULT_OPTS
--  auto_reload_on_write = true,
--  create_in_closed_folder = false,
--  disable_netrw = false,
--  hijack_cursor = false,
--  hijack_netrw = true,
--  hijack_unnamed_buffer_when_opening = false,
--  ignore_buffer_on_setup = false,
--  open_on_setup = false,
--  open_on_setup_file = false,
--  open_on_tab = true,
--  sort_by = "name",
--  update_cwd = false,
--  reload_on_bufenter = false,
--  respect_buf_cwd = true, --Opcion antigua arriba
--  view = {
--    adaptive_size = false,
--    width = 30,
--    height = 30,
--    hide_root_folder = false,
--    side = "right",
--    preserve_window_proportions = false,
--    number = false,
--    relativenumber = false,
--    signcolumn = "yes",
--    mappings = {
--      custom_only = false,
--      list = {
--        -- user mappings go here
--      },
--    },
--  },
--  renderer = {
--    add_trailing = false,
--    group_empty = false,
--    highlight_git = false,
--    highlight_opened_files = "none", --highlight opened files
--    root_folder_modifier = ":~",
--    indent_markers = {
--      enable = false,
--      icons = {
--        corner = "└ ",
--        edge = "│ ",
--        none = "  ",
--      },
--    },
--    icons = {
--      webdev_colors = true,
--      git_placement = "before",
--      padding = " ",
--      symlink_arrow = " ➛ ",
--      show = { --Opcion showicons
--        file = true,
--        folder = true,
--        folder_arrow = true,
--        git = true,
--      },
--      glyphs = {
--        default = "",
--        symlink = "",
--        folder = {
--          arrow_closed = "",
--          arrow_open = "",
--          default = "",
--          open = "",
--          empty = "",
--          empty_open = "",
--          symlink = "",
--          symlink_open = "",
--        },
--        git = {
--          unstaged = "✗",
--          staged = "✓",
--          unmerged = "",
--          renamed = "➜",
--          untracked = "★",
--          deleted = "",
--          ignored = "◌",
--        },
--      },
--    },
--    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
--  },
--  hijack_directories = {
--    enable = true,
--    auto_open = true,
--  },
--  update_focused_file = {
--    enable = false,
--    update_cwd = false,
--    ignore_list = {},
--  },
--  ignore_ft_on_setup = {},
--  system_open = {
--    cmd = "",
--    args = {},
--  },
--  diagnostics = {
--    enable = false,
--    show_on_dirs = false,
--    icons = {
--      hint = "",
--      info = "",
--      warning = "",
--      error = "",
--    },
--  },
--  filters = {
--    dotfiles = false,
--    custom = {},
--    exclude = {},
--  },
--  git = {
--    enable = true,
--    ignore = true,
--    timeout = 400,
--  },
--  actions = {
--    use_system_clipboard = true,
--    change_dir = {
--      enable = true,
--      global = false,
--      restrict_above_cwd = false,
--    },
--    expand_all = {
--      max_folder_discovery = 300,
--    },
--    open_file = {
--      quit_on_open = false,
--      resize_window = true,
--      window_picker = {
--        enable = true,
--        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
--        exclude = {
--          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
--          buftype = { "nofile", "terminal", "help" },
--        },
--      },
--    },
--    remove_file = {
--      close_window = true,
--    },
--  },
--  trash = {
--    cmd = "trash",
--    require_confirm = true,
--  },
--  live_filter = {
--    prefix = "[FILTER]: ",
--    always_show_folders = true,
--  },
--  log = {
--    enable = false,
--    truncate = false,
--    types = {
--      all = false,
--      config = false,
--      copy_paste = false,
--      diagnostics = false,
--      git = false,
--      profile = false,
--    },
--  },
--} -- END_DEFAULT_OPTS
--
