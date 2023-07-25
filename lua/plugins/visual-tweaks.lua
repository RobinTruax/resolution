--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file includes and configures plugins that provide small visual tweaks.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

return {

    ------------------- todo-comments: highlighted todo comments -------------------

    {
        'folke/todo-comments.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = { 'nvim-lua/plenary.nvim' },

        -- configuration
        opts = {
            keywords = {
                FIX = {
                    icon = ' ',
                    color = 'error'
                },
                TODO = {
                    icon = ' ',
                    color = 'info'
                },
                WARN = {
                    icon = ' ',
                    color = 'warning'
                },
                NOTE = {
                    icon = ' ',
                    color = 'hint'
                },
                -- rsltn codebase
                FUTURE = {
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
                fg = 'NONE',
                bg = 'BOLD',
            },
            colors = {
                error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
                warning = { 'DiagnosticWarn', 'WarningMsg', '#FBBF24' },
                info = { 'DiagnosticInfo', '#2563EB' },
                hint = { 'DiagnosticHint', '#10B981' },
                default = { 'Identifier', '#7C3AED' },
                test = { 'Identifier', '#FF00FF' }
            },
        }
    },

    ----------------------------- ccc.nvim: colorizer ------------------------------

    {
        'uga-rosa/ccc.nvim',
        event = { 'BufReadPost', 'BufNewFile' },

        -- configuration
        config = function()
            local ccc = require('ccc')
            local aesthetics = require('config.aesthetics')
            local border = 'rounded'
            ccc.setup({
                win_opts = {
                    border = border,
                },
                highlighter = {
                    auto_enable = true,
                    lsp = true,
                },
            })
        end
    },

    ---------------- range-highlight.nvim: highlight cmdline ranges ----------------

    {
        'winston0410/range-highlight.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = { 'winston0410/cmd-parser.nvim' },

        -- configuration
        config = true
    },

    --------------- highlight-undo.nvim: highlight undo/redo actions ---------------

    {
        'tzachar/highlight-undo.nvim',
        event = { 'BufReadPost', 'BufNewFile' },

        -- configuration
        opts = {
            hlgroup = 'Visual',
            duration = 200,
            keymaps = {
                { 'n', 'u',     'undo', {} },
                { 'n', '<C-r>', 'redo', {} },
            }
        }
    },

    ------------------ modicator.nvim: color changing line number ------------------

    {
        'mawkler/modicator.nvim',
        event = { 'BufReadPost', 'BufNewFile' },

        -- configuration
        opts = {
            show_warnings = false,
        }
    },

}

--------------------------------------------------------------------------------
