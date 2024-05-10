return {
    'vim-airline/vim-airline',
    lazy = false,
    dependencies = {
        'vim-airline/vim-airline-themes',
        'rakr/vim-one',
    },
    config = function()
        vim.g["airline#extensions#tabline#enabled"] = 1
        vim.g["airline#extensions#tabline#left_sep"] = ' '
        vim.g["airline#extensions#tabline#left_alt_sep"] = '|'
        vim.g["airline#extensions#tabline#formatter"] = 'unique_tail_improved'
        vim.g.airline_theme = 'one'
    end
}
