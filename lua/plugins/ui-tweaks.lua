--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file includes and configures plugins that provide small UI tweaks.

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

    ------------------------- dressing.nvim: better vim ui -------------------------

    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',

        -- configuration
        config = function()
            require('dressing').setup({

                -- configuration of dressing's input UI
                input = {
                    insert_only = false,
                    start_in_insert = true,
                    border = 'rounded',
                    relative = 'cursor',
                    mappings = {
                        n = {
                            ['<q>'] = 'Close',
                            ['<CR>'] = 'Confirm',
                        },
                        i = {
                            ['<C-c>'] = 'Close',
                            ['<CR>'] = 'Confirm',
                            ['<Up>'] = 'HistoryPrev',
                            ['<Down>'] = 'HistoryNext',
                        },
                    },
                    get_config = function(opts)
                        if opts.relative ~= nil then
                            return {
                                relative = opts.relative
                            }
                        end
                    end
                },

                -- configuration of dressing's selection UI
                select = {
                    backend = { 'nui' },
                    nui = {
                        border = {
                            style = 'rounded',
                        },
                    },
                }
            })
        end
    },

    ----------------- nvim-notify: an updated notification system ------------------

    {
        'rcarriga/nvim-notify',
        lazy = true,

        -- configuration
        opts = {
            render = 'minimal',
            stages = 'fade',
            timeout = 100,
        }
    },

    ------------------ noice.nvim: a complete change to Neovim UI ------------------

    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },

        -- configuration
        opts = {
            cmdline = {
                view = 'cmdline',
            },
        }
    },

    ----------------------- vim-bbye: better buffer deletion -----------------------

    {
        'moll/vim-bbye',
        event = { 'BufReadPost', 'BufNewFile' },
    },

    -------------- bufresize.nvim: fixing split behavior with resizes --------------

    {
        'kwkarlwang/bufresize.nvim',
        event = { 'BufReadPost', 'BufNewFile' },

        -- configuration
        config = function()
            require('bufresize').setup()
        end
    },

    ------------------- smart-splits.nvim: better window splits --------------------

    {
        'mrjones2014/smart-splits.nvim',
        event = { 'BufReadPost', 'BufNewFile' },

        -- configuration
        config = function()
            require('smart-splits').setup({
                ignored_filetypes = {
                    'nofile',
                    'prompt',
                },
                ignore_buftypes = {
                    'NvimTree',
                    'ToggleTerm'
                },
                at_edge = 'split',
                default_amount = 3,
                move_cursor_same_row = false,
                cursor_follows_swapped_bufs = false,
                resize_mode = {
                    quit_key = '<Esc>',
                    resize_keys = { 'h', 'j', 'k', 'l' },
                    silent = true,
                    hooks = {
                        on_enter = nil,
                        on_leave = require('bufresize').register,
                    },
                },
                multiplexer_integration = false,
                ignored_events = {
                    'BufEnter',
                    'WinEnter',
                },
            })
        end
    },

}

--------------------------------------------------------------------------------
