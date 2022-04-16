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

" WSL and linux copy paste
function! IsWSL()
  if has("unix")
    let lines = readfile("/proc/version")
    if lines[0] =~ "Microsoft"
      return 1
    endif
  endif
  return 0
endfunction

" Enable yank on WSL
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

" VIM WIKI
let g:vimwiki_global_ext = 0
let g:vimwiki_key_mappings = { 'table_mappings': 0, }
let g:vimwiki_list = [{'path': vimwikifolder,
                \ 'syntax': 'markdown',
                \ 'ext': '.md',
                \ 'diary_rel_path': 'Y. Journal/',
                \ 'nested_syntaxes': {'js': 'javascript', 'py': 'python'}}]
let g:vimwiki_url_maxsave = 0
let g:vimwiki_markdown_link_ext = 0
let g:vimwiki_create_link = 0
let g:netrw_liststyle=3

"" VIM ZETTLE
"let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always"
"let g:zettel_format = "%y%m%d-%H%M-%title"
"let g:zettel_link_format="[%title](%link)"

" SURROUND VIM
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
    exe "normal! a[[" . g:zettelkasten_folder . strftime("%Y%m%d%H%M") . " ". a:name . ".md|" . a:name . "]]\<Esc>"
endfunction
command! -nargs=1 NewZettel :call NewZettel(<f-args>)


" RIPGREP
let g:rg_highlight = 'true'

"--- UTILITY ---"
" Agregar busqueda de FZF como link a nota actual
    "let filename = fnameescape(fnamemodify(a:file, ":t"))
    "why only the tail ?  I believe the whole filename must be linked unless everything is flat ...
    "let filename = fnameescape(a:file)
    "let filename_wo_timestamp = fnameescape(fnamemodify(a:file, ":t:s/^[0-9]*-//"))
     " Insert the markdown link to the file in the current buffer
    "let mdlink = "[".filename_wo_timestamp."](".filename.")"
function! HandleFZF(file)
    let filename = a:file
    let filename_wo_timestamp = fnamemodify(a:file, ":t:s/^[0-9]*-//")
    let mdlink = "[[".filename."|".filename_wo_timestamp."]]"
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
