return {
    'debugloop/telescope-undo.nvim',
    dependencies = {
        {
            'nvim-telescope/telescope.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim',
            },
        },
    },
    keys = {
        {
            '<leader>u',
            '<cmd>Telescope undo<cr>',
            desc = 'undo history',
        },
    },
    opts = {
        extensions = {
            undo = {
                -- telescope-undo.nvim config
            },
        },
    },
    config = function(_, opts)
        -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
        -- configs for us. We won't use data, as everything is in it's own namespace (telescope
        -- defaults, as well as each extension).
        require('telescope').setup(opts)
        require('telescope').load_extension('undo')
    end,
}
