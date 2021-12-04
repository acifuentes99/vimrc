"--- PLUGINS ---"
call plug#begin()
Plug 'itchyny/lightline.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'wesQ3/vim-windowswap'
Plug 'triglav/vim-visual-increment'
Plug 'kshenoy/vim-signature' "Show name of vim marks
Plug 'mattn/emmet-vim' 
"Plug 'neowit/vim-force.com' 
Plug 'OrangeT/vim-csharp'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-syntastic/syntastic' 
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'preservim/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" - SYNTAX -"
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'nvie/vim-flake8', {'for': 'python'}
" - THEMES -"
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'adampasz/stonewashed-themes'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'romainl/Apprentice'
Plug 'tomasiser/vim-code-dark'
Plug 'ayu-theme/ayu-vim'
"Scala
Plug 'puremourning/vimspector'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
call plug#end()
" - FUNCIONAMIENTO - "
"Plug 'tpope/vim-vinegar' "Abrir NerdTree con -
"Plug 'skywind3000/asyncrun.vim'
"Plug 'xuyuanp/nerdtree-git-plugin' "Mostrar cambios de Git en NerdTree
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
"Plug 'alvarosevilla95/luatab.nvim'
"Plug 'nvim-telescope/telescope.nvim'
"Plug 'neovim/nvim-lspconfig'
"Plug 'nvim-lua/completion-nvim'
"Plug 'wikitopian/hardmode'
".call HardMode()
":call EasyMode
"Plug 'vifm/vifm.vim'
" - ESCRITURA -"
"Plug 'vimwiki/vimwiki', {'on': 'VimwikiIndex'}
"Plug 'junegunn/goyo.vim', {'on': 'VimwikiIndex'}
"Plug 'itchyny/calendar.vim', {'on': 'VimwikiIndex'}
"Plug 'lepture/vim-jinja'
"Plug 'mxw/vim-jsx'
"Plug 'cakebaker/scss-syntax.vim'
"Plug 'PotatoesMaster/i3-vim-syntax', {'for': 'i3'}
"Plug 'scrooloose/nerdtree' " Plug de cambio de archivos
"Plug 'jistr/vim-nerdtree-tabs' "Inegrar nerdtree con tabs de vim
"Plug 'ryanoasis/vim-devicons'
