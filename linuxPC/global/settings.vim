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
set number relativenumber
set so=7 "keep centered cursor line
set spelllang=en,es
set termguicolors 
set updatetime=250
set wildmenu "tab on menu
set wildmode=longest:full
set winaltkeys=no "Utilizar el Alt para mapings
set wrap

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
