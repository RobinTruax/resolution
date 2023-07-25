--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file includes and configures plugins which offer small tweaks to editing.

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

    ------------------ leap.nvim: in-window movement with Alt-f/t ------------------

    {
        'ggandor/leap.nvim',
        keys = {
            { '<M-f>', '<Esc><Plug>(leap-forward)',       mode = { 'n' },           desc = 'Leap forward', },
            { '<M-t>', '<Esc><Plug>(leap-forward-till)',  mode = { 'n' },           desc = 'Leap forward till' },
            { '<M-F>', '<Esc><Plug>(leap-backward)',      mode = { 'n' },           desc = 'Leap backward' },
            { '<M-T>', '<Esc><Plug>(leap-backward-till)', mode = { 'n' },           desc = 'Leap backward till' },
            { '<M-f>', '<Plug>(leap-forward)',            mode = { 'v', 'o', 'x' }, desc = 'Leap forward', },
            { '<M-t>', '<Plug>(leap-forward-till)',       mode = { 'v', 'o', 'x' }, desc = 'Leap forward till' },
            { '<M-F>', '<Plug>(leap-backward)',           mode = { 'v', 'o', 'x' }, desc = 'Leap backward' },
            { '<M-T>', '<Plug>(leap-backward-till)',      mode = { 'v', 'o', 'x' }, desc = 'Leap backward till' },
            { '<M-f>', '<Esc><Plug>(leap-forward)',       mode = { 'i' },           desc = 'Leap forward', },
            { '<M-t>', '<Esc><Plug>(leap-forward-till)',  mode = { 'i' },           desc = 'Leap forward till' },
            { '<M-F>', '<Esc><Plug>(leap-backward)',      mode = { 'i' },           desc = 'Leap backward' },
            { '<M-T>', '<Esc><Plug>(leap-backward-till)', mode = { 'i' },           desc = 'Leap backward till' },
        },

        -- configuration
        config = true
    },

    ----------------------- flit.nvim: extended f/t movement -----------------------

    {
        'ggandor/flit.nvim',
        keys = {
            { 'f', mode = { 'n', 'i', 'v', 'o', 'x' } },
            { 't', mode = { 'n', 'i', 'v', 'o', 'x' } },
            { 'F', mode = { 'n', 'i', 'v', 'o', 'x' } },
            { 'T', mode = { 'n', 'i', 'v', 'o', 'x' } }
        },

        -- configuration
        config = true,
    },

    ------------------------------ mini.align: aligns ------------------------------

    {
        'echasnovski/mini.align',
        event = { 'BufReadPost', 'BufNewFile' },

        -- configuration
        config = true,
    },

    ----------------- mini.move: manipulation of visual selections -----------------

    {
        'echasnovski/mini.move',
        event = { 'BufReadPost', 'BufNewFile' },

        -- configuration
        opts = {
            mappings = {
                left       = '<M-h>',
                right      = '<M-l>',
                down       = '<M-j>',
                up         = '<M-k>',
                line_left  = '',
                line_right = '',
                line_down  = '',
                line_up    = '',
            },
            options = {
                reindent_linewise = true,
            },
        }
    },

    ---------------------------- mini.ai: text objects -----------------------------

    {
        'echasnovski/mini.ai',
        event = { 'BufReadPost', 'BufNewFile' },

        -- configuration
        config = true,
    },

    ------------------- mini.surround: keybinds for surrounding --------------------

    {
        'echasnovski/mini.surround',
        event = { 'BufReadPost', 'BufNewFile' },

        -- configuration
        config = true,
    },

    --------------------------- Comment.nvim: commenting ---------------------------

    {
        'numToStr/Comment.nvim',
        keys = {
            { 'gcc', mode = { 'n' },           desc = 'Toggle comment on line' },
            { 'gbc', mode = { 'n' },           desc = 'Toggle comment block' },
            { 'gco', mode = { 'n' },           desc = 'Add comment on line above' },
            { 'gc0', mode = { 'n' },           desc = 'Add comment on line below' },
            { 'gcA', mode = { 'n' },           desc = 'Add comment at end of line' },
            { 'gc',  mode = { 'v', 'o', 'x' }, desc = 'Toggle comment (visual)' },
            { 'gb',  mode = { 'v', 'o', 'x' }, desc = 'Toggle block comment (visual)' },
        },

        -- configuration
        config = true,
    },

}

--------------------------------------------------------------------------------
