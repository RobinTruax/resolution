local prefs = require('config.preferences')

vim.api.nvim_create_autocmd(
    'BufEnter',
    {
        callback = function()
            vim.o.cmdheight = prefs.cmdheight
        end
    })

-- ensure that there is no spell check or command line on startup screen
vim.api.nvim_create_autocmd(
    'FileType startup',
    {
        callback = function ()
            vim.o.cmdheight = 0
            vim.wo.spell = false
        end
    })
