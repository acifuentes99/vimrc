----------------------------------------------------------
-- Tabs configuration
-----------------------------------------------------------

--require("tabby").setup({
--    tabline = require("tabby.presets").tab_with_top_win,
--})


local filename = require('tabby.filename')
local util = require('tabby.util')
local devicons = require('nvim-web-devicons')
local colors = require('interface/colors').ayu_mirage

local hl_tabline = util.extract_nvim_hl('TabLine')
local hl_normal = util.extract_nvim_hl('Normal')
local hl_tabline_sel = util.extract_nvim_hl('TabLineSel')
local hl_tabline_fill = util.extract_nvim_hl('TabLineFill')


local function tab_label(tabid, active)
  local icon = active and '' or ''
  local number = vim.api.nvim_tabpage_get_number(tabid)
  local name = util.get_tab_name(tabid)
  return string.format(' %s %d: %s ', icon, number, name)
end

local function tab_label_no_fallback(tabid, active)
  local fallback = function()
    return ''
  end
  local number = vim.api.nvim_tabpage_get_number(tabid)
  local name = util.get_tab_name(tabid, fallback)
  if name == '' then
    return string.format(' %d ', number)
  end
  return string.format(' %d: %s ', number, name)
end

local function get_icon(winid)
  local path = filename.unique(winid)
	local extension = vim.fn.fnamemodify(path, ":e")
	local filename = vim.fn.fnamemodify(path, ":t")
	local iconname, iconcolor = devicons.get_icon_color (filename, extension, { default = true})
  return iconname
end

local function icon_color(winid, active)
  local path = filename.unique(winid)
	local extension = vim.fn.fnamemodify(path, ":e")
	local filename = vim.fn.fnamemodify(path, ":t")
	local iconname, iconcolor = devicons.get_icon_color (filename, extension, { default = true})
  return iconcolor
end

local function win_label(winid, top)
  local filename = filename.unique(winid)
	local icon, iconcolor = devicons.get_icon_color (filename, extension, { default = true})
	local buf_color = is_current and active_tab_hl or inactive_tab_hl
  return string.format('%s %s ', icon, filename)
end

---@type TabbyTablineOpt
local tabline = {
  hl = 'TabLineFill',
  layout = 'tab_with_top_win',
  head = {
    { '  ', hl = { fg = hl_tabline.fg, bg = hl_tabline.bg, style = 'italic' } },
    { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
  },
  active_tab = {
    label = function(tabid)
      return {
        tab_label_no_fallback(tabid, true),
        hl = { fg = hl_normal_fg, bg = hl_normal.bg },
      }
    end,
    left_sep = { '', hl = { fg = hl_normal.bg, bg = hl_tabline_fill.bg } },
  },
  inactive_tab = {
    label = function(tabid)
      return {
        tab_label_no_fallback(tabid),
        hl = 'TabLine',
      }
    end,
    left_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
  },
  active_win = {
    label = function(winid)
      return {
        win_label(winid, true),
        hl = { fg = hl_normal.fg, bg = hl_normal.bg },
      }
    end,
    right_sep = { '', hl = { fg = hl_normal.bg, bg = hl_tabline_fill.bg } },
  },
  win = {
    label = function(winid)
      return {
        win_label(winid),
        hl = 'TabLine',
      }
    end,
    right_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
  },
}

require('tabby').setup({
  tabline = tabline,
})
