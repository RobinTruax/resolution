--[[------------------- resolution v0.1.0 -----------------------

all plugins relating to LSP, autocompletion, snippets, etc.

-------------------------------------------------------------]]

local prefs = require('config.preferences')

-----------------------------------------------------------------

return {

    ----------------------- LuaSnip: snippets -----------------------
    {
        'L3MON4D3/LuaSnip',
        ft = { 'tex', 'py', 'lua' },
        pin = true,
        commit = '4964cd11e19de4671189b97de37f3c4930d43191',
        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        config = function()
            -- dependencies
            local ls = require('luasnip')
            local loaders = require('luasnip.loaders.from_lua')
            local types = require('luasnip.util.types')

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
                            virt_text = { { '●', 'Snippet' } }
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
            -- luasnip (so mappings can be unified)
            'L3MON4D3/LuaSnip',
            -- completion sources
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-buffer',
            -- 'uga-rosa/cmp-dictionary',
            'rafamadriz/friendly-snippets',
            'kdheepak/cmp-latex-symbols',
            'FelipeLema/cmp-async-path',
            'hrsh7th/cmp-calc',
            'uga-rosa/cmp-dynamic',
        },
        config = function()
            -- dependencies
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            local compare = require('cmp.config.compare')

            -- utility function
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
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
                    ['<CR>'] = cmp.mapping.confirm({
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
                    -- math dictionary
                    {
                        name = 'dynamic',
                        keyword_length = 2,
                        priority = 10,
                    },
                    -- snippets
                    {
                        name = 'luasnip',
                        priority = 9
                    },
                    -- nvim lsp
                    {
                        name = 'nvim_lsp',
                        priority = 8
                    },
                    {
                        name = 'nvim_lsp_signature_help',
                        priority = 8
                    },
                    -- latex symbols
                    {
                        name = 'latex_symbols',
                        option = {
                            strategy = 2,
                        },
                        priority = 4,
                    },
                    -- path completion
                    {
                        name = 'async_path',
                        priority = 3,
                    },
                    -- simple-in system calculations
                    {
                        name = 'calc',
                        priority = 2,
                    },
                    -- text in buffer
                    -- {
                    --     name = 'buffer',
                    --     priority = 1,
                    -- },
                },
                -- sorting
                sorting = {
                    priority_weight = 1.0,
                    comparators = {
                        compare.exact,
                        compare.locality,
                        compare.recently_used,
                        compare.score,
                        compare.offset,
                        compare.order,
                    },
                }
            })

            local dictionary_entries = require('tex.generate_dictionary')(prefs.dictionary_files)
            require('cmp_dynamic').register(dictionary_entries)
        end
    },
}

-----------------------------------------------------------------
