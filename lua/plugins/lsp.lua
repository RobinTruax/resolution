--[[------------------- resolution v0.1.0 -----------------------

all plugins relating to LSP, autocompletion, snippets, etc.

-------------------------------------------------------------]]

return {

    ---------------- lspsaga.nvim: more lsp features ----------------
    {
        'glepnir/lspsaga.nvim',
        event = 'VeryLazy',
        dependencies = { 'nvim-tree/nvim-web-devicons', 'neovim/nvim-lspconfig' },
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
        ft = { 'lua' },
        dependencies = { 'neovim/nvim-lspconfig' },
        config = true,
    },

    --------- nvim-lspconfig: configuration of built-in lsp ---------
    {
        'neovim/nvim-lspconfig',
        -- ft = { 'tex', 'py', 'lua', 'json' },
        event = 'VeryLazy',
        dependencies = {
            -- mason (installing and configuring LSPs)
            { 'williamboman/mason.nvim',          config = true, build = ":MasonUpdate" },
            { 'williamboman/mason-lspconfig.nvim' },
            -- UIs aded on LSP attach
            { 'SmiteshP/nvim-navbuddy' },
            { 'utilyre/barbecue.nvim' },
            -- autocompletion connection
            { 'hrsh7th/cmp-nvim-lsp' },
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
                texlab = {},
                jsonls = {},
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

            -- fixing lsp diagnostics
            -- source: https://github.com/neovim/nvim-lspconfig/issues/726

            -- filter
            local function filter(arr, func)
                local new_index = 1
                local size_orig = #arr
                for old_index, v in ipairs(arr) do
                    if func(v, old_index) then
                        arr[new_index] = v
                        new_index = new_index + 1
                    end
                end
                for i = new_index, size_orig do arr[i] = nil end
            end

            -- actual filter
            local function filter_diagnostics(diagnostic)
                if diagnostic.source ~= "Pyright" then
                    return true
                end
                if string.find(diagnostic.message, 'is not defined') then
                    return false
                end
                return true
            end

            -- new publish diagnostics function
            local function custom_on_publish_diagnostics(a, params, client_id, c, config)
                filter(params.diagnostics, filter_diagnostics)
                vim.lsp.diagnostic.on_publish_diagnostics(a, params, client_id, c, config)
            end

            -- assert new publish diagnostics function
            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                custom_on_publish_diagnostics, {})
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
            local border = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }
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
