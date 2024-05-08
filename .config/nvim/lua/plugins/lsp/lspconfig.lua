return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        { 'antosha417/nvim-lsp-file-operations', config = true },
    },
    config = function()
        local lspconfig = require('lspconfig')
        local cmp_nvim_lsp = require('cmp_nvim_lsp')

        local opts = { silent = true }
        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            opts.desc = 'Show LSP references'
            vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)

            opts.desc = 'Go to declaration'
            vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, opts)

            opts.desc = 'See available code actions'
            vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, opts)

            opts.desc = 'Rename'
            vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)

            opts.desc = 'Show documents'
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()

        lspconfig['gopls'].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig['lua_ls'].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "lua"] = true,
                        },
                    },
                },
            },
        })
    end,
}
