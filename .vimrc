" ===================== default =============================
if !has("nvim")
    unlet! skip_defaults_vim
    source $VIMRUNTIME/defaults.vim
endif

let mapleader = ","
set mouse=a
set number
set ruler
set showcmd
set incsearch
set hlsearch
set tabstop=4
set shiftwidth=4
set expandtab
imap hh <Plug>esc
tmap hh <Plug>esc
inoremap <Plug>esc <ESC>
if has("nvim")
    inoremap <leader>` <ESC>:ToggleTerm size=20<CR>
    tnoremap <leader>` <C-\><C-n>:ToggleTerm size=20<CR>
    tnoremap <Plug>esc <C-\><C-n>
    nnoremap <leader>` :ToggleTerm size=20<CR>
else
    tnoremap <Plug>esc <C-w>N
    nnoremap <leader>` :botright term<CR>
endif
nnoremap gb :ls<CR>:b<Space>
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" ===================== plugins before load =================

" vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" vim-airline/vim-airline-themes
let g:airline_theme='one'

" scrooloose/nerdtree
nmap <silent> <leader>t :NERDTreeMirrorToggle<CR>
" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
            \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" neoclide/coc.nvim
source ~/.vim/plugin/coc_nvim

" github/copilot.vim
inoremap <silent><script><expr> j<Tab> copilot#Accept("<End>")
imap j] <Plug>(copilot-next)
imap j[ <Plug>(copilot-prev)
let g:copilot_no_tab_map = v:true
let g:copilot_assume_mapped = v:true

" ctrlpvim/ctrlp.vim
let g:ctrlp_show_hidden=1
let g:ctrlp_cmd='CtrlP :pwd'

" rmagatti/auto-session
if has("nvim")
    let g:auto_session_pre_save_cmds = ["bw NERD_tree"]
    "let g:auto_session_post_restore_cmds = ["NERDTreeMirrorToggle", "wincmd p"]
endif

" vim-autoformat/vim-autoformat
let g:python3_host_prog="python"
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
function! Autoformat()
    if get(b:, "autoformat_enable", v:true)
        :Autoformat
    endif
endfunction
autocmd BufWrite * call Autoformat()
autocmd FileType sql let b:autoformat_enable=v:false

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
Plug 'vim-autoformat/vim-autoformat'

if has("nvim")
    Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.6.0'}
    Plug 'rmagatti/auto-session'
    Plug 'samjwill/nvim-unception'
endif

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

" ===================== plugins after load =================
if has("nvim")
    lua require("toggleterm").setup()
    lua require("auto-session").setup()
endif

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

