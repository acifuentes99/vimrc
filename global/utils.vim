" REQUISITES
"   * Vim FZF
"   * vim-windowswap

let g:windowswap_map_keys = 0 "prevent default bindings

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 


" VISUAL SELECTION
" Press Search, then highlight all matches in file
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

" Scratch Buffer
function! TabNewWithScratchBuffer()
    execute "tabnew" 
    set buftype=nofile
    set bufhidden=hide
    setlocal noswapfile
endfunction

"--- FZF Configuration ---"
let g:fzf_preview_window = ''
let g:fzf_layout = { 'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8, 'yoffset':0.5, 'xoffset': 0.5, 'border': 'sharp' } }
let fzfOptions = '
        \ --prompt=""
        \ --multi
        \ --margin=1,2
        \ --layout=reverse
        \ --expect=ctrl-t,ctrl-x,ctrl-v
    \'

command! -bang -nargs=*  All call 
    \ fzf#run(fzf#wrap({
    \'source': 'rg -l --files --hidden --no-ignore-vcs --glob "!{node_modules/*,.git/*,.tmp-metadata/*}"', 
    \'options': fzfOptions 
    \ }))
