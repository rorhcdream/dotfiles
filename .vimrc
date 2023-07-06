" ===================== vim-plug setup =====================
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" plugins
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ctrlpvim/ctrlp.vim'

" colorschemes
Plug 'noahfrederick/vim-noctu'
Plug 'connorholyday/vim-snazzy'
Plug 'jeffkreeftmeijer/vim-dim'
Plug 'dracula/vim'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'nanotech/jellybeans.vim'
Plug 'arcticicestudio/nord-vim'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting
" ===================== vim-plug setup =====================

let mapleader = ","

" ===================== Plugin settings ====================

colorscheme snazzy

" vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'


" vim-airline/vim-airline-themes
let g:airline_theme='bubblegum'

" scrooloose/nerdtree
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_console_startup = 1

" neoclide/coc.nvim
source .vimrc_coc_nvim


" ===================== Plugin settings ====================

set nocompatible              " be iMproved, required

unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

set mouse=a
set number
set ruler
set showcmd
set incsearch
set hlsearch
inoremap jj <ESC>
