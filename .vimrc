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
set foldmethod=syntax
set foldlevel=99
set updatetime=100
set ignorecase
set smartcase
imap hh <Plug>esc
tmap hh <Plug>esc
inoremap <Plug>esc <ESC>
tnoremap <Plug>esc <C-\><C-n>
nnoremap gb :ls<CR>:b<Space>
nnoremap <silent> <CR> :nohlsearch<CR><CR>
imap <leader>` <Plug>TermToggle
nmap <leader>` <Plug>TermToggle
tmap <leader>` <Plug>TermToggle
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>


" ===================== local scripts =======================
source ~/.vim/scripts/toggle_terminal.vim

" ===================== plugins before load =================

" vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" vim-airline/vim-airline-themes
let g:airline_theme='one'

" scrooloose/nerdtree
let NERDTreeShowHidden=1
nmap <silent> <leader>t <Plug>NERDTreeFindOrToggle
nmap <Plug>NERDTreeFindOrToggle :call g:NERDTreeFindOrToggle()<CR>

function! g:NERDTreeFindOrToggle()
    if exists("g:NERDTree") && g:NERDTree.IsOpen() && &filetype == 'nerdtree'
        exec "NERDTreeClose"
    elseif bufname('%') == ''
        exec "NERDTree"
    elseif exists('b:terminal_job_id')
        " ignore terminal buffer
    else
        exec "NERDTreeFind"
    endif
endfunction

augroup NerdTreeAuGroup
    autocmd!
    " " Start NERDTree and put the cursor back in the other window.
    " autocmd VimEnter * NERDTree | wincmd p
    " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
    autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
                \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
augroup END

" neoclide/coc.nvim
source ~/.vim/scripts/coc_nvim.vim

" github/copilot.vim
inoremap <silent><script><expr> h<Tab> copilot#Accept("<End>")
imap h] <Plug>(copilot-next)
imap h[ <Plug>(copilot-prev)
let g:copilot_no_tab_map = v:true
let g:copilot_assume_mapped = v:true
let g:copilot_filetypes = {'yaml': v:true}
augroup copilot
    autocmd!
    " disable copilot in PS
    autocmd BufEnter ~/PS/* let b:copilot_enabled = v:false
augroup END

" rmagatti/auto-session
if has("nvim")
    function! g:WipeAllTerminalBuffers()
        for bufnr in range(1, bufnr('$'))
            if getbufvar(bufnr, "&buftype") == "terminal"
                execute 'bwipeout! ' . bufnr
            endif
        endfor
    endfunction

    let g:auto_session_pre_save_cmds = ["silent! bw NERD_tree", "call g:WipeAllTerminalBuffers()"]
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
let g:formatdef_isort = '"isort -"'
let g:formatters_python = ['black', 'isort']
let g:run_all_formatters_python = 1

" junegunn/fzf
command! -bang -nargs=? RG
  \ call fzf#vim#grep2(
  \   'rg --hidden --column --line-number --no-heading --color=always --smart-case --ignore-file .git --', <q-args>,
  \   fzf#vim#with_preview(), <bang>0)
nnoremap <leader>f :RG<CR>
nnoremap <C-p> :Files<CR>

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
Plug 'Raimondi/delimitMate'
Plug 'ryanoasis/vim-devicons'
Plug 'github/copilot.vim'
Plug 'vim-autoformat/vim-autoformat'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'samjwill/nvim-unception'
Plug 'airblade/vim-gitgutter'

if has("nvim")
    Plug 'rmagatti/auto-session'
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

