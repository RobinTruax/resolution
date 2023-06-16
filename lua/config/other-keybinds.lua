--[[
resolution v0.1.0
this file defines the keybinds for secondary options
--]]

------------------------- other keybinds ------------------------
return {
    ['<Alt-h>'] = {
        desc = 'Move left',
        cmd = '<Left>',
        mode = 'i',
    },
    ['<Alt-j>'] = {
        desc = 'Move down',
        cmd = '<Down>',
        mode = 'i',
    },
    ['<Alt-k>'] = {
        desc = 'Move up',
        cmd = '<Up>',
        mode = 'i',
    },
    ['<Alt-l>'] = {
        desc = 'Move right',
        cmd = '<Right>',
        mode = 'i',
    },
    ['<C-s>'] = {
        desc = 'Save file',
        cmd = {'<cmd>w<cr>', '<Esc><cmd>w<cr>a'},
        mode = {'n', 'i'},
    },
    ['<cr>'] = {
        desc = 'Clear highlighting',
        cmd = '<Esc>:noh<cr><cr>',
        mode = 'n',
        opts = {silent = true},
    },
    ['<Esc>'] = {
        desc = 'Fixing escape in terminal',
        cmd = {'<C-\\><C-n>'},
        mode = {'t'},
        opts = {silent = true, noremap = true},
    },
    ['H'] = {
        desc = 'Move to left window',
        cmd = '<C-w>h',
        {silent = true, noremap = true},
    },
    ['J'] = {
        desc = 'Move to below window',
        cmd = '<C-w>j',
        {silent = true, noremap = true},
    },
    ['K'] = {
        desc = 'Move to above window',
        cmd = '<C-w>k',
        {silent = true, noremap = true},
    },
    ['L'] = {
        desc = 'Move to right window',
        cmd = '<C-w>l',
        {silent = true, noremap = true},
    },
    ["'"] = {
        desc = 'Blackhole delete',
        cmd = '"_',
        mode = {'n', 'v'},
    },
    ['g'] = {
        desc = '+Movement and other',
        cmd = false,
    },
    ['gb'] = {
        desc = '+Comment block',
        cmd = false,
    },
    ['gc'] = {
        desc = '+Comments',
        cmd = false,
    },
    ['['] = {
        desc = '+Movement (prev)',
        cmd = false,
    },
    [']'] = {
        desc = '+Movement (next)',
        cmd = false,
    },
    ['s'] = {
        desc = '+Surround',
        cmd = false,
    },
    ['z'] = {
        desc = '+Folds and spelling',
        cmd = false,
    },
}
