return {
    'vim-airline/vim-airline',
    lazy = false,
    dependencies = {
        'vim-airline/vim-airline-themes',
    },
    config = function()
        vim.g["airline#extensions#tabline#enabled"] = 1
        vim.g["airline#extensions#tabline#left_sep"] = ' '
        vim.g["airline#extensions#tabline#left_alt_sep"] = '|'
        vim.g["airline#extensions#tabline#formatter"] = 'unique_tail'
        vim.g["airline_theme"] = 'catppuccin'
    end
}
