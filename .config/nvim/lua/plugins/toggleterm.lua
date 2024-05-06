return {
        'akinsho/toggleterm.nvim',
        config = function()
            require('toggleterm').setup({
                open_mapping = "<leader>`",
                terminal_mappings = true,
            })
        end
    }
