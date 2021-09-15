" VIM GENERAL KEYSTROKES
" Used in all Vim configurations file
" Requires :
"   * Vim FZF
"   * vim-windowswap
"   * Vim Utils (util custom functions)

"--- DEFAULT REMAPPINGS ---"
nnoremap ZZ :wa!<CR>

"--- CTRL KEYSTROKES (FAST ACCESS) ---"
nnoremap <C-Y> :bprevious<CR>
nnoremap <C-O> :bnext<C>
noremap <C-PageUp> gT<cr>
noremap <C-PageDown> gt<cr>
" Vim split windows movements
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"--- ALT KEYSTROKES (FAST OPERATIONS) ---"
nnoremap <A-c> :tabclose<CR>
nnoremap <A-x> :close<CR>
nnoremap <A-e> :NvimTreeFindFile<CR>
noremap <A-S-r> :silent exec "source ".g:rcfile<CR>:echo 'Source reloaded'<CR>
noremap <A-S-e> :echo 'asdfq'<CR>
" Tab switching
noremap <A-1> 1gt
noremap <A-2> 2gt
noremap <A-3> 3gt
noremap <A-4> 4gt
noremap <A-5> 5gt
noremap <A-6> 6gt
noremap <A-7> 7gt
noremap <A-8> 8gt
" FZF
nnoremap <A-p> :All<CR>
nnoremap <A-h> :History<CR>
nnoremap <A-b> :Buffers<CR>
nnoremap <A-w> :Windows<CR>
nnoremap <A-f> :Rg<CR>

"--- - LEADER ---"
let mapleader = "-"
" Vim Operations
nnoremap <leader>w :wa!<CR>
nnoremap <leader>q :wqa<CR>:
" File Tree and Explorer
nnoremap <leader>l :Lex<CR>
nnoremap <leader>t :NvimTreeFocus<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
" SWAP VIM WINDOWS WITH '-ww'
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>

"--- , LEADER ---"
let mapleader = ","
" QUICKFIX
noremap <leader>j :cn<CR>
noremap <leader>k :cp<CR>
" FZF VIM - shortcut operations
" Use word or visual selection to open search
noremap <leader>p yiw:All '<C-r>*'<CR>
noremap <leader>f yiw:Rgg <C-r>*<CR>
let mapleader = "-"
"noremap<A-S-k> <A-S-j> :cn<CR>
"noremap <A-S-k> :cp<CR>

" Simplifications
nnoremap <leader>8 :let @+ = expand("%")<CR>
nnoremap <leader>9 :let @+ = expand("%:t:r")<CR>
nnoremap <leader>0 :echo @%<CR>

" SpellChecker
imap <F8> 1z=
imap <F9> ]s
imap <F10> [s
noremap <F8> 1z=
noremap <F9> ]s
noremap <F10> [s
noremap <F20> 1z=
noremap <F21> ]s
noremap <F22> [s
noremap <F5> :setlocal spell! spelllang=en,es<CR>

" Visual mode pressing * or # searches for the current selection "
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR> 
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" New tab opens Scratch Buffer
nnoremap <A-t> :call TabNewWithScratchBuffer()<CR>

" Dont know.. appears something with terminal mode
tnoremap <expr> <C-v> '<C-\><C-N>pi'

"--- LATIN CHARS IN ENGLISH KEYBOARD ---"
inoremap [a á
inoremap [e é
inoremap [i í
inoremap [o ó
inoremap [u ú

"--- COC NVIM ---"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent> <space>a  :<C-u>CocFzfListDiagnostics<CR>
nnoremap <silent> <space>e  :<C-u>CocFzfListExtensions<CR>
nnoremap <silent> <space>l  :<C-u>CocFzfListLocation<CR>
nnoremap <silent> <space>o  :<C-u>CocFzfListOutline<CR>
nnoremap <silent> <space>p  :<C-u>CocFzfListResume<CR>
nnoremap <silent> <space>s  :<C-u>CocFzfListSymbols<CR>
nnoremap <silent> <space>S  :<C-u>CocFzfListServices<CR>

"--- NVIM LUA TREE ---"
lua <<EOF
    local tree_cb = require'nvim-tree.config'.nvim_tree_callback
    -- default mappings
    vim.g.nvim_tree_bindings = {
      { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
      { key = {"<2-RightMouse>", "<C-]>"},    cb = tree_cb("cd") },
      { key = "<C-v>",                        cb = tree_cb("vsplit") },
      { key = "<C-x>",                        cb = tree_cb("split") },
      { key = "<C-t>",                        cb = tree_cb("tabnew") },
      { key = "<",                            cb = tree_cb("prev_sibling") },
      { key = ">",                            cb = tree_cb("next_sibling") },
      { key = "P",                            cb = tree_cb("parent_node") },
      { key = "<BS>",                         cb = tree_cb("close_node") },
      { key = "<S-CR>",                       cb = tree_cb("close_node") },
      { key = "<Tab>",                        cb = tree_cb("preview") },
      { key = "K",                            cb = tree_cb("first_sibling") },
      { key = "J",                            cb = tree_cb("last_sibling") },
      { key = "I",                            cb = tree_cb("toggle_ignored") },
      { key = "H",                            cb = tree_cb("toggle_dotfiles") },
      { key = "R",                            cb = tree_cb("refresh") },
      { key = "a",                            cb = tree_cb("create") },
      { key = "d",                            cb = tree_cb("remove") },
      { key = "r",                            cb = tree_cb("rename") },
      { key = "<C-r>",                        cb = tree_cb("full_rename") },
      { key = "x",                            cb = tree_cb("cut") },
      { key = "c",                            cb = tree_cb("copy") },
      { key = "p",                            cb = tree_cb("paste") },
      { key = "y",                            cb = tree_cb("copy_name") },
      { key = "Y",                            cb = tree_cb("copy_path") },
      { key = "gy",                           cb = tree_cb("copy_absolute_path") },
      { key = "[c",                           cb = tree_cb("prev_git_item") },
      { key = "]c",                           cb = tree_cb("next_git_item") },
      --{ key = "-",                            cb = tree_cb("dir_up") },
      --{ key = "s",                            cb = tree_cb("system_open") },
      { key = "q",                            cb = tree_cb("close") },
      { key = "g?",                           cb = tree_cb("toggle_help") },
    }
EOF
