--[[------------------- resolution v0.1.0 -----------------------

defines keybinds for rsltn's secondary operations; no prefix

-------------------------------------------------------------]]--

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
    ['gd'] = {
        desc = '[g]oto [d]efinition',
        cmd = vim.lsp.buf.definition,
    },
    ['gr'] = {
        desc = '[g]oto [r]eferences',
        cmd = require('telescope.builtin').lsp_references,
    },
    ['gI'] = {
        desc = '[g]oto [I]mplementation',
        cmd = vim.lsp.buf.implementation,
    },
    ['gD'] = {
        desc = '[g]oto [D]eclaration',
        cmd = vim.lsp.buf.declaration,
    },
    ['gp'] = {
        desc = '[p]eek at definition',
        cmd = '<cmd> Lspsaga peek_definition <cr>',
    },
    ['<C-k>'] = {
        desc = 'hover documentation',
        cmd = vim.lsp.buf.hover,
    },
    ['<C-j>'] = {
        desc = 'signature documentation',
        cmd = vim.lsp.buf.signature_help,
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

-----------------------------------------------------------------
