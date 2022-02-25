" VIM GENERAL KEYSTROKES
" Used in all Vim configurations file
" Requires :
"   * Vim FZF
"   * vim-windowswap
"   * Vim Utils (util custom functions)

" Vim Operations
let mapleader = "-"
nnoremap <leader>w :wa!<CR>
nnoremap <leader>q :wqa<CR>:
nnoremap <A-c> :tabclose<CR>
nnoremap <A-x> :close<CR>
nnoremap <C-Y> :bprevious<CR>
nnoremap <C-O> :bnext<CR>
noremap <C-PageUp> gT<cr>
noremap <C-PageDown> gt<cr>
"orenmap <A-S-e> :echo 'testing keybidings'<CR>
noremap <A-S-r> :silent exec "source ".g:rcfile<CR>:echo 'Source reloaded'<CR>
noremap <A-S-e> :echo 'asdfq'<CR>

" Quickfix
noremap <A-S-j> :cn<CR>
noremap <A-S-k> :cp<CR>

" Simplifications
nnoremap <A-8> :let @+ = expand("%")<CR>
nnoremap <A-9> :let @+ = expand("%:t:r")<CR>
nnoremap <A-0> :echo @%<CR>
noremap <A-1> 1gt
noremap <A-2> 2gt
noremap <A-3> 3gt
noremap <A-4> 4gt
noremap <A-5> 5gt
noremap <A-6> 6gt

" Vim split windows movements
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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

" FZF
nnoremap <A-p> :All<CR>
nnoremap <A-h> :History<CR>
nnoremap <A-b> :Buffers<CR>
nnoremap <A-w> :Windows<CR>
nnoremap <A-f> :Rg<CR>


" SWAP VIM WINDOWS WITH ',ww'
let mapleader = ","
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>
nnoremap <silent> <leader>z <c-w>_<c-w>|

" Visual mode pressing * or # searches for the current selection "
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR> 
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" New tab opens Scratch Buffer
nnoremap <A-t> :call TabNewWithScratchBuffer()<CR>

" Dont know.. appears something with terminal mode
tnoremap <expr> <C-v> '<C-\><C-N>pi'


let mapleader = "-"
