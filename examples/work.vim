"', 'down': '40%', 'options': fzfOptions-------------------------"
"--- CONFIGURACION VIM ---"
"-------------------------"
let s:editorfont = 'Hack NF'
"--------------------------"
"--- SYNTAX AND LYNTING ---"
"--------------------------"
set termguicolors 
set history=500
set autoread "reload written file
set so=7 "keep centered cursor line
set wildmenu "tab on menu
set wildmode=longest:full
set ignorecase
set encoding=utf-8
set spelllang=es
set hlsearch
set breakindent "para mostrar lineas en el editor identadas
set wrap
set nu
set mouse=a "opciones de mouse
set updatetime=250
set nofixendofline
set clipboard+=unnamedplus
set cursorline "mostrar la linea sctiva del cursor con otro color
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
filetype plugin indent on
syntax on

if exists('g:GtkGuiLoaded')
	let s:fontsize = 12
	call rpcnotify(1, 'Gui', 'Font', s:editorfont . ' 13')
	function! AdjustFontSize(amount)
		let s:fontsize = s:fontsize+a:amount
		call rpcnotify(1, 'Gui', 'Font', s:editorfont . ' ' . s:fontsize)
	endfunction
else
	let s:fontsize = 12
	function! AdjustFontSize(amount)
		let s:fontsize = s:fontsize+a:amount
		:execute "GuiFont! " . s:editorfont . ":h" . s:fontsize
	endfunction
endif

noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a



"--- SWP & DIRECTORIES ---"
set rtp+=~/.vim/bundle/Vundle.vim
set directory=/opt/vim/swapfiles//
set backupdir=/opt/vim/backup//
set undodir=/opt/vim/undo//

"--- PLUGINS ---"
call plug#begin()
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree' " Plug de cambio de archivos
Plug 'jistr/vim-nerdtree-tabs' "Inegrar nerdtree con tabs de vim
Plug 'ryanoasis/vim-devicons'
Plug 'wesQ3/vim-windowswap'
Plug 'triglav/vim-visual-increment'
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

"--- THEMING ---"
set fillchars+=vert:\ 
hi vertsplit ctermfg=238 ctermbg=238 term=NONE
set showtabline=2
set background=dark
let ayucolor="mirage"
colorscheme ayu
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red
hi SpellBad gui=undercurl


"----------------------------"
"--- PLUGIN CONFIGURATION ---"
"----------------------------"

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
nmap <silent> <leader>b :TagbarToggle<CR>

"" -- NERDTREE -- "
let g:NERDTreeMouseMode = 3
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowBookmarks = 1
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
set autoread
map <F2> :NERDTreeToggle<CR>
map <Leader>nt :NERDTree %:p:h<CR>
"get rid of [  ] around icons in NerdTree
syntax enable
if exists("g:loaded_webdevicons")
	call webdevicons#refresh()
endif


" -- NERDTREE TABS -- "
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



"--------------------------"
"--- KEYBOARD SHORTCUTS ---"
"--------------------------"

" WINDOW MOVEMENT
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" TABS
nmap <C-PageUp> gT<cr>
nmap <C-PageDown> gt<cr>
" CHANGE BUFFFER WITH CTRL
nnoremap <C-Y> :bprevious<CR>
nnoremap <C-O> :bnext<CR>
" SPELLCHECKER
map <S-F8> 1z=
map <S-F9> ]s
map <S-F10> [s
map <F20> 1z=
map <F21> ]s
map <F22> [s
" FAST SAVING
nmap <leader>w :w!<cr>
let mapleader = "-"
" CLEAR HIGHTLIGHT SEARCH
nnoremap <CR> :noh<CR><CR>
" :W sudo saves the file 
command W w !sudo tee % > /dev/null
" SWAP VIM WINDOWS WITH '-ww'
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>
" Visual mode pressing * or # searches for the current selection "
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR> 
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
map 0 ^
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm


"------------------------"
"--- HELPER FUNCTIONS ---"
"------------------------"

" Returns true if paste mode is enabled
function! HasPaste()
		if &paste
				return 'PASTE MODE  '
		endif
		return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
	 let l:currentBufNum = bufnr("%")
	 let l:alternateBufNum = bufnr("#")

	 if buflisted(l:alternateBufNum)
		 buffer #
	 else
		 bnext
	 endif

	 if bufnr("%") == l:currentBufNum
		 new
	 endif

	 if buflisted(l:currentBufNum)
		 execute("bdelete! ".l:currentBufNum)
	 endif
endfunction

function! CmdLine(str)
		exe "menu Foo.Bar :" . a:str
		emenu Foo.Bar
		unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
		let l:saved_reg = @"
		execute "normal! vgvy"

		let l:pattern = escape(@", "\\/.*'$^~[]")
		let l:pattern = substitute(l:pattern, "\n$", "", "")

		if a:direction == 'gv'
				call CmdLine("Ack '" . l:pattern . "' " )
		elseif a:direction == 'replace'
				call CmdLine("%s" . '/'. l:pattern . '/')
		endif

		let @/ = l:pattern
		let @" = l:saved_reg
endfunction

" --- CONFIG ESPECIAL EXTENSIONES --- "
"-------------------------------------"

" -- FZF KeyBindings -- "
"https://medium.com/headwayio/customize-a-fast-search-with-fuzzy-finder-for-vim-e6ce4271954f
let g:fzf_preview_window = ''
let g:fzf_layout = { 'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8, 'yoffset':0.5, 'xoffset': 0.5, 'border': 'sharp' } }
let fzfOptions = '
        \ --prompt=""
        \ --multi
        \ --margin=1,2
        \ --layout=reverse
        \ --expect=ctrl-t,ctrl-x,ctrl-v
    \'

command! -bang -nargs=*  All
  \ call fzf#run(fzf#wrap({'source': 'rg -l --files --hidden --no-ignore-vcs --glob "!{node_modules/*,.git/*,.tmp-metadata/*}"', 'options': fzfOptions }))

nnoremap <A-p> :All<CR>
nnoremap <A-h> :History<CR>
nnoremap <A-b> :Buffers<CR>
nnoremap <A-w> :Windows<CR>
nnoremap <A-f> :Rg<CR>
nnoremap <A-c> :tabclose<CR>
nnoremap <A-x> :close<CR>
nnoremap ZZ :wa<CR>
nnoremap __ :qa<CR>
nnoremap <A-8> :let @+ = expand("%")<CR>
nnoremap <A-9> :let @+ = expand("%:t:r")<CR>
nnoremap <A-0> :echo @%<CR>
nnoremap <silent> <A-e> :NERDTreeFind<CR>
nnoremap <leader>w :wa!<CR>
nnoremap <leader>l :Lex<CR>
tnoremap <expr> <C-v> '<C-\><C-N>pi'
map <F5> :setlocal spell! spelllang=en,es<CR>

inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O



" coc.nvim config start
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" if hidden is not set, TextEdit might fail.
set hidden
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" nnoremap <silent> <space>c  :<C-u>CocFzfListCommands<cr>
nnoremap <silent> <space>a  :<C-u>CocFzfListDiagnostics<CR>
nnoremap <silent> <space>e  :<C-u>CocFzfListExtensions<CR>
nnoremap <silent> <space>l  :<C-u>CocFzfListLocation<CR>
nnoremap <silent> <space>o  :<C-u>CocFzfListOutline<CR>
nnoremap <silent> <space>p  :<C-u>CocFzfListResume<CR>
nnoremap <silent> <space>s  :<C-u>CocFzfListSymbols<CR>
nnoremap <silent> <space>S  :<C-u>CocFzfListServices<CR>
" coc.nvim config end

" BufEnter Auto commands {{{
augroup set_filetype
  :autocmd!
  :autocmd BufEnter *.cmp,*.evt,*.design :set filetype=html " Salesforce files
  :autocmd BufEnter *.tsx :set filetype=typescript.tsx
  :autocmd BufEnter *.jsx :set filetype=javascript.jsx
augroup END

augroup filetype_apexcode
  :autocmd FileType apexcode* :setlocal shiftwidth=4 tabstop=4 foldmethod=indent
augroup END

au BufNewFile,BufRead *.cmp set filetype=html
au BufNewFile,BufRead *.cls set filetype=apexcode
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()


function! TabNewWithScratchBuffer()
    execute "tabnew" 
    set buftype=nofile
    set bufhidden=hide
    setlocal noswapfile
endfunction
nnoremap <A-t> :call TabNewWithScratchBuffer()<CR>

" Switch between tabs
nmap <A-1> 1gt
nmap <A-2> 2gt
nmap <A-3> 3gt
nmap <A-4> 4gt
nmap <A-5> 5gt
nmap <A-6> 6gt
"tnoremap <S-Esc> <C-\><C-n>

" Quickfix
nmap <A-S-j> :cn<CR>
nmap <A-S-k> :cp<CR>

autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
