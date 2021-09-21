"--- RC FILE PATH ---"
"let g:rcfile = "/home/acifuentes/vimrc/vim_wiki.vim"
"let g:vimwiki_projectfile = $VIMNOTES_NOTES_FOLDER/proyectos.md
let vimwikifolder = $VIMNOTES_NOTES_FOLDER
let g:zettelkasten = vimwikifolder."/"
let g:zettelkasten_folder = ""

call plug#begin()
Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'
Plug 'mattn/calendar-vim'
Plug 'tpope/vim-surround' "Poder colocar en negrita cosas en markdown
Plug 'wesQ3/vim-windowswap'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } "Poder colocar en negrita cosas en markdown
Plug 'junegunn/fzf.vim' "Poder colocar en negrita cosas en markdown
Plug 'michal-h21/vim-zettel'
Plug 'ayu-theme/ayu-vim'
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-SpellCheck'
Plug 'ferrine/md-img-paste.vim'
Plug 'junegunn/vim-easy-align'
call plug#end()

"--- GLOBAL CONFIGURATIONS ---"
source $DOTFILES_FOLDER/vimrc/default/global.vim

" VIM WIKI
let g:vimwiki_list = [{'path': vimwikifolder,
                \ 'syntax': 'markdown', 
                \ 'ext': '.md',
                \ 'links_space_char': '_',
                \ 'nested_syntaxes': {'js': 'javascript', 'py': 'python'}}]
let g:vimwiki_markdown_link_ext = 1
let g:netrw_liststyle=3

" VIM ZETTLE
let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always"
let g:zettel_format = "%y%m%d-%H%M-%title"
let g:zettel_link_format="[%title](%link)"

" Surround VIM
" Cambiar mapping de ¡, para que al utilziar surround, lo cambie a dos *
" https://github.com/tpope/vim-surround/issues/205
" Uso : Selección visual -> S¡  (o 'S', y luego el char con que quiere hacerse
" el encierro)
augroup initvim
  au!
  autocmd FileType markdown let b:surround_56 = "**\r**"
  autocmd FileType vimwiki let b:surround_56 = "**\r**"
augroup END

" Zettelkasten
"command! -nargs=1 NewZettel :execute ":e" zettelkasten . strftime("%Y%m%d%H%M") . "-<args>.md"
function! NewZettel(name)
    "execute ":e" g:zettelkasten_folder . strftime("%Y%m%d%H%M") . "-". a:name .".md"
    exe "normal! a[" . a:name . "](" . g:zettelkasten_folder . strftime("%Y%m%d%H%M") . "-". a:name .".md)\<Esc>"
endfunction
command! -nargs=1 NewZettel :call NewZettel(<f-args>)


" RIPGREP
let g:rg_highlight = 'true'


"--- UTILITY ---"

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

command! -nargs=1 HandleFZF :call HandleFZF(<f-args>)
command! -bang -nargs=? -complete=dir AddFZFLink call fzf#run({'sink': 'HandleFZF', 'window': {'width': 0.9, 'height': 0.6}})


function! OpenLinkInNumber()
    let vcount = v:count
    execute "normal! " . vcount . "gg" 
    execute "VimwikiNextLink"
    "execute "VimwikiFollowLink"
endfunction

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


"--- KEYBINDINGS ---"
nnoremap <M-l> :AddFZFLink<CR>
nmap <CR> <Plug>VimwikiFollowLink
"nmap <leader>p :exec "edit ".g:vimwiki_projectfile<CR>
map <F5> :setlocal spell! spelllang=en,es<CR>
nnoremap <silent> , :<C-U>call OpenLinkInNumber()<CR>
let mapleader = "-"
nmap <Leader>i <Plug>VimwikiIndex
nmap <Leader>j <Plug>VimwikiDiaryIndex
"nmap <Leader>wf <Plug>VimwikiFollowLink
"nmap <NL> <Plug>VimwikiFollowLink
"nmap <Leader><CR> <Plug>VimwikiFollowLink
"nnoremap <CR> :noh<CR>
nnoremap <space> :noh<CR>
nnoremap <leader>nz :NewZettel 

"--- AUTOCMD ---"
augroup VimWikiNotes
    "execute "au BufNewFile "vimwikifolder."/diary/*.md :silent 0r !/home/acifuentes/notes/templates/diary.py '%'"
    "execute "au BufNewFile "vimwikifolder."/*.md :silent 0r !/home/acifuentes/notes/templates/zettlekasten.py '%'"
    execute "au BufNewFile "vimwikifolder."/diary/*.md :silent 0r !".vimwikifolder."/templates/generate-vimwiki-diary-template '%'"
    execute "au BufNewFile "vimwikifolder."/*.md :silent 0r !".vimwikifolder."/templates/generate-vimwiki-zettelkasten-template '%'"
    "execute "au BufWritePost * silent !/media/files/bin/vimrc/gitAmend.sh ".getcwd()
    autocmd FileType vimwiki map <Leader>c :call ToggleCalendar()<CR>
    autocmd FileType vimwiki map <Leader>d :put =strftime('%a %d %b %Y')<CR>
    autocmd VimEnter * VimwikiIndex
    set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
augroup END


"--- THEMING ---"
hi vertsplit ctermfg=238 ctermbg=238 term=NONE
set background=dark
let ayucolor="mirage"
colorscheme ayu
hi Normal guibg=NONE ctermbg=NONE
"hi clear SpellBad
"hi SpellBad cterm=underline ctermfg=red guifg=red
hi clear VimwikiBold
hi clear VimwikiItalic
hi def VimwikiBold term=bold cterm=bold gui=bold ctermfg=yellow guifg=#FFA759
hi def VimwikiItalic ctermfg=green guifg=#95E6CB
"hi! def link VimwikiBold Statement

inoremap [a á
inoremap [e é
inoremap [i í
inoremap [o ó
inoremap [u ú
inoremap ; ñ
inoremap ;; ;

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
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

" Resize splis on vim window resize
autocmd VimResized * wincmd =

" Breakindent
set breakindent
set breakindentopt=shift:2
set showbreak=\\\\\
