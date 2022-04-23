"--- PLUGINS ---"
call plug#begin()

Plug 'itchyny/lightline.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'wesQ3/vim-windowswap'
Plug 'triglav/vim-visual-increment'
Plug 'kshenoy/vim-signature' "Show name of vim marks
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'vim-syntastic/syntastic' 
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'preservim/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'junegunn/vim-peekaboo'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" - SYNTAX -"
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'nvie/vim-flake8', {'for': 'python'}
Plug 'OrangeT/vim-csharp'

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
"Plug 'puremourning/vimspector'
call plug#end()
