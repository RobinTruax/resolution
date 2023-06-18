--[[------------------- resolution v0.1.0 -----------------------

defines keybinds for rsltn's secondary operations; no prefix

-------------------------------------------------------------]]

return {

    --------------------- manipulating windows ----------------------
    ['<C-h>'] = {
        desc = 'Move left',
        cmd = require('smart-splits').move_cursor_left,
        mode = 'n',
    },
    ['<C-j>'] = {
        desc = 'Move down',
        cmd = require('smart-splits').move_cursor_down,
        mode = 'n',
    },
    ['<C-k>'] = {
        desc = 'Move up',
        cmd = require('smart-splits').move_cursor_up,
        mode = 'n',
    },
    ['<C-l>'] = {
        desc = 'Move right',
        cmd = require('smart-splits').move_cursor_right,
        mode = 'n',
    },
    ['<A-h>'] = {
        desc = 'Move left',
        cmd = { require('smart-splits').resize_left, '<Left>' },
        mode = { 'n', 'i' },
    },
    ['<A-j>'] = {
        desc = 'Move down',
        cmd = { require('smart-splits').resize_down, '<Down>' },
        mode = { 'n', 'i' },
    },
    ['<A-k>'] = {
        desc = 'Move up',
        cmd = { require('smart-splits').resize_up, '<Up>' },
        mode = { 'n', 'i' },
    },
    ['<A-l>'] = {
        desc = 'Move right',
        cmd = { require('smart-splits').resize_right, '<Right>' },
        mode = { 'n', 'i' },
    },
    ['<C-Left>'] = {
        desc = 'Move left',
        cmd = require('smart-splits').move_cursor_left,
        mode = 'n',
    },
    ['<C-Down>'] = {
        desc = 'Move down',
        cmd = require('smart-splits').move_cursor_down,
        mode = 'n',
    },
    ['<C-Up>'] = {
        desc = 'Move up',
        cmd = require('smart-splits').move_cursor_up,
        mode = 'n',
    },
    ['<C-Right>'] = {
        desc = 'Move right',
        cmd = require('smart-splits').move_cursor_right,
        mode = 'n',
    },
    ['<A-Left>'] = {
        desc = 'Move left',
        cmd = { require('smart-splits').resize_left, '<Left>' },
        mode = { 'n', 'i' },
    },
    ['<A-Down>'] = {
        desc = 'Move down',
        cmd = { require('smart-splits').resize_down, '<Down>' },
        mode = { 'n', 'i' },
    },
    ['<A-Up>'] = {
        desc = 'Move up',
        cmd = { require('smart-splits').resize_up, '<Up>' },
        mode = { 'n', 'i' },
    },
    ['<A-Right>'] = {
        desc = 'Move right',
        cmd = { require('smart-splits').resize_right, '<Right>' },
        mode = { 'n', 'i' },
    },

    ---------------------- manipulate buffers -----------------------
    ['H'] = {
        desc = 'Move to next buffer',
        cmd = '<cmd>bp<cr>',
        { silent = true, noremap = true },
    },
    ['L'] = {
        desc = 'Move to prev buffer',
        cmd = '<cmd>bn<cr>',
        { silent = true, noremap = true },
    },

    --------------------------- LSP gotos ---------------------------
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

    --------------------------- LSP other ---------------------------
    ['K'] = {
        desc = 'hover documentation',
        cmd = vim.lsp.buf.hover,
    },
    ['J'] = {
        desc = 'signature documentation',
        cmd = vim.lsp.buf.signature_help,
    },

    ----------------------------- other -----------------------------

    ["'"] = {
        desc = 'Blackhole delete',
        cmd = '"_',
        mode = { 'n', 'v' },
    },
    ['<C-s>'] = {
        desc = 'Save file',
        cmd = { '<cmd>w<cr>', '<Esc><cmd>w<cr>a' },
        mode = { 'n', 'i' },
    },
    ['<cr>'] = {
        desc = 'Clear highlighting',
        cmd = '<Esc>:noh<cr><cr>',
        mode = 'n',
        opts = { silent = true },
    },
    ['<Esc>'] = {
        desc = 'Fixing escape in terminal',
        cmd = { '<C-\\><C-n>' },
        mode = { 't' },
        opts = { silent = true, noremap = true },
    },

    --------------------------- prefixes ----------------------------
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
