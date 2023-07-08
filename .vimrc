" ===================== default ============================
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

set mouse=a
set number
set ruler
set showcmd
set incsearch
set hlsearch
set tabstop=4
set shiftwidth=4 
inoremap jj <ESC>
let mapleader = ","

" ===================== vim-plug ============================
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
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Raimondi/delimitMate'

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

" ===================== colors =============================
" Customize colors
func! s:my_colors_setup() abort
    hi PmenuSel guibg=#282a36 guisp=#282a36
endfunc

augroup colorscheme_override | au!
    au ColorScheme * call s:my_colors_setup()
augroup END

" Set colorscheme
colorscheme snazzy

" ===================== plugins ============================

" itchyny/lightline.vim 
let g:lightline = {
\ 'colorscheme': 'snazzy',
\ 'tabline': {
\   'left': [ ['buffers'] ],
\   'right': [ ['close'] ]
\ },
\ 'component_expand': {
\   'buffers': 'lightline#bufferline#buffers'
\ },
\ 'component_type': {
\   'buffers': 'tabsel'
\ }
\ }

set showtabline=2

" scrooloose/nerdtree
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_console_startup = 1

" neoclide/coc.nvim
source ~/.vim/plugin/coc_nvim


