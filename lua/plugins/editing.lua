--[[------------------- resolution v0.1.0 -----------------------

plugins which offer small tweaks to the editing experience

---------------------------------------------------------------]]


return {
    ---------- leap.nvim: in-window movement with Alt-f/t -----------
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
        config = true
    },

    --------------- flit.nvim: extended f/t movement ----------------
    {
        'ggandor/flit.nvim',
        keys = {
            { 'f', mode = { 'n', 'i', 'v', 'o', 'x' } },
            { 't', mode = { 'n', 'i', 'v', 'o', 'x' } },
            { 'F', mode = { 'n', 'i', 'v', 'o', 'x' } },
            { 'T', mode = { 'n', 'i', 'v', 'o', 'x' } }
        },
        config = true,
    },

    ---------------------- mini.align: aligns -----------------------
    {
        'echasnovski/mini.align',
        event = { 'BufReadPost', 'BufNewFile' },
        config = true,
    },

    ----------------------- mini.move: aligns -----------------------
    {
        'echasnovski/mini.move',
        event = { 'BufReadPost', 'BufNewFile' },
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

    --------------------- mini.ai: text objects ---------------------
    {
        'echasnovski/mini.ai',
        event = { 'BufReadPost', 'BufNewFile' },
        config = true,
        -- config = function()
        --     local nn = require("notebook-navigator")
        --     local ai = require("mini.ai")
        --     ai.setup({
        --         custom_textobjects = {
        --             h = nn.miniai_spec,
        --         },
        --     })
        -- end,
    },

    ------------ mini.surround: keybinds for surrounding ------------
    {
        'echasnovski/mini.surround',
        event = { 'BufReadPost', 'BufNewFile' },
        config = true,
    },

    ------------------- Comment.nvim: commenting --------------------
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
        config = true,
    },
}

-----------------------------------------------------------------
