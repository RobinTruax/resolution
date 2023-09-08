--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computation math.

All plugins relating to LSP, autocompletion, snippets, etc.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

--------------------------------- dependencies ---------------------------------

local prefs = require('config.preferences')

--------------------------------------------------------------------------------

return {

    ------------------------------ LuaSnip: snippets -------------------------------
    {
        'L3MON4D3/LuaSnip',

        -- trigger
        event = 'VeryLazy',

        -- freeze to avoid bug
        pin = true,
        commit = '4964cd11e19de4671189b97de37f3c4930d43191',

        -- dependencies
        dependencies = {
            'rafamadriz/friendly-snippets',
        },

        -- configuration
        config = function()

            -- dependencies
            local ls = require('luasnip')
            local loaders = require('luasnip.loaders.from_lua')
            local types = require('luasnip.util.types')

            -- load latex snippets defined in resolution
            loaders.lazy_load({ paths = './lua/snippets' })

            -- load snippets for all other filetypes provided by friendly-snippets
            require("luasnip.loaders.from_vscode").lazy_load({
                exclude = { "latex", "tex", "sty" },
            })

            -- set options (mappings are configured in nvim-cmp)
            ls.config.set_config({

                -- history = false to avoid accidental jumps
                history = false,

                -- events which balance catching updates & performance
                update_events = { 'InsertLeave' },
                region_check_events = { 'CursorMoved' },
                delete_check_events = { 'TextChanged', 'InsertLeave' },

                -- setting up visual-style snippets
                store_selection_keys = '<Tab>',

                -- enabling autosnippets
                enable_autosnippets = true,

                -- visual indicator for insert nodes
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

    --------------------------- nvim-autopairs: pairing ----------------------------
    {
        'windwp/nvim-autopairs',

        -- trigger
        event = 'InsertEnter',

        config = function()

            -- dependency (itself)
            local npairs = require("nvim-autopairs")
            local Rule = require('nvim-autopairs.rule')
            local cond = require('nvim-autopairs.conds')

            -- setup
            npairs.setup({
                map_cr = false
            })

            npairs.add_rule(
              Rule("$", "$",{"tex", "latex"})
                :with_pair(cond.not_before_regex("\\", 3))
            )
        end
    },

    ------------------- nvim-cmp: autocompletion --------------------
    {
        'hrsh7th/nvim-cmp',

        -- trigger
        event = 'InsertEnter',

        dependencies = {
            -- for mapping
            'L3MON4D3/LuaSnip',

            -- completion sources
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-buffer',
            'rafamadriz/friendly-snippets',
            'FelipeLema/cmp-async-path',
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
                    -- assorted maps
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                    -- tab map
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        elseif cmp.visible() then
                            cmp.select_next_item()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    -- shift-tab map
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
                    -- text in buffer
                    {
                        name = 'buffer',
                        priority = 10,
                    },
                    -- math dictionary
                    {
                        name = 'dynamic',
                        keyword_length = 2,
                        priority = 9,
                    },
                    -- snippets
                    {
                        name = 'luasnip',
                        priority = 8
                    },
                    -- nvim lsp
                    {
                        name = 'nvim_lsp',
                        priority = 6
                    },
                    {
                        name = 'nvim_lsp_signature_help',
                        priority = 4
                    },
                    -- path completion
                    {
                        name = 'async_path',
                        priority = 3,
                    },
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

            -- dictionary entries
            local dictionary_entries = require('tex.generate_dictionary')(prefs.dictionary_files)
            require('cmp_dynamic').register(dictionary_entries)
        end
    },
}

-----------------------------------------------------------------
