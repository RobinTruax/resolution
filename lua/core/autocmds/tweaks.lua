--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

Autocommands with a few tweaks; some are original, some are from LazyVim.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

local prefs = require('config.preferences')

------------------------------ highlight on yank -------------------------------

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({
            timeout = 200,
            higroup = 'Visual'
        })
    end,
})

-------------------------- close some pop-ups with q ---------------------------

vim.api.nvim_create_autocmd('FileType', {
    pattern = {
        'spectre_panel',
        'lazygit',
        'startuptime',
        'checkhealth',
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set('n', 'q', '<cmd>close<cr>', {
            buffer = event.buf,
            silent = true
        })
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {
        '*term*',
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set('n', 'q', '<cmd>ToggleTerm<cr>', {
            buffer = event.buf,
            silent = true
        })
    end,
})

---------------------- refocus on vim when using synctex -----------------------

vim.cmd([[autocmd User VimtexEventView sleep 750m | call b:vimtex.viewer.xdo_focus_vim()]])

------------------------------ backup autocommand ------------------------------

if prefs.timestamp_backup then
    vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('timestamp_backupext', { clear = true }),
        desc = 'Add timestamp to backup extension',
        pattern = '*',
        callback = function()
            vim.opt.backupext = '-' .. vim.fn.strftime('%Y%m%d%H%M')
        end,
    })
end

--------------------------------------------------------------------------------
