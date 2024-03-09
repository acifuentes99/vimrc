-----------------------------------------------------------
-- Vimwiki configuration
-----------------------------------------------------------
local g = vim.g
local vimwikifolder = os.getenv("VIMNOTES_NOTES_FOLDER")

--let vimwikifolder = $VIMNOTES_NOTES_FOLDER
g.zettelkasten = vimwikifolder .. "/"
g.zettelkasten_folder = "Z. Zettelkasten/"

g.vimwiki_hl_headers = 1
g.vimwiki_global_ext = 0
g.vimwiki_key_mappings = { table_mappings = 0 }
-- TODO : Make it work... should be in command :VimwikiUISelect
g.vimwiki_list = {{
  path = vimwikifolder,
  syntax = "markdown",
  ext = ".md",
  diary_rel_path = "Y. Journal/",
  nested_syntaxes = { js = "javascript", py = "python" }
}}
g.vimwiki_url_maxsave = 0
g.vimwiki_markdown_link_ext = 0
g.vimwiki_create_link = 0

-----------------------------------------------------------
-- Utils
-----------------------------------------------------------

vim.cmd[[
"let g:vimwiki_list = [{'path': $VIMNOTES_NOTES_FOLDER,
"                \ 'syntax': 'markdown',
"                \ 'ext': '.md',
"                \ 'diary_rel_path': 'y. journal/',
"                \ 'nested_syntaxes': {'js': 'javascript', 'py': 'python'}}]

augroup initvim
  au!
  autocmd FileType markdown let b:surround_56 = "**\r**"
  autocmd FileType vimwiki let b:surround_56 = "**\r**"
augroup END

function! HandleFZF(file)
    let filename = a:file
    let filename_wo_timestamp = fnamemodify(a:file, ":t:s/^[0-9]*-//")
    let mdlink = "\[\[".filename."|".filename_wo_timestamp."\]\]"
    put=mdlink
endfunction

function! OpenLinkInNumber()
    let vcount = v:count
    execute "normal! " . vcount . "gg"
    execute "VimwikiNextLink"
    "execute "VimwikiFollowLink"
endfunction

function! ToggleCalendar()
 execute ":Calendar"
 if exists("g:calendar_open")
   if g:calendar_open == 1
     execute "q"
     unlet g:calendar_open
   else
     g:calendar_open = 1
   end
 else
   let g:calendar_open = 1
 end
endfunction

" Zettelkasten
"command! -nargs=1 NewZettel :execute ":e" zettelkasten . strftime("%Y%m%d%H%M") . "-<args>.md"
function! NewZettel(name)
    exe "normal! a\[\[" . g:zettelkasten_folder . strftime("%Y%m%d%H%M") . " ". a:name . ".md|" . a:name . "\]\]\<Esc>"
endfunction

command! -nargs=1 NewZettel :call NewZettel(<f-args>)
command! -nargs=1 HandleFZF :call HandleFZF(<f-args>)
command! -bang -nargs=? -complete=dir AddFZFLink call fzf#run({'sink': 'HandleFZF', 'window': {'width': 0.9, 'height': 0.6}})
]]


-----------------------------------------------------------
-- Keymaps
-----------------------------------------------------------
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


-- Change leader to a comma
vim.g.mapleader = '-'
map('n', '<M-l>',      ':AddFZFLink<CR>')
map('n', '<CR>',       '<Plug>VimwikiFollowLink')
map('n', ',',          ':<C-U>call OpenLinkInNumber()<CR>')
map('n', '<Leader>i',  '<Plug>VimwikiIndex')
map('n', '<Leader>j',  '<Plug>VimwikiDiaryIndex')
map('n', '<leader>nz', ':NewZettel ', { silent = false })

-- Center cursor on move
map('n', '{',  '{zz')
map('n', '}',  '}zz')
map('n', 'n',  'nzz')
map('n', 'N',  'Nzz')
map('n', '[c', '[czz')
map('n', ']c', ']czz')
map('n', '[j', '<C-o>zz')
map('n', ']j', '<C-i>zz')
map('n', '[s', '[szz')
map('n', ']s', ']szz')

-- SpellChecker
map('n', '<F5>', ':setlocal spell! spelllang=en,es<CR>')
map('i', '<F8>', '1z=')
map('i', '<F9>', ']s')
map('i', '<F10>', ' [s')
map('n', '<F8>', '1z=')
map('n', '<F9>', ']s')
map('n', '<F10>', ' [s')
map('n', '<F20>', ' 1z=')
map('n', '<F21>', ' ]s')
map('n', '<F22>', ' [s')

-- English keyboard to Spanish characters
map('i', '[a', 'á')
map('i', '[e', 'é')
map('i', '[i', 'í')
map('i', '[o', 'ó')
map('i', '[u', 'ú')
map('i', ';',  'ñ')
map('i', ';;', ';')

-- Insert Mode Movement
map('i', '<A-h>',   '<C-o>h')
map('i', '<A-j>',   '<C-o>j')
map('i', '<A-k>',   '<C-o>k')
map('i', '<A-l>',   '<C-o>l')
map('i', '<A-w>',   '<C-o>w')
map('i', '<A-e>',   '<C-o>e')
map('i', '<A-b>',   '<C-o>b')
map('i', '<A-C-h>', '<C-o>0')
map('i', '<A-C-l>', '<C-o>$')
map('i', '<A-{>',   '<C-o>{')
map('i', '<A-}>',   '<C-o>}')
map('i', '<A-.>',   '<C-o>>><C-o>$')
map('i', '<A-,>',   '<C-o><<<C-o>$')
map('i', '<A-C-o>', '<C-o>:execute "normal <Plug>VimwikiListO"<CR>')
map('i', '<A-C-d>', '<C-o>dd')
map('i', '<A-o>',   '<C-o>:execute "normal <Plug>VimwikiListo"<CR>')
map('i', '<A-q>',   '<Esc>')
--map('i', '<A-char-62>', '<C-o>>><C-o>$')
--map('i', '<A-char-60>', '<C-o><<<C-o>$')

