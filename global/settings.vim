"--- SWP & DIRECTORIES---"
set rtp+=~/.vim/bundle/Vundle.vim
set directory=/opt/vim/swapfiles//
set backupdir=/opt/vim/backup//
set undodir=/opt/vim/undo//

"--- VIM SETTINGS ---"
set mouse=a
set winaltkeys=no "Utilizar el Alt para mapings
set encoding=utf-8
set wildmenu "tab on menu
set wildmode=longest:full
set breakindent "para mostrar lineas en el editor identadas
set so=7 "keep centered cursor line
set hlsearch
set wrap
set cursorline "mostrar la linea sctiva del cursor con otro color
set nu
set ignorecase
set spelllang=en,es
set updatetime=250
set termguicolors
set history=500
set clipboard=unnamedplus
""syntax on

"--- GUI OPTIONS ---"
if exists('g:GtkGuiLoaded')
    let s:editorfont = 'Hack NF'
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

" SCROLL MOUSE (por eso no esta en keybindings)
noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a
