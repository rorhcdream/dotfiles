return {
    'easymotion/vim-easymotion',
    lazy = false,
    config = function()
        vim.keymap.set({'n', 'v'}, 'S', '<Plug>(easymotion-s2)')
        vim.g.EasyMotion_smartcase = 1
    end
}
