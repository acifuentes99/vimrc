"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath=&runtimepath
set winaltkeys=no "Utilizar el Alt para mapings
set tabstop=2
set shiftwidth=2
set mouse=a
set so=7 "keep centered cursor line
set wildmenu "tab on menu
set wildmode=longest:full
set ignorecase
set encoding=utf-8
set spelllang=en,es
set hlsearch
set breakindent "para mostrar lineas en el editor identadas
set wrap
set nu
set updatetime=250
set cursorline "mostrar la linea sctiva del cursor con otro color
"let vimwikifolder = /media/files/Notes
let vimwikifolder = "/home/aczombie/Sync/Notes"

set rtp+=~/.vim/bundle/Vundle.vim
set directory=/opt/vim/swapfiles//
set backupdir=/opt/vim/backup//
set undodir=/opt/vim/undo//

hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red

call plug#begin()
Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'
Plug 'mattn/calendar-vim'
Plug 'tpope/vim-surround' "Poder colocar en negrita cosas en markdown
Plug 'wesQ3/vim-windowswap'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } "Poder colocar en negrita cosas en markdown
Plug 'junegunn/fzf.vim' "Poder colocar en negrita cosas en markdown
Plug 'michal-h21/vim-zettel'
call plug#end()

"--- GLOBAL CONFIGURATIONS ---"
source /home/aczombie/rice/vimrc/vim_utils.vim
source /home/aczombie/rice/vimrc/keystrokes.vim

" VIM WIKI
let g:vimwiki_list = [{'path': vimwikifolder,
                \ 'syntax': 'markdown', 
                \ 'ext': '.md',
                \ 'links_space_char': '_',
                \ 'nested_syntaxes': {'js': 'javascript', 'py': 'python'}}]
let g:vimwiki_markdown_link_ext = 1

" VIM ZETTLE
let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always"
"let g:zettel_fzf_options = ['--exact', '--tiebreak=end']
let g:zettel_format = "%y%m%d-%H%M-%title"
let g:zettel_link_format="[%title](%link)"


" -- VIMWIKI -- "
let mapleader = "-"
nmap <Leader>i <Plug>VimwikiIndex
nmap <Leader>j <Plug>VimwikiDiaryIndex
"nmap <Leader>wf <Plug>VimwikiFollowLink
"nmap <NL> <Plug>VimwikiFollowLink
"nmap <Leader><CR> <Plug>VimwikiFollowLink
"nnoremap <CR> :noh<CR>
nnoremap <space> :noh<CR>
let g:netrw_liststyle=3

"au BufRead,BufNewFile *.wiki set filetype=vimwiki
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
autocmd FileType vimwiki map <Leader>c :call ToggleCalendar()<CR>
autocmd FileType vimwiki map <Leader>d :put =strftime('%a %d %b %Y')<CR>
autocmd VimEnter * VimwikiIndex

" Surround VIM

" Cambiar mapping de ¡, para que al utilziar surround, lo cambie a dos *
" https://github.com/tpope/vim-surround/issues/202
" Uso : Selección visual -> S¡  (o 'S', y luego el char con que quiere hacerse
" el encierro)
augroup initvim
  au!
  autocmd FileType markdown let b:surround_161 = "**\r**"
augroup END


" Zettelkasten
let g:zettelkasten = vimwikifolder."/Zettelkasten/"
command! -nargs=1 NewZettel :execute ":e" zettelkasten . strftime("%Y%m%d%H%M") . "-<args>.md"
nnoremap <leader>nz :NewZettel 
"nnoremap <leader>nz :ZettelNew 

" FZF "
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, <bang>0)

"nnoremap <C-p> :FZF<CR> 
"let g:fzf_action = {
"	\ 'ctrl-t': 'tab split',
"	\ 'ctrl-i': 'split',
"	\ 'ctrl-v': 'vsplit' }

" RIPGREP
let g:rg_highlight = 'true'

" Agregar busqueda de FZF como link a nota actual
function! HandleFZF(file)
    "let filename = fnameescape(fnamemodify(a:file, ":t"))
    "why only the tail ?  I believe the whole filename must be linked unless everything is flat ...
    let filename = fnameescape(a:file)
    let filename_wo_timestamp = fnameescape(fnamemodify(a:file, ":t:s/^[0-9]*-//"))
     " Insert the markdown link to the file in the current buffer
    let mdlink = "[".filename_wo_timestamp."](".filename.")"
    put=mdlink
endfunction

"Keybindings
command! -nargs=1 HandleFZF :call HandleFZF(<f-args>)
command! -bang -nargs=? -complete=dir AddFZFLink call fzf#run({'sink': 'HandleFZF', 'window': {'width': 0.9, 'height': 0.6}})

nnoremap <M-l> :AddFZFLink<CR>
nmap <A-CR> <Plug>VimwikiFollowLink

map <leader>r :Goyo 80%x90%<CR>
execute "map <leader>p :edit "vimwikifolder."/Proyectos.md<CR>"
map <F5> :setlocal spell! spelllang=en,es<CR>

"autocmd VimResized * if exists('#goyo') | exe "normal \<c-w>=" | endif
"autocmd VimEnter * Goyo 80%x90%
execute "au BufNewFile "vimwikifolder."/diary/*.md :silent 0r !/home/aczombie/rice/scripts/vimWikiScripts/generate-vimwiki-diary-template '%'"
execute "au BufNewFile "vimwikifolder."/Zettelkasten/*.md :silent 0r !/home/aczombie/rice/scripts/vimWikiScripts/generate-vimwiki-zettelkasten-template '%'"
"execute "au BufWritePost * silent !/media/files/bin/vimrc/gitAmend.sh ".getcwd()


function! OpenLinkInNumber()
    let vcount = v:count
    execute "normal! " . vcount . "gg" 
    execute "VimwikiNextLink"
    "execute "VimwikiFollowLink"
endfunction
nnoremap <silent> , :<C-U>call OpenLinkInNumber()<CR>


hi VimwikiBold ctermfg=214
