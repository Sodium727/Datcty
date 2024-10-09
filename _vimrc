git clone https://github.com/junegunn/vim-plug.git "%USERPROFILE%\vimfiles\autoload"



call plug#begin('C:/Users/Admin/vimfiles/plugged')

" File navigation
Plug 'preservim/nerdtree'
Plug 'tpope/vim-vinegar'

" Syntax highlighting
Plug 'tpope/vim-sensible'
Plug 'morhetz/gruvbox'

" Autocomplete and snippets
Plug 'ycm-core/YouCompleteMe'
"Plug 'SirVer/ultisnips'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Linting and formatting
Plug 'dense-analysis/ale'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

" Status line
Plug 'itchyny/lightline.vim'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Miscellaneous utilities
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

Plug 'jiangmiao/auto-pairs'


call plug#end()

set number
set smarttab
set smartcase
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set nocompatible

autocmd CursorMoved * normal! zvzz

"let g:AutoPairsMapBS = 0

set path"+=C:\msys64\ucrt64\include\c++\14.1.0"
