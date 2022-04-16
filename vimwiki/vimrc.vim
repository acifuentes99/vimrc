" INSTRUCTIONS "
" Set Environment variable: 
" ---> $VIMNOTES_NOTES_FOLDER
" , for using this vimrc.

"-- RC FILE PATH ---"
let vimwikifolder = $VIMNOTES_NOTES_FOLDER
let g:zettelkasten = vimwikifolder."/"
let g:zettelkasten_folder = "Z. Zettelkasten/"

call plug#begin()
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'vimwiki/vimwiki', { 'branch' : 'master' }
Plug 'junegunn/goyo.vim'
Plug 'mattn/calendar-vim'
Plug 'tpope/vim-surround' "Poder colocar en negrita cosas en markdown
Plug 'wesQ3/vim-windowswap'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } "Poder colocar en negrita cosas en markdown
Plug 'junegunn/fzf.vim' "Poder colocar en negrita cosas en markdown
"Plug 'michal-h21/vim-zettel'
Plug 'ayu-theme/ayu-vim'
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-SpellCheck'
Plug 'ferrine/md-img-paste.vim'
Plug 'junegunn/vim-easy-align'
Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
Plug 'acifuentes99/vim-snippets'
call plug#end()

" Import Utils
source $HOME/.config/nvim/vimrc/vimwiki/util.vim

"--- THEMING ---"
hi vertsplit ctermfg=238 ctermbg=238 term=NONE
set background=dark
let ayucolor="mirage"
colorscheme ayu
hi Normal guibg=NONE ctermbg=NONE
hi clear VimwikiBold
hi clear VimwikiItalic
hi def VimwikiBold term=bold cterm=bold gui=bold ctermfg=yellow guifg=#FFA759
hi def VimwikiItalic ctermfg=green guifg=#95E6CB

"--- VIM SETTINGS ---"
set mouse=a
"set winaltkeys=no "Utilizar el Alt para mapings
set encoding=utf-8
"set wildmenu "tab on menu
"set wildmode=longest:full
set breakindent "para mostrar lineas en el editor identadas
set so=7 "keep centered cursor line
set hlsearch
set wrap
set cursorline "mostrar la linea sctiva del cursor con otro color
"set nu
set ignorecase
set spelllang=en,es
set updatetime=250
set termguicolors
set history=500
set clipboard=unnamedplus

" Breakindent
set breakindent
set breakindentopt=shift:2

let g:windowswap_map_keys = 0 "prevent default bindings


"--- AUTOCMD ---"
augroup VimWikiNotes
    "execute "au BufNewFile "vimwikifolder."/diary/*.md :silent 0r !".vimwikifolder."/templates/diary.py '%'"
    "execute "au BufNewFile "vimwikifolder."/*.md :silent 0r !".vimwikifolder."/templates/zettelkasten.py '%'"
    autocmd FileType vimwiki map <Leader>c :call ToggleCalendar()<CR>
    autocmd FileType vimwiki map <Leader>d :put =strftime('%a %d %b %Y')<CR>
    "autocmd VimEnter * VimwikiIndex
    autocmd filetype markdown silent! iunmap <buffer> <Tab>
    autocmd filetype vimwiki silent! iunmap <buffer> <Tab>
    set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
augroup END

" Resize splits on terminal window resize
autocmd VimResized * wincmd =

" Autosave leaving insert mode
augroup AUTOSAVE
  au!
  autocmd InsertLeave,TextChanged,FocusLost * silent! write
augroup END



" -- NVIM TREE -- "
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

"--- KEYBINDINGS ---"
" Snippets
let g:UltiSnipsExpandTrigger="<TAB>"
" list all snippets for current filetype
let g:UltiSnipsListSnippets="<c-l>"

" Vimwiki
let mapleader = "-"
nnoremap <M-l> :AddFZFLink<CR>
nnoremap <CR> <Plug>VimwikiFollowLink
"nmap <leader>p :exec "edit ".g:vimwiki_projectfile<CR>
nnoremap <silent> , :<C-U>call OpenLinkInNumber()<CR>
nnoremap <Leader>i <Plug>VimwikiIndex
nnoremap <Leader>j <Plug>VimwikiDiaryIndex
nnoremap <space> :noh<CR>
nnoremap <leader>nz :NewZettel

" File Tree and Explorer
nnoremap <leader>l :Lex<CR>
nnoremap <leader>t :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <A-e> :NvimTreeFindFile<CR>

" Simplifications
nnoremap <leader>8 :let @+ = expand("%")<CR>
nnoremap <leader>9 :let @+ = expand("%:t:r")<CR>
nnoremap <leader>0 :echo @%<CR>

" Vim split windows movements
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Visual mode pressing * or # searches for the current selection "
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"--- ALT KEYSTROKES (FAST OPERATIONS) ---"
nnoremap <A-C-r> :silent exec "source ".g:rcfile<CR>:echo 'Source reloaded'<CR>
nnoremap <A-C-e> :echo 'asdfq'<CR>

" Buffer Management
nnoremap <C-Y> :bprevious<CR>
nnoremap <C-O> :bnext<C>
nnoremap <A-x> :close<CR>

" Tab Management
nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <C-PageUp> gT<cr>
nnoremap <C-PageDown> gt<cr>
nnoremap <A-c> :tabclose<CR>
" New tab opens Scratch Buffer
nnoremap <A-t> :call TabNewWithScratchBuffer()<CR>

" FZF
nnoremap <A-p> :All<CR>
nnoremap <A-h> :History<CR>
nnoremap <A-b> :Buffers<CR>
nnoremap <A-w> :Windows<CR>
nnoremap <A-f> :Rg<CR>

" English keyboard to Spanish characters
inoremap [a á
inoremap [e é
inoremap [i í
inoremap [o ó
inoremap [u ú
inoremap ; ñ
inoremap ;; ;

" Insert Mode Movement
inoremap <A-h> <C-o>h
inoremap <A-j> <C-o>j
inoremap <A-k> <C-o>k
inoremap <A-l> <C-o>l
inoremap <A-w> <C-o>w
inoremap <A-e> <C-o>e
inoremap <A-b> <C-o>b
inoremap <A-C-h> <C-o>0
inoremap <A-C-l> <C-o>$
inoremap <A-{> <C-o>{
inoremap <A-}> <C-o>}
"inoremap <A-char-62> <C-o>>><C-o>$
"inoremap <A-char-60> <C-o><<<C-o>$
inoremap <A-.> <C-o>>><C-o>$
inoremap <A-,> <C-o><<<C-o>$
inoremap <A-C-o> <C-o>:execute "normal \<Plug>VimwikiListO"<CR>
inoremap <A-C-d> <C-o>dd
inoremap <A-o> <C-o>:execute "normal \<Plug>VimwikiListo"<CR>
inoremap <A-q> <Esc>

" Quickfix
nnoremap <A-j> :cn<CR>
nnoremap <A-k> :cp<CR>
nnoremap <A-C-j> :clast<CR>
nnoremap <A-C-k> :cfirst<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xnoremap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nnoremap ga <Plug>(EasyAlign)

" Center cursor on move
nnoremap {  {zz
nnoremap }  }zz
nnoremap n  nzz
nnoremap N  Nzz
nnoremap [c [czz
nnoremap ]c ]czz
nnoremap [j <C-o>zz
nnoremap ]j <C-i>zz
nnoremap [s [szz
nnoremap ]s ]szz

" SpellChecker
nnoremap <F5> :setlocal spell! spelllang=en,es<CR>
inoremap <F8> 1z=
inoremap <F9> ]s
inoremap <F10> [s
nnoremap <F8> 1z=
nnoremap <F9> ]s
nnoremap <F10> [s
nnoremap <F20> 1z=
nnoremap <F21> ]s
nnoremap <F22> [s

"--- ',' LEADER ---"
let mapleader = ","
" FZF VIM - shortcut operations, Use word or visual selection to open search
noremap <leader>p yiw:All '<C-r>0'<CR>
noremap <leader>f yiw:Rgg <C-r>0<CR>
" Replace matching Word in visual mode
nnoremap <leader>r yiw:%s/<C-r>"//g<left><left>
vnoremap <leader>r :s/<C-r>"//g<left><left>
" Zoom current split
nnoremap <silent> <leader>z <C-W>_\|<C-W>\|
" Restart zooms
nnoremap <silent> <leader>= <C-W>=
" Shortcuts Vim
nnoremap <silent> <leader>n :set invnumber<CR>

" Final leader key
let mapleader = "-"
"--- END KEYBINDINGS ---"


" --- AUTOSTART OPERATIONS ---
function! s:initial_commands(t) abort
  echom "vim is ready"
  VimwikiMakeDiaryNote
  NvimTreeToggle
  exe "normal \<c-l>G"
endfunction

augroup user_cmds
  autocmd!
  autocmd VimEnter * call timer_start(20, function('s:initial_commands'))
augroup END


" SWAP VIM WINDOWS WITH ',ww'
"nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
"nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
"nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>
"nmap <Leader>wf <Plug>VimwikiFollowLink
"nmap <NL> <Plug>VimwikiFollowLink
"nmap <Leader><CR> <Plug>VimwikiFollowLink
"nnoremap <CR> :noh<CR>

