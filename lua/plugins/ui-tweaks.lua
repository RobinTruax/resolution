--[[------------------- resolution v0.1.0 -----------------------

all ui tweaks and improvements which rsltn adds

-------------------------------------------------------------]]

return {


    ----------------- dressing.nvim: better vim ui ------------------
    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
        config = function()
            local border = 'rounded'
            require('dressing').setup({
                input = {
                    insert_only = false,
                    start_in_insert = true,
                    border = border,
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
                select = {
                    backend = { 'nui' },
                    nui = {
                        border = {
                            style = border,
                        },
                    },
                }
            })
        end
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    },

    {
        "rcarriga/nvim-notify",
        lazy = true,
        opts = {
            render = 'minimal',
            stages = 'fade',
            timeout = 100,
        }
    },

    --------------- vim-bbye: better buffer deletion ----------------
    {
        'moll/vim-bbye',
        event = { 'BufReadPost', 'BufNewFile' },
    },

    ------ bufresize.nvim: fixing split behavior with resizes -------

    {
        'kwkarlwang/bufresize.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        config = function()
            require('bufresize').setup()
        end
    },

    ------------ smart-splits.nvim: better window splits ------------
    {
        'mrjones2014/smart-splits.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
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

-----------------------------------------------------------------
