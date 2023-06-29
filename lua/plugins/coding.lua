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
            local ls = require('luasnip')
            require('luasnip.loaders.from_lua').lazy_load({ paths = './lua/snippets' })

            ls.config.set_config({
                history = false,
                updateevents = 'TextChangedI',
                store_selection_keys = "<Tab>",
                enable_autosnippets = true,
            })

            vim.cmd("imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'")
            vim.cmd("inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>")
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
            -- setup for completion
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert {
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete {},
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'buffer' },
                    { name = 'dictionary',             keyword_length = 2 },
                    { name = 'luasnip' },
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
