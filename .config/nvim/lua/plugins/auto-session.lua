return {
    'rmagatti/auto-session',
    lazy = false,
    config = function()
        require("auto-session").setup {
            auto_session_suppress_dirs = {},
        }
    end
}
