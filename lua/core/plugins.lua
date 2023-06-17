--[[------------------- resolution v0.1.0 -----------------------

this file installs and calls lazy.nvim on the plugins folder

-------------------------------------------------------------]]--

-------------------------- directories --------------------------

local lazynvimpath = vim.fn.stdpath('config') .. '/lua/plugins/lazy.nvim'
local lazypluginpath = vim.fn.stdpath('config') .. '/lua/plugins/plugins'
local lazylockfile = vim.fn.stdpath('config') .. '/lua/plugins/lazy-lock.json'

----------------------- install lazy.nvim -----------------------

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

------------------------ include plugins ------------------------

require('lazy').setup('plugins',

---------------------------- options ----------------------------

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

-----------------------------------------------------------------
