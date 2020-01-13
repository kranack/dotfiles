set termguicolors
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugin Airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin NerdTree
" Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } | Plugin 'Xuyuanp/nerdtree-git-plugin' | Plugin 'ryanoasis/vim-devicons'
" Plugin TagBar
Plugin 'majutsushi/tagbar'
" Powerline fonts
Plugin 'powerline/fonts'

" One Half Theme
Plugin 'sonph/onehalf', {'rtp': 'vim/'}
" Two Firewatch Theme
Plugin 'rakr/vim-two-firewatch'
" Alduin Theme
Plugin 'alessandroyorba/alduin'
" Edge Theme
Plugin 'sainnhe/edge'

" -- code check
Plugin 'scrooloose/syntastic'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Conquer Of Completion plugin
Plugin 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Vim Polyglot
Plugin 'sheerun/vim-polyglot'

" Polyglot plugins
Plugin 'elzr/vim-json'
Plugin 'pangloss/vim-javascript'
Plugin 'groenewege/vim-less'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'StanAngeloff/php.vim'
Plugin 'amadeus/vim-xml'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Plugin One Half settings
syntax on

set t_Co=256
set cursorline
set tabstop=4
set shiftwidth=4
set smarttab
set splitright

" colorscheme onehalfdark

" Alduin theme customization
"let g:alduin_Shout_Dragon_Aspect = 1
"let g:alduin_Shout_Fire_Breath = 1

set background=dark
"colorscheme alduin
" colorscheme two-firewatch
colorscheme edge

" Plugin Airline settings
" let g:airline_section_b = '%{strftime("%c")}'
" let g:airline_section_y = 'BN: %{bufnr("%")}'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" extensions
let g:airline_extensions = ['tabline']
let g:airline#extensions#default#section_truncate_width = {}
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline_theme             = 'papercolor'
let g:airline_theme='onehalfdark'

" let g:two_firewatch_italics=1
" let g:airline_theme='twofirewatch'

let g:indent_guides_guide_size = 1

" Airline Powerline fonts
let g:airline_powerline_fonts = 1
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1

set encoding=utf8
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete:h11
" set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete:s12
" set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11

set laststatus=2

if exists("g:loaded_webdevicons")
	call webdevicons#refresh()
endif

" NerdTree bar
nmap <F8> :TagbarToggle<CR>

filetype plugin indent on

" Miscs

" force unix fileformat
set fileformat=unix

" make swapfiles be kept in a central location to avoid polluting file system
set directory^=$HOME/.vim/swapfiles//

" use undodir for persistent undoing across file closure
set undodir=~/.vim/undodir
set undofile

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
