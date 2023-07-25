--[[--------------------------- resolution v0.1.0 ------------------------------

resolution is a Neovim config for writing TeX and doing computational math.

This file installs and calls lazy.nvim on the plugins folder.

Copyright (C) 2023 Roshan Truax

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) at any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

------------------------------------------------------------------------------]]

--------------------------------- directories ----------------------------------

local lazynvimpath = vim.fn.stdpath('config') .. '/lua/plugins/lazy.nvim'
local lazypluginpath = vim.fn.stdpath('config') .. '/lua/plugins/plugins'
local lazylockfile = vim.fn.stdpath('config') .. '/lua/plugins/lazy-lock.json'

------------------------------ install lazy.nvim -------------------------------

if not vim.loop.fs_stat(lazynvimpath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazynvimpath,
    })
end
vim.opt.rtp:prepend(lazynvimpath)

------------------------------- include plugins --------------------------------

require('lazy').setup('plugins',

----------------------------------- options ------------------------------------

    {
    change_detection = {
        enabled = false,
        notify = false
    },
    root = lazypluginpath,
    lockfile = lazylockfile,
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                '2html_plugin',
                'getscript',
                'getscriptPlugin',
                'gzip',
                'logipat',
                'netrw',
                'netrwPlugin',
                'netrwSettings',
                'netrwFileHandlers',
                'matchit',
                'tar',
                'tarPlugin',
                'rrhelper',
                'spellfile_plugin',
                'vimball',
                'vimballPlugin',
                'zip',
                'zipPlugin',
            },
        },
    },
})

--------------------------------------------------------------------------------
