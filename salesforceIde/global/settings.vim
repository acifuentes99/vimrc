"--- SWP & DIRECTORIES---"
"set rtp+=~/.vim/bundle/Vundle.vim
set directory=/opt/vim/swapfiles//
set backupdir=/opt/vim/backup//
set undodir=/opt/vim/undo//

"--- VIM SETTINGS ---"
set autoread "reload written file
set breakindent "para mostrar lineas en el editor identadas
set clipboard=unnamedplus
set cursorline "mostrar la linea sctiva del cursor con otro color
set encoding=utf-8
set hidden
set history=500
set hlsearch
set ignorecase
set mouse=a
set nofixendofline
"set number relativenumber
set so=7 "keep centered cursor line
set spelllang=en,es
set termguicolors 
set updatetime=250
set wildmenu "tab on menu
set wildmode=longest:full
set winaltkeys=no "Utilizar el Alt para mapings
set wrap
"set shortmess-=F

set nobackup
set nowritebackup
set shortmess+=c
set cmdheight=2

"--- OTHER SETTINGS ---"
filetype plugin indent on
syntax on

"--- TAB & SPACES (DEPENDS OF FILE IN THE FUTURE) ---"
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

"--- GUI OPTIONS ---"
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


"--- THEMING ---"
set fillchars+=vert:\ 
hi vertsplit ctermfg=238 ctermbg=238 term=NONE
set background=dark
let ayucolor="mirage"
colorscheme ayu
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red
hi SpellBad gui=undercurl

let g:lightline = {
      \ 'colorscheme': 'one',
      \ }


" Breakindent
set breakindent
set breakindentopt=shift:2
set showbreak=↳


"ab json %!python -m json.tool

" WSL clipbaord

if (IsWSL())
    set clipboard+=unnamedplus
    let g:clipboard = {
              \   'name': 'win32yank-wsl',
              \   'copy': {
              \      '+': 'win32yank.exe -i --crlf',
              \      '*': 'win32yank.exe -i --crlf',
              \    },
              \   'paste': {
              \      '+': 'win32yank.exe -o --lf',
              \      '*': 'win32yank.exe -o --lf',
              \   },
              \   'cache_enabled': 0,
              \ }
endif

"Autosave leaving insert mode
augroup AUTOSAVE
  au!
  autocmd InsertLeave,TextChanged,FocusLost * silent! write
augroup END


if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
