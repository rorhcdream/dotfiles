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
nnoremap gb :ls<CR>:b<Space>

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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Raimondi/delimitMate'
Plug 'ryanoasis/vim-devicons'
Plug 'github/copilot.vim'

" colorschemes
Plug 'noahfrederick/vim-noctu'
Plug 'connorholyday/vim-snazzy'
Plug 'jeffkreeftmeijer/vim-dim'
Plug 'dracula/vim'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'nanotech/jellybeans.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'rakr/vim-one'

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

" vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" vim-airline/vim-airline-themes
let g:airline_theme='one'

" scrooloose/nerdtree
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_console_startup = 1

" neoclide/coc.nvim
source ~/.vim/plugin/coc_nvim


