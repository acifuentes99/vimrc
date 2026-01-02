function read_current_kitty_theme()
  local file = io.open("/home/acifuentes/.config/kitty/kitty.conf", "r")
  local theme_name
  for line in file:lines() do
    if string.find(line, "themes") then
      theme_name = line
    end
  end
  file:close()
  return string.sub(theme_name, 29)
end

local vim_theme_kitty_pairing = {
  ['Espresso.conf'] = 'base16-espresso',
  ['TokyoNight.conf'] = 'tokyonight-moon',
}
local match_lines = read_current_kitty_theme()
print(vim_theme_kitty_pairing[match_lines])

vim.cmd("colorscheme " .. vim_theme_kitty_pairing[match_lines])
vim.cmd("highlight Normal ctermbg=NONE guibg=NONE")
vim.cmd("highlight NormalNC ctermbg=NONE guibg=NONE")
