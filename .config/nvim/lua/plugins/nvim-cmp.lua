return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-cmdline',

        -- LuaSnip
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
    },
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        require('luasnip.loaders.from_vscode').lazy_load()

        local is_whitespace = function()
            -- returns true if the character under the cursor is whitespace.
            local col = vim.fn.col('.') - 1
            local line = vim.fn.getline('.')
            local char_under_cursor = string.sub(line, col, col)

            if col == 0 or string.match(char_under_cursor, '%s') then
                return true
            else
                return false
            end
        end
         
        cmp.setup({
            enabled = function()
                return not is_whitespace()
            end,
            completion = {
                completeopt = 'menu,menuone',
                get_trigger_characters = function(chars)
                  print(table.concat(chars, ", "))
                  local new_chars = {}
                  for _, char in ipairs(chars) do
                    if char ~= ' ' then
                      table.insert(new_chars, char)
                    end
                  end
                  return new_chars
                end
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<Tab>'] = cmp.mapping.confirm({ select = false }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim-lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'path' },
                { name = 'cmdline' },
            }),
        })
    end
}
