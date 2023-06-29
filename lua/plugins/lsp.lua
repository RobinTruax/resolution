--[[------------------- resolution v0.1.0 -----------------------

all plugins relating to LSP, autocompletion, snippets, etc.

-------------------------------------------------------------]]

return {

    ---------------- lspsaga.nvim: more lsp features ----------------
    {
        'glepnir/lspsaga.nvim',
        event = 'LspAttach',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lspsaga').setup({
                symbol_in_winbar = {
                    enable = false,
                }
            })
        end,
    },

    --------------- lsp-powered lua development tools ---------------
    {
        'folke/neodev.nvim',
        ft = { 'tex', 'py', 'lua' },
        dependencies = { 'neovim/nvim-lspconfig' },
        config = true,
    },

    --------- nvim-lspconfig: configuration of built-in lsp ---------
    {
        'neovim/nvim-lspconfig',
        ft = { 'tex', 'py', 'lua' },
        dependencies = {
            -- mason (installing and configuring LSPs)
            { 'williamboman/mason.nvim',          config = true, build = ":MasonUpdate" },
            { 'williamboman/mason-lspconfig.nvim' },
            -- fidget (LSP UI)
            { 'j-hui/fidget.nvim',                opts = {},     pin = true,            tag = 'legacy' },
            -- UIs aded on LSP attach
            { 'SmiteshP/nvim-navbuddy' },
            { 'utilyre/barbecue.nvim' },
        },
        config = function()
            -- navic and navbuddy's attachment
            local on_attach = function(client, bufnr)
                client.server_capabilities.semanticTokensProvider = nil
                require('nvim-navic').attach(client, bufnr)
                require('nvim-navbuddy').attach(client, bufnr)
            end

            -- list of servers to install
            local servers = {
                lua_ls = {
                    Lua = {
                        workspace = {},
                        telemetry = { enable = false },
                    },
                },
                texlab = {
                },
            }

            -- broadcast autocompletion capabilties to servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            -- install lsps
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
        end
    },

    ----------------- nvim-navic: winbar navigation -----------------
    {
        'SmiteshP/nvim-navic',
        lazy = true
    },

    ------------- nvim-navbuddy: navigation pop-up menu -------------
    {
        'SmiteshP/nvim-navbuddy',
        dependencies = {
            'SmiteshP/nvim-navic',
            'MunifTanjim/nui.nvim',
        },
        lazy = true,
        config = function()
            -- configure borders
            local border = 'single'
            if require('config.aesthetics').ui_borderless == true then
                border = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }
            end
            -- configure ui
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
            -- set update time
            vim.opt.updatetime = 200

            -- basic setup
            require('barbecue').setup({
                create_autocmd = false,
                show_dirname = false,
                show_basename = true,
                show_modified = true,
            })

            -- performance improvements
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
