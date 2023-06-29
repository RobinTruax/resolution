--[[------------------- resolution v0.1.0 -----------------------

all plugins relating to LSP, autocompletion, snippets, etc.

-------------------------------------------------------------]]

return {

    ----------------------- LuaSnip: snippets -----------------------
    {
        'L3MON4D3/LuaSnip',
        ft = { 'tex', 'py', 'lua' },
        version = '*',
        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        config = function()
            -- dependencies
            local ls = require('luasnip')
            local loaders = require('luasnip.loaders.from_lua')
            local types = require("luasnip.util.types")

            -- lazy load functions
            loaders.lazy_load({ paths = './lua/snippets' })

            -- set up luasnip (mappings are configured on the level of nvim-cmp)
            ls.config.set_config({
                history = false,
                update_events = { 'InsertLeave' },
                region_check_events = { 'CursorMoved' },
                delete_check_events = { 'TextChanged', 'InsertLeave' },
                store_selection_keys = '<Tab>',
                enable_autosnippets = true,
                ext_opts = {
                    [types.insertNode] = {
                        active = {
                            virt_text = { { '●', 'InsertMode' } }
                        }
                    }
                },
            })
        end
    },

    ------------------- nvim-cmp: autocompletion --------------------
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-buffer',
            'uga-rosa/cmp-dictionary',
            'rafamadriz/friendly-snippets',
        },
        config = function()
            -- dependencies
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            -- utility function
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            -- configuration of autocompletion and snippet mappings
            cmp.setup({
                -- linking snippets to nvim_cmp
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                -- mappings
                mapping = cmp.mapping.preset.insert {
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        elseif cmp.visible() then
                            cmp.select_next_item()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                },
                -- completion sources
                sources = {
                    -- nvim lsp
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lsp_signature_help' },
                    -- text in buffer
                    { name = 'buffer' },
                    -- snippets
                    { name = 'luasnip' },
                    -- math dictionary
                    { name = 'dictionary', keyword_length = 2 },
                },
            })

            -- configuration of math dictionary
            local dict = require('cmp_dictionary')
            dict.switcher({
                filetype = {
                    tex = { vim.fn.stdpath('config') .. '/lua/tex/dictionary/basic.txt' }
                },
            })
        end
    },
}

-----------------------------------------------------------------
