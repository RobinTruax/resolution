--[[------------------- resolution v0.1.0 -----------------------

autocommands which help the startup screen

-------------------------------------------------------------]]--

local prefs = require('config.preferences')

-------------------- clearing startup screen --------------------
vim.api.nvim_create_autocmd(
    'BufEnter',
    {
        callback = function()
            vim.o.cmdheight = prefs.cmdheight
        end
    })
vim.api.nvim_create_autocmd(
    'FileType',
    {
        desc = 'Startup',
        pattern = 'startup',
        callback = function()
            vim.cmd('setlocal nospell')
            vim.cmd('setlocal cmdheight=0')
        end,
    })

