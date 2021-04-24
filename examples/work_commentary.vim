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
"set lazyredraw 
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
"runtime macros/matchit.vim
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
filetype plugin indent on
"set nocompatible
"filetype plugin on
syntax on
"hi LineNr ctermbg=bg
"set foldcolumn=2
"hi foldcolumn ctermbg=bg
"hi VertSplit ctermbg=bg ctermfg=bg
if exists('g:GtkGuiLoaded')
	let s:fontsize = 12
	call rpcnotify(1, 'Gui', 'Font', s:editorfont . ' 13')
	function! AdjustFontSize(amount)
		let s:fontsize = s:fontsize+a:amount
		"call rpcnotify(1, 'Gui', 'Font', 'DejaVuSansMono NF 12')
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
"Plug 'mg979/vim-visual-multi'
Plug 'kshenoy/vim-signature' "Show name of vim marks
Plug 'mattn/emmet-vim' 
Plug 'neowit/vim-force.com' 
Plug 'OrangeT/vim-csharp'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'voldikss/vim-floaterm'
"Plug 'airblade/vim-gitgutter' "Mostrar cambios en Git dentro de archivos
Plug 'vim-syntastic/syntastic' 
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
"Plug 'wikitopian/hardmode'
".call HardMode()
":call EasyMode
"Plug 'vifm/vifm.vim'
" - ESCRITURA -"
"Plug 'vimwiki/vimwiki', {'on': 'VimwikiIndex'}
"Plug 'junegunn/goyo.vim', {'on': 'VimwikiIndex'}
"Plug 'itchyny/calendar.vim', {'on': 'VimwikiIndex'}
" - SYNTAX -"
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
"Plug 'posva/vim-vue', {'for': 'javascript'}
Plug 'nvie/vim-flake8', {'for': 'python'}
"Plug 'lepture/vim-jinja'
"Plug 'mxw/vim-jsx'
"Plug 'cakebaker/scss-syntax.vim'
"Plug 'PotatoesMaster/i3-vim-syntax', {'for': 'i3'}
" - THEMES -"
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'adampasz/stonewashed-themes'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'romainl/Apprentice'
Plug 'tomasiser/vim-code-dark'
Plug 'ayu-theme/ayu-vim'
" - FUNCIONAMIENTO - "
"Plug 'tpope/vim-vinegar' "Abrir NerdTree con -
"Plug 'skywind3000/asyncrun.vim'
"Plug 'xuyuanp/nerdtree-git-plugin' "Mostrar cambios de Git en NerdTree
call plug#end()
" - OLD PLUGS - "
"Plug 'fweep/vim-tabber' "Name tabs
"Plug 'bsdelf/bufferhint' "Cambio de Buffers facil
"Plug 'bagrat/vim-buffet' " Integrar workspace para tags y buffers
"Plug 'HTML-AutoCloseTag'
"Plug 'vim-latex/vim-latex'
"Plug 'gabenespoli/vim-cider-vinegar'
"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-easytags'
"Plug 'majutsushi/tagbar' 
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight' 

"--- THEMING ---"
set fillchars+=vert:\ 
hi vertsplit ctermfg=238 ctermbg=238 term=NONE
""set tabline=%!tabber#TabLine()
"autocmd FileType less set omnifunc=csscomplete#CompleteCSS
set showtabline=2
set background=dark
"colorscheme apprentice
let ayucolor="mirage"
colorscheme ayu
""let g:airline_theme = 'luna'
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red
" Set style for gVim
hi SpellBad gui=undercurl
"hi Normal ctermbg=none
"codedark apprentice"


"----------------------------"
"--- PLUGIN CONFIGURATION ---"
"----------------------------"

" -- DEVICONS CONFIG -- "
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_nerdtree = 1
""let g:webdevicons_enable_airline_tabline = 1
""let g:webdevicons_enable_airline_statusline = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
"let g:WebDevIconsUnicodeGlyphDoubleWidth = 1

" -- AIRLINE -- "
set laststatus=2
"let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 1
"let g:airline_detect_paste=1
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#show_buffers = 0
"let g:airline#extensions#tabline#show_splits = 0
"let g:airline#extensions#tabline#show_tabs = 1
"let g:airline#extensions#tabline#show_tab_nr = 0
"let g:airline#extensions#tabline#show_tab_type = 0
"let g:airline#extensions#tabline#close_symbol = '×'
"let g:airline#extensions#tabline#show_close_button = 0
"let g:airline#extensions#default#section_truncate_width = {
""      \ 'b': 79,
""      \ 'x': 60,
""      \ 'y': 88,
""      \ 'z': 45,
""      \ 'warning': 80,
""      \ 'error': 80,
""      \ }

" -- BUFFET -- "
let g:buffet_powerline_separators = 1
let g:buffet_use_devicons = 1

" -- SYNTASTIC -- "
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_python_checkers=['pyflakes']
"let g:syntastic_javascript_checkers = ['jshint']
" let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_error_symbol = '✘'
"let g:syntastic_warning_symbol = "▲"
"augroup mySyntastic
"  au!
"  au FileType tex let b:syntastic_mode = "passive"
"augroup END
":hi clear SignColumn


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
" -- VIM-EASYTAGS -- "
" " Where to look for tags files
"set tags=./tags;,~/.vimtags
" Sensible defaults
"let g:easytags_events = ['BufReadPost', 'BufWritePost']
"let g:easytags_async = 1
"let g:easytags_dynamic_files = 2
"let g:easytags_resolve_links = 1
"let g:easytags_suppress_ctags_warning = 1

" -- TAGBAR -- "
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)

"" -- NERDTREE -- "
"let g:jsx_ext_required = 1
let g:NERDTreeMouseMode = 3
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowBookmarks = 1
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
set autoread
map <F2> :NERDTreeToggle<CR>
" open Nerd Tree in folder of file in active buffer
map <Leader>nt :NERDTree %:p:h<CR>
" https://superuser.com/questions/782350/change-current-directory-using-nerdtree

" -- NERDTREE TABS -- "
" Open/close NERDTree Tabs with \t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
" To have NERDTree always open on startup
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


"" -- GITGUTTER --  "
"let g:gitgutter_terminal_reports_focus=0
"let g:gitgutter_sign_added = '✚'
"let g:gitgutter_sign_modified = '✹'
"let g:gitgutter_sign_removed = '✖'
"let g:gitgutter_sign_removed_first_line = '^^'
"let g:gitgutter_sign_modified_removed = 'ww'

" -- EXTRA POWERLINE SYMBOLS -- "
"https://github.com/ryanoasis/powerline-extra-symbols
" set font terminal font or set gui vim font to a Nerd Font (https://github.com/ryanoasis/nerd-fonts):
"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ Mono\ 12
" testing rounded separators (extra-powerline-symbols):
"let g:airline_left_sep = "\uE0B4"
"let g:airline_right_sep = "\uE0B6"
"let g:airline_left_sep = "\uE0C0"
"let g:airline_right_sep = "\uE0C2"
" set the CN (column number) symbol:
"let g:airline_section_z = airline#section#create(["\uE0A1" . '%{line(".")}' . "\uE0A3" . '%{col(".")}'])
"let g:airline_section_z = airline#section#create(["\uE0A1" . '%{line(".")}' . "\uE0CF" . '%{col(".")}'])

" -- CTRL-P -- "
"let g:ctrlp_working_path_mode = 0
"let g:ctrlp_map = '<c-p>'
"map <leader>j :CtrlP<cr>
"map <c-b> :CtrlPBuffer<cr>
"let g:ctrlp_max_height = 20
"let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

" -- VIMWIKI -- "
"  Configuración se encuentra en .vimrc especial para vimwiki
"  en ~/bin/vimrc/wim_wiki.vim
"nmap <Leader>i <Plug>VimwikiIndex
"nmap <Leader>j <Plug>VimwikiDiaryIndex
":nmap <Leader>wf <Plug>VimwikiFollowLink
nmap <NL> <Plug>VimwikiFollowLink
let g:netrw_liststyle=3

let g:user_emmet_leader_key=','



"--------------------------"
"--- KEYBOARD SHORTCUTS ---"
"--------------------------"

" Vim split windows movements "
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"set <M-h>=\eh
"set <M-j>=\ej
"set <M-k>=\ek
"set <M-l>=\el
"nnoremap <M-h> <C-W>5<
"nnoremap <M-j> <C-W>5-
"nnoremap <M-k> <C-W>5+
"nnoremap <M-l> <C-W>5>
" Tab Movement "
nmap <C-PageUp> gT<cr>
nmap <C-PageDown> gt<cr>
" Buffer Changing with CTRL "
nnoremap <C-Y> :bprevious<CR>
nnoremap <C-O> :bnext<CR>
" Corrector Ortografico "
map <S-F8> 1z=
map <S-F9> ]s
map <S-F10> [s
map <F20> 1z=
map <F21> ]s
map <F22> [s
" Fast saving "
nmap <leader>w :w!<cr>
let mapleader = "-"
" Clear Highlight Search "
nnoremap <CR> :noh<CR><CR>
" :W sudo saves the file 
command W w !sudo tee % > /dev/null
" Swap Vim windows with '-ww'
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

" -- .TEX -- "
autocmd BufWritePost *.tex :AsyncRun xelatex --pdf main.tex

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
        "\ --color=
        "    \fg:4,
        "    \bg:16,
        "    \fg+:7,
        "    \bg+:16,
        "    \preview-bg:16,
        "    \hl:17,
        "    \hl+:19,
        "    \gutter:16,
        "    \info:16,
        "    \prompt:10,
        "    \pointer:12,
        "    \marker:4,
        "    \spinner:11,
        "    \header:16

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
"https://vim.fandom.com/wiki/Get_the_name_of_the_current_file"
nnoremap <A-8> :let @+ = expand("%")<CR>
nnoremap <A-9> :let @+ = expand("%:t:r")<CR>
nnoremap <A-0> :echo @%<CR>
nnoremap <silent> <A-e> :NERDTreeFind<CR>
nnoremap <leader>w :wa!<CR>
nnoremap <leader>l :Lex<CR>
tnoremap <expr> <C-v> '<C-\><C-N>pi'
map <F5> :setlocal spell! spelllang=en,es<CR>

"inoremap " ""<left>
"inoremap ' ''<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>
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
  " Open Nerd tree in Projects folder
  :autocmd BufEnter *.cmp,*.evt,*.design :set filetype=html " Salesforce files
  :autocmd BufEnter *.tsx :set filetype=typescript.tsx
  :autocmd BufEnter *.jsx :set filetype=javascript.jsx
  " :autocmd TabEnter * :NERDTree Documents/Projects/ 
augroup END
" End BufEnter Auto commands }}}

" apexcode FileType Auto commands{{{
augroup filetype_apexcode
  ":autocmd!
  ":autocmd FileType apexcode* :setlocal shiftwidth=4 tabstop=4 foldmethod=indent foldlevel=0 foldlevelstart=0
  :autocmd FileType apexcode* :setlocal shiftwidth=4 tabstop=4 foldmethod=indent
augroup END
" End apex FileType Auto commands}}}
"
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


"get rid of [  ] around icons in NerdTree
syntax enable
if exists("g:loaded_webdevicons")
	call webdevicons#refresh()
endif

autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
