-- Mappings and options
vim.g.mapleader = ","

vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.foldmethod = "syntax"
vim.opt.foldlevel = 99
vim.opt.updatetime = 100
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undodir = "~/.vim/undodir"
vim.opt.undofile = true
vim.opt.scrolloff = 5

vim.keymap.set({'i', 't'}, 'hh', '<Plug>esc')
vim.keymap.set('i', 'jk', '<Plug>esc')
vim.keymap.set('i', 'kj', '<Plug>esc')
vim.keymap.set('i', '<Plug>esc', '<ESC>')
vim.keymap.set('t', '<Plug>esc', '<C-\\><C-n>')
vim.keymap.set('n', 'gb', 'ls<CR>:b<Space>')
vim.keymap.set('n', '<CR>', ':nohlsearch<CR><CR>', { silent = true })
vim.keymap.set({'i', 'n', 't'}, '<leader>`', '<Plug>TermToggle')
vim.keymap.set('i', '<C-u>', '<C-g>u<C-u>')
vim.keymap.set('i', '<C-w>', '<C-g>u<C-w>')
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv')
vim.keymap.set('n', 'Q', '<nop>')

vim.opt.clipboard:append({ 'unnamed', 'unnamedplus' })

-- Customize color for the color scheme
vim.api.nvim_create_autocmd("ColorScheme", {
    command = "hi PmenuSel guibg=#282a36 guisp=#282a36"
})

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Configure plugins
require("lazy").setup({
    {
        "connorholyday/vim-snazzy",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme snazzy")
        end,
    },
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      dependencies = {
        "nvim-tree/nvim-web-devicons",
        "antosha417/nvim-lsp-file-operations",
      },
      config = function()
        require("nvim-tree").setup {
            renderer = {
                icons = {
                    glyphs = {
                        git = {
                            unstaged = 'M',
                            staged = 'S',
                            unmerged = 'U',
                            renamed = 'R',
                            untracked = 'N',
                            deleted = 'D',
                            ignored = 'I',
                        },
                    },
                },
            },
            filters = {
                git_ignored = false,
            },
        }

        -- Auto close
        vim.api.nvim_create_autocmd("BufEnter", {
          nested = true,
          callback = function()
            if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
              vim.cmd "b #"
              vim.cmd "quit"
            end
          end
        })

        -- Toggle config
        local nvimTreeFocusOrToggle = function ()
            local nvimTree=require("nvim-tree.api")
            local currentBuf = vim.api.nvim_get_current_buf()
            local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
            if currentBufFt == "NvimTree" then
                nvimTree.tree.toggle()
            else
                nvimTree.tree.find_file({ open = true, focus = true })
            end
        end
        vim.keymap.set("n", "<leader>t", nvimTreeFocusOrToggle)

        -- To avoid conflict with auto-session
        vim.api.nvim_create_autocmd({ 'BufEnter' }, {
          pattern = 'NvimTree*',
          callback = function()
            local api = require('nvim-tree.api')
            local view = require('nvim-tree.view')

            if not view.is_visible() then
              api.tree.open()
            end
          end,
        })
      end,
    },
    {
        'rmagatti/auto-session',
        lazy = false,
        config = function()
            require("auto-session").setup {
                auto_session_suppress_dirs = {},
            }
        end
    },
    {
        'easymotion/vim-easymotion',
        lazy = false,
        config = function()
            vim.keymap.set({'n', 'v'}, 'S', '<Plug>(easymotion-s2)')
            vim.g.EasyMotion_smartcase = 1
        end
    },
    {
        'vim-airline/vim-airline',
        lazy = false,
        config = function()
            vim.g["airline#extensions#tabline#enabled"] = 1
            vim.g["airline#extensions#tabline#left_sep"] = ' '
            vim.g["airline#extensions#tabline#left_alt_sep"] = '|'
            vim.g["airline#extensions#tabline#formatter"] = 'unique_tail_improved'
        end
    },
    {
        'vim-airline/vim-airline-themes',
        lazy = false,
        dependencies = {
            'rakr/vim-one',
        },
        config = function()
            vim.g.airline_theme = 'one'
        end
    },
    {
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
                },
            })

            telescope.load_extension('fzf')

            vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Fuzzy find files in CWD' }) 
            vim.keymap.set('n', '<leader>f', builtin.live_grep, { desc = 'Find string in CWD' }) 
        end
    },
    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
    },
    {
        'akinsho/toggleterm.nvim',
        config = function()
            require('toggleterm').setup({
                open_mapping = "<leader>`",
                terminal_mappings = true,
            })
        end
    },
})
