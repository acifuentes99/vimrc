" -- DEVICONS CONFIG -- "
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_nerdtree = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" -- AIRLINE -- "
set laststatus=2

"--- VIM-SIGNIFY ---"
let g:signify_vcs_cmds = {
            \ 'git':      'git diff -w --no-color --no-ext-diff -U0 -- %f',
            \ 'yadm':     'yadm diff --no-color --no-ext-diff -U0 -- %f',
            \ 'hg':       'hg diff --color=never --config aliases.diff= --nodates -U0 -- %f',
            \ 'svn':      'svn diff --diff-cmd %d -x -U0 -- %f',
            \ 'bzr':      'bzr diff --using %d --diff-options=-U0 -- %f',
            \ 'darcs':    'darcs diff --no-pause-for-gui --no-unified --diff-opts=-U0 -- %f',
            \ 'fossil':   'fossil diff --unified -c 0 -- %f',
            \ 'cvs':      'cvs diff -U0 -- %f',
            \ 'rcs':      'rcsdiff -U0 %f 2>%n',
            \ 'accurev':  'accurev diff %f -- -U0',
            \ 'perforce': 'p4 info '. sy#util#shell_redirect('%n') . (has('win32') ? ' &&' : ' && env P4DIFF= P4COLORS=') .' p4 diff -du0 %f',
            \ 'tfs':      'tf diff -version:W -noprompt -format:Unified %f'
            \ }
let g:signify_disable_by_default = 0

"--- VIM FZF ---"
let g:fzf_preview_window = ''
let g:fzf_layout = { 'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8, 'yoffset':0.5, 'xoffset': 0.5, 'border': 'sharp' } }
let g:fzfOptions = '
        \ --prompt=""
        \ --multi
        \ --margin=1,2
        \ --layout=reverse
        \ --expect=ctrl-t,ctrl-x,ctrl-v
    \'

function! FzfAll(...)
    let query = a:0 >= 1 ? a:1 : ''
    call fzf#run(fzf#wrap({
    \'source': 'rg -l --files --hidden --no-ignore-vcs --glob "!{node_modules/*,.git/*,.tmp-metadata/*}"', 
    \'options': g:fzfOptions . ' --query=' . query
    \ }))
endfunction

command! -bang -nargs=* All call FzfAll(<f-args>)

function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let querystring = tolower(a:query)
    let initial_command = printf(command_fmt, shellescape(querystring))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', querystring, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Rgg call RipgrepFzf(<q-args>, <bang>0)

"--- SCRATCH BUFFER ---"
function! TabNewWithScratchBuffer()
    execute "tabnew" 
    set buftype=nofile
    set bufhidden=hide
    setlocal noswapfile
endfunction
nnoremap <A-t> :call TabNewWithScratchBuffer()<CR>

"--- COC NVIM ---"
set nobackup
set nowritebackup
set shortmess+=c
set signcolumn=number

"--- SALESFORCE CUSTOM CONFIG ---"
"--- AURA ---"
"augroup set_filetype
"    :autocmd!
"    :autocmd BufEnter *.cmp,*.evt,*.design :set filetype=html " Salesforce files
"    :autocmd BufEnter *.tsx :set filetype=typescript.tsx
"    :autocmd BufEnter *.jsx :set filetype=javascript.jsx
"augroup END
"
""--- APEX ---"
"augroup filetype_apexcode
"    :autocmd!
"    :autocmd FileType apexcode* :setlocal shiftwidth=4 tabstop=4 foldmethod=indent foldlevel=0 foldlevelstart=0
"augroup END
"
"au BufNewFile,BufRead *.cmp set filetype=html
"au BufNewFile,BufRead *.cls set filetype=apexcode

" -- VIMUX -- "
let g:VimuxUseNearest = 1
let mapleader = "-"
map <Leader>p :call VimuxRunCommand("sfdx force:source:push")<CR>


" -- NVIM TREE -- "
"let g:nvim_tree_tab_open = 1
"let g:nvim_tree_disable_default_keybindings = 1
"lua <<EOF
"    local tree_cb = require'nvim-tree.config'.nvim_tree_callback
"EOF
"lua require('~/home/acifuentes/.config/nvim/luaconfig2')
"lua require('~/.config/nvim/luaconfig')
"sign define LspDiagnosticsSignError text=🔴
"sign define LspDiagnosticsSignWarning text=🟠
"sign define LspDiagnosticsSignInformation text=🔵
"sign define LspDiagnosticsSignHint text=🟢
"luafile ~/.config/nvim/luaconfig.lua
"luafile /home/acifuentes/.config/nvim/luaconfig2.lua
"
"set completeopt=menuone,noinsert,noselect
"let g:completion_matching_strategy_list = ['prefix', 'substring', 'fuzzy']
"let g:completion_matching_ignore_case=1
"let g:completion_menu_length=10
"let g:completion_abbr_length=30

" -- NVIM TREE -- "
"let g:open_on_tab = 1
"let g:nvim_tree_disable_default_keybindings = 1
lua <<EOF
local list = {
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
require'nvim-tree'.setup {
    open_on_tab = true,
    view = {
        width = 30,
        height = 30,
        side = 'left',
        auto_resize = false,
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        mappings = {
            custom_only = true,
            list = list
        },
    }
}
EOF

