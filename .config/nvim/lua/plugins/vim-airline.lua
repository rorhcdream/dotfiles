return {
    'vim-airline/vim-airline',
    lazy = false,
    dependencies = {
        'vim-airline/vim-airline-themes',
    },
    config = function()
        vim.g["airline_theme"] = 'catppuccin'
    end
}
