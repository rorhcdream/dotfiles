return {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')
        local builtin = require('telescope.builtin')

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ['<C-k>'] = actions.move_selection_previous,
                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
                        ['<ESC>'] = actions.close,
                    },
                },
                file_ignore_patterns = {
                    ".git/", ".cache", "%.o", "%.a", "%.out", "%.class", "%.pdf", "%.mkv", "%.mp4", "%.zip",
                    "node_modules/",
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
        })

        telescope.load_extension('fzf')

        vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Fuzzy find files in CWD' }) 
        vim.keymap.set('n', '<leader>f', builtin.live_grep, { desc = 'Find string in CWD' }) 
    end
}