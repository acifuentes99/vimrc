" VIM GENERAL KEYSTROKES
" Used in all Vim configurations file
" Requires :
"   * Vim FZF
"   * vim-windowswap
"   * Vim Utils (util custom functions)


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


"--- '-' LEADER ---"
let mapleader = "-"
" Vim Operations
nnoremap <leader>w :wa!<CR>
nnoremap <leader>q :qa!<CR>
" File Tree and Explorer
nnoremap <leader>l :Lex<CR>
nnoremap <leader>t :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
" Simplifications
nnoremap <leader>8 :let @+ = expand("%")<CR>
nnoremap <leader>9 :let @+ = expand("%:t:r")<CR>
nnoremap <leader>0 :echo @%<CR>
" Vimux
nnoremap <Leader>p :call VimuxRunCommand("sfdx force:source:push")<CR>
nnoremap <Leader>o :call VimuxRunCommand(open_org_command)<CR>
nnoremap <leader>sv :source $VIMRC<CR>


"--- ',' LEADER ---"
let mapleader = ","
" QUICKFIX
noremap <leader>j :cn<CR>
noremap <leader>k :cp<CR>
" FZF VIM - shortcut operations
" Use word or visual selection to open search
noremap <leader>p yiw:All '<C-r>0'<CR>
noremap <leader>f yiw:Rgg <C-r>0<CR>
" Replace matching Word in visual mode
nnoremap <leader>r yiw:%s/<C-r>"//g<left><left>
vnoremap <leader>r :s/<C-r>"//g<left><left>
" SWAP VIM WINDOWS WITH ',ww'
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>
" Zoom current split
nnoremap <silent> <leader>z <C-W>_\|<C-W>\|
" Restart zooms
nnoremap <silent> <leader>= <C-W>=
" Shortcuts Vim
nnoremap <silent> <leader>n :set invnumber<CR> 


"--- OTHER MAPPINGS ---"

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

nnoremap <nowait><silent> <space> :noh<CR>

"--- COC NVIM ---"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
inoremap <silent><expr> <c-space> coc#refresh()
" not usable, because space is used
"nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"nnoremap <silent> <space>a  :<C-u>CocFzfListDiagnostics<CR>
"nnoremap <silent> <space>e  :<C-u>CocFzfListExtensions<CR>
"nnoremap <silent> <space>l  :<C-u>CocFzfListLocation<CR>
"nnoremap <silent> <space>o  :<C-u>CocFzfListOutline<CR>
"nnoremap <silent> <space>p  :<C-u>CocFzfListResume<CR>
"nnoremap <silent> <space>s  :<C-u>CocFzfListSymbols<CR>
"nnoremap <silent> <space>S  :<C-u>CocFzfListServices<CR>

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


"--- VIMSPECTOR ---"
" Mientras, dejare los mappings en "HUMAN"
" https://github.com/puremourning/vimspector#mappings
let mapleader = "-"
nmap <F5> <Plug>VimspectorContinue
nmap <F3> <Plug>VimspectorStop
nmap <F4> <Plug>VimspectorRestart
nmap <F6> <Plug>VimspectorPause
nmap <F9> <Plug>VimspectorToggleBreakpoint
nmap <leader><F9> <Plug>VimspectorToggleConditionalBreakpoint
nmap <F8> <Plug>VimspectorAddFunctionBreakpoint
nmap <leader><F8> <Plug>VimspectorRunToCursor
nmap <F10> <Plug>VimspectorStepOver
nmap <F11> <Plug>VimspectorStepInto
nmap <F12> <Plug>VimspectorStepOut

nnoremap <leader>cl :<C-u>call       CocActionAsync('codeLensAction')<CR>


"--- SNIPPETS ---"
let g:UltiSnipsExpandTrigger="<C-TAB>"
let g:UltiSnipsListSnippets="<c-l>"

iabbrev cu cuprum
iabbrev Cu Cuprum
