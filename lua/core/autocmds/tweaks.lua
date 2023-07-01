--[[------------------- resolution v0.1.0 -----------------------

autocommands for any tweaks (mostly taken from LazyVim)

-------------------------------------------------------------]]--

local prefs = require('config.preferences')

-------------------------- highlight on yank -----------------------
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({
        timeout = 200,
        higroup = 'Visual'
    })
  end,
})

------------------- close some pop-ups with q -------------------
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'spectre_panel',
    'lazygit',
    'startuptime',
    'checkhealth',
    'NvimTree',
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

vim.cmd([[autocmd User VimtexEventView sleep 750m | call b:vimtex.viewer.xdo_focus_vim()]])

---------------------- backup autocommand -----------------------

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

-----------------------------------------------------------------
