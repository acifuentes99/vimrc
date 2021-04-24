"--- RC FILE PATH ---"
let g:rcfile = "/home/aczombie/rice/vimrc/default.vim"

"--- PLUGINS ---"
call plug#begin()
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree' " Plug de cambio de archivos
Plug 'jistr/vim-nerdtree-tabs' "Inegrar nerdtree con tabs de vim
Plug 'ryanoasis/vim-devicons'
Plug 'wesQ3/vim-windowswap'
Plug 'triglav/vim-visual-increment'
Plug 'mg979/vim-visual-multi'
Plug 'kshenoy/vim-signature' "Show name of vim marks
Plug 'mattn/emmet-vim'
Plug 'neowit/vim-force.com'
Plug 'OrangeT/vim-csharp'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-syntastic/syntastic'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
" - SYNTAX -"
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'nvie/vim-flake8', {'for': 'python'}
" - THEMES -"
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'adampasz/stonewashed-themes'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'romainl/Apprentice'
Plug 'tomasiser/vim-code-dark'
Plug 'ayu-theme/ayu-vim'
call plug#end()

"--- GLOBAL CONFIGURATIONS ---"
source /home/aczombie/rice/vimrc/global.vim

"--- SYNTAX AND LYNTING ---"
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
filetype plugin indent on

"--- THEMING ---"
set fillchars+=vert:\
hi vertsplit ctermfg=238 ctermbg=238 term=NONE
set showtabline=2
set background=dark
let ayucolor="mirage"
colorscheme ayu
"hi clear SpellBad
"hi SpellBad cterm=underline ctermfg=red
hi SpellBad gui=undercurl
hi Normal guibg=NONE ctermbg=NONE


" -- DEVICONS CONFIG -- "
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_nerdtree = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" -- AIRLINE -- "
set laststatus=2

" -- BUFFET -- "
let g:buffet_powerline_separators = 1
let g:buffet_use_devicons = 1

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

" -- TAGBAR -- "
nmap <silent> <leader>b :TagbarToggle<CR>

"" -- NERDTREE -- "
let g:NERDTreeMouseMode = 3
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
set autoread
map <F2> :NERDTreeToggle<CR>
map <Leader>nt :NERDTree %:p:h<CR>
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_console_startup = 0
let NERDTreeShowBookmarks=1
let g:NERDTreeIndicatorMapCustom = {
            \ "Modified"  : "✹",
            \ "Staged"    : "✚",
            \ "Untracked" : "✭",
            \ "Renamed"   : "➜",
            \ "Unmerged"  : "═",
            \ "Deleted"   : "✖",
            \ "Dirty"     : "✗",
            \ "Clean"     : "✔︎",
            \ 'Ignored'   : '☒',
            \ "Unknown"   : "?"
            \ }
let g:netrw_liststyle=3
let g:user_emmet_leader_key=','


"--- KEYBOARD SHORTCUTS ---"

nnoremap <silent> <A-e> :NERDTreeFind<CR>
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
nnoremap <leader>l :Lex<CR>


"--- COC NVIM ---"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set shortmess+=c
set signcolumn=yes
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

" Salesforce custom config
" BufEnter Auto commands {{{
augroup set_filetype
    :autocmd!
    :autocmd BufEnter *.cmp,*.evt,*.design :set filetype=html " Salesforce files
    :autocmd BufEnter *.tsx :set filetype=typescript.tsx
    :autocmd BufEnter *.jsx :set filetype=javascript.jsx
augroup END

" apexcode FileType Auto commands{{{
augroup filetype_apexcode
    :autocmd!
    :autocmd FileType apexcode* :setlocal shiftwidth=4 tabstop=4 foldmethod=indent foldlevel=0 foldlevelstart=0
augroup END

au BufNewFile,BufRead *.cmp set filetype=html
au BufNewFile,BufRead *.cls set filetype=apexcode
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
