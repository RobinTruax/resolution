--[[------------------- resolution v0.1.0 -----------------------

all ui tweaks and improvements which rsltn adds

-------------------------------------------------------------]]

return {

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
