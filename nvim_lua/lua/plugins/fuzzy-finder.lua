-----------------------------------------------------------
-- Vim Clap
-----------------------------------------------------------
local g = vim.g

-- g.clap_insert_mode_only = 'v:true' #nunca funciona
--g.clap_preview_direction = 'UD'

g.clap_enable_debug = 'v:true'
g.clap_open_preview = 'never'
g.clap_layout = {
  relative = 'editor',
  width = '67%',
  height = '33%',
  row = '33%',
  col = '17%',
}
--g.clap_enable_icon = 1
--g.clap_files_enable_icon = 1


-----------------------------------------------------------
-- VIM FZF - Legacy fuzzy find, until fixing Clap
-----------------------------------------------------------
g.fzf_preview_window = ''
g.fzf_layout = { up = '~90%', window = { width = 0.8, height = 0.8, yoffset = 0.5, xoffset = 0.5, border = 'sharp', } }
vim.cmd[[
" Fzf
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
]]

