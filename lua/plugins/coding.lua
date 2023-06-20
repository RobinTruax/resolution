--[[------------------- resolution v0.1.0 -----------------------

all plugins relating to LSP, autocompletion, snippets, etc.

-------------------------------------------------------------]]

return {

    --------- nvim-lspconfig: configuration of built-in lsp ---------
    {
        'neovim/nvim-lspconfig',
        ft = { 'tex', 'py', 'lua' },
        dependencies = {
            { 'williamboman/mason.nvim', config = true },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'j-hui/fidget.nvim', opts = {}, pin = true, tag = 'legacy' },
            { 'folke/neodev.nvim' },
            { 'SmiteshP/nvim-navbuddy' },
            { 'utilyre/barbecue.nvim' },
        },
        config = function()
            -- list of servers to install
            local servers = {
                lua_ls = {
                    Lua = {
                        workspace = {  },
                        telemetry = { enable = false },
                    },
                },
                pyright = {
                },
                texlab = {
                },
            }

            -- set up navic and navbuddy
            local on_attach = function(client, bufnr)
                client.server_capabilities.semanticTokensProvider = nil
                require('nvim-navic').attach(client, bufnr)
                require('nvim-navbuddy').attach(client, bufnr)
            end

            -- autocompletion capabilties
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            -- installing lsps
            local mason_lspconfig = require('mason-lspconfig')
            mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })
            mason_lspconfig.setup_handlers({
                function(server_name)
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = servers[server_name],
                    }
                end,
            })

            -- neodev for neovim development
            require('neodev').setup()
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
                    { name = 'buffer' },
                    { name = 'dictionary', keyword_length = 2 },
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


    ----------------- nvim-navic: winbar navigation -----------------
    {
        'SmiteshP/nvim-navic',
        dependencies = 'neovim/nvim-lspconfig',
        lazy = true
    },

    ------------- nvim-navbuddy: navigation pop-up menu -------------
    {
        'SmiteshP/nvim-navbuddy',
        dependencies = {
            'neovim/nvim-lspconfig',
            'SmiteshP/nvim-navic',
            'MunifTanjim/nui.nvim',
        },
        lazy = true,
        config = function()
            local border = 'single'
            if require('config.aesthetics').ui_borderless == true then
                border = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}
            end
            require('nvim-navbuddy').setup({
                window = {
                    size = { height = '30%', width = '100%' },
                    position = '100%',
                    sections = {
                        left = {
                            size = '33.33%',
                            border = border
                        },
                        mid = {
                            size = '33.33%',
                            border = border
                        },
                        right = {
                            preview = 'never',
                            border = border
                        }
                    },
                },
            })
        end
    },

    ---------------- lspsaga.nvim: more lsp features ----------------
    {
        'glepnir/lspsaga.nvim',
        event = 'LspAttach',
        config = function()
            require('lspsaga').setup({
                symbol_in_winbar = {
                    enable = false,
                }
            })
        end,
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    },

    --------------- barbecue: winbar location system ----------------
    {
        'utilyre/barbecue.nvim',
        name = 'barbecue',
        version = '*',
        dependencies = {
            'SmiteshP/nvim-navic',
            'nvim-tree/nvim-web-devicons',
        },
        event = 'VeryLazy',
        config = function()
            vim.opt.updatetime = 200

            require('barbecue').setup({
                create_autocmd = false,
                show_dirname = false,
                show_basename = true,
                show_modified = true,
            })

            vim.api.nvim_create_autocmd({
                'WinScrolled',
                'BufWinEnter',
                'CursorHold',
                'InsertLeave',
                'BufModifiedSet',
            }, {
                group = vim.api.nvim_create_augroup('barbecue.updater', {}),
                callback = function()
                    require('barbecue.ui').update()
                end,
            })
        end
    },
}

-----------------------------------------------------------------
