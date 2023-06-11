return {
    -- todo-comments: highlighted todo comments
    {
        'folke/todo-comments.nvim',
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        opts = {
            keywords = {
                -- rsltn codebase
                FIX = {
                    icon = " ",
                    color = "error"
                },
                TODO = {
                    icon = " ",
                    color = "info"
                },
                WARN = {
                    icon = " ",
                    color = "warning"
                },
                NOTE = {
                    icon = " ",
                    color = "hint"
                },
                FIGURES = {
                    icon = ' ',
                    color = 'info',
                },
                COMP = {
                    icon = ' ',
                    color = 'info',
                },

                -- TeX
                FIGURE = {
                    icon = ' ',
                    color = 'info'
                },
                CITE = {
                    icon = ' ',
                    color = 'hint'
                },
                PROVE = {
                    icon = ' ',
                    color = 'error'
                },
            },
            gui_style = {
                fg = "NONE", -- gui style to use for the fg highlight group.
                bg = "BOLD", -- gui style to use for the bg highlight group.
            },
            colors = {
                error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
                warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
                info = { "DiagnosticInfo", "#2563EB" },
                hint = { "DiagnosticHint", "#10B981" },
                default = { "Identifier", "#7C3AED" },
                test = { "Identifier", "#FF00FF" }
            },
        }
    },

    -- nvim-colorizer: coloring highlights
    {
        'NvChad/nvim-colorizer.lua',
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require('colorizer').setup({
                user_default_options = {
                    RGB = true,
                    RRGGBB = true,
                    names = false,
                    RRGGBBAA = false,
                    AARRGGBB = false,
                    rgb_fn = false,
                    hsl_fn = false,
                    css = false,
                    css_fn = false,
                    mode = "background",
                    tailwind = false,
                    sass = { enable = false, parsers = { "css" }, },
                    always_update = false
                }
            })
        end
    },

    -- markdown-preview.nvim: live markdown previewing
    {
        'iamcco/markdown-preview.nvim',
        ft = 'md',
        build = function()
            vim.fn['mkdp#util#install']()
        end,
        config = function()
            vim.g.mkdp_auto_close = 0
        end
    },

    -- range-highlight.nvim: highlight cmdline ranges
    {
        'winston0410/range-highlight.nvim',
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            'winston0410/cmd-parser.nvim',
        },
        config = true
    },

    -- toggleterm.nvim: a better terminal
    {
        'akinsho/toggleterm.nvim',
        cmd = 'ToggleTerm',
        config = true
    },

    -- modicator.nvim: color changing line number -- TODO: Align with lualine.
    {
        'mawkler/modicator.nvim',
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {'folke/tokyonight.nvim'},
        config = function()
            require('modicator').setup()

            local ModicatorColors = {
                NormalMode   = { fg = '#82aaff' },
                InsertMode   = { fg = '#c3e88d' },
                VisualMode   = { fg = '#c099ff' },
                CommandMode  = { fg = '#ffc777' },
                ReplaceMode  = { fg = '#ff757f' },
                TerminalMode = { fg = '#4fd6be' },
                SelectMode   = { fg = '#c099ff' },
            }

            for hl, col in pairs(ModicatorColors) do
                vim.api.nvim_set_hl(0, hl, col)
            end
        end
    }
}
